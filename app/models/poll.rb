class Poll < Askable
  has_many :ballots,          :foreign_key => 'askable_id', :dependent => :destroy
  has_many :results

  def to_s
    str = self.body
    
    unless self.simple?
      unless self.or_negative?
        str << " #{ self.yes }"
      end

      str << " or #{ self.no }?"
    end

    return str
  end
  
  def simple?
    self.yes == I18n.t('m_yes') && self.no == I18n.t('m_no')
  end

  def or_negative?
    self.yes == I18n.t('m_yes') && self.no != I18n.t('m_no')
  end

  def answer_complex(current_user_id, last_ballot_id, n = Complex_Number)
    is_end = false
    complex = []
    index = 0

    cond = last_ballot_id.blank? ? '1 = 1' : ['answerables.updated_at < ?', Ballot.find(last_ballot_id).updated_at]

    all = self.ballots.where(cond).order('answerables.updated_at DESC')

    # NOTE not user >=, since when in case when no answer, needs to stay on 'n' to load all of them
    until complex.size > n || index > (all.size - 1)
      # ballot has an answer or is from the current user
      if all[index].body.present? || all[index].user_id == current_user_id
        break if complex.size >= n # break the block when complex is full, necessary see the NOTE
        complex << all[index]
      else
        # if complex is empty or a ballot with answer was just inserted,
        # create a placeholder for all later ballots with not answers
        complex << { all[index].vote => Array.new } if complex.blank? || complex.last.kind_of?(Ballot) || complex.last.keys[0] != all[index].vote
        complex.last.values[0] << all[index]
      end

      index += 1
    end

    is_end = true if index >= (all.size - 1) #all ballots have been checked, so there is no more to load

    return complex.first(n), is_end
  end
  
  def translate(from, to)
    array = [ self.body ]
    array << (self.yes == I18n.t('m_yes') ? '' : self.yes)
    array << (self.no == I18n.t('m_no') ? '' : self.no)
    array << (self.description.blank? ? '' : self.description)
    
    # Using google translate
    result = EasyTranslate.translate(array, from: from, to: to)
    
    self.save_translation(result, to)
  end
  
  def save_translation(array, locale)
    self.transaction do
      I18n.with_locale(locale) do
        self.update_attributes!(
          body: array[0],
          yes: array[1].blank? ? I18n.t('m_yes') : array[1],
          no: array[2].blank? ? I18n.t('m_no') : array[2],
          description: array[3].blank? ? nil : array[3],
          auto_translated: 'true'
        )
      end
    
      # when translating a poll, add the new locale to its event log
      # so that we will know it can be listed for the locale
      e = self.events.new_poll.first
      e.update_attributes!({:locales => "#{ e.locales } #{ locale }"})
    end
  end

  def build_answerable(user, answerable)
    user.answerables.ballots.build(
      :askable_id => answerable[:askable_id],
      :country_code => answerable[:country_code],
      :vote => answerable[:vote].to_i,
      :body => answerable[:body]
    )
  end
end
