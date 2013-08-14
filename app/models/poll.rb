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
    self.yes == I18n.t('ans_yes') && self.no == I18n.t('ans_no')
  end

  def or_negative?
    self.yes == I18n.t('ans_yes') && self.no != I18n.t('ans_no')
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
  
  def build_answerable(user, answerable)
    user.answerables.ballots.build(
      :askable_id => answerable[:askable_id],
      :country_code => answerable[:country_code],
      :vote => answerable[:vote].to_i,
      :body => answerable[:body].blank? ? nil : answerable[:body]
    )
  end
  
  def translate(from, to, is_update = false)
    array = [ self.body ]
    array << (self.yes == I18n.t('ans_yes') ? '' : self.yes)
    array << (self.no == I18n.t('ans_no') ? '' : self.no)
    array << (self.description.blank? ? '' : self.description)
    
    # Using google translate
    result = EasyTranslate.translate(array, from: from, to: to)
    
    self.save_translation(result, to, is_update)
  end
  
  def save_translation(array, locale, is_update = false)
    self.transaction do
      I18n.with_locale(locale) do
        self.body = HTMLCoder.decode(array[0])
        self.yes = array[1].blank? ? I18n.t('ans_yes') : HTMLCoder.decode(array[1])
        self.no = array[2].blank? ? I18n.t('ans_no') : HTMLCoder.decode(array[2])
        self.description = array[3].blank? ? nil : HTMLCoder.decode(array[3])
        self.auto_translated = true
        
        self.save!
      end
      
      self.add_locale_to_event(locale) unless is_update
    end
  end
end
