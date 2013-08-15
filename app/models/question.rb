class Question < Askable
  has_many :answers, :foreign_key => 'askable_id', :dependent => :destroy
    
  def to_s
    self.body
  end

  def answer_complex(current_user_id, last_ballot_id, n = Complex_Number)
    is_end = true

    cond = last_ballot_id.blank? ? '1 = 1' : ['answerables.updated_at < ?', Answerable.find(last_ballot_id).updated_at]

    all = self.answers.where(cond).limit(n + 1).order('updated_at DESC')

    is_end = false if all.size > n

    return all.first(n), is_end
  end
  
  def build_answerable(user, answerable)
    user.answerables.answers.build(
      :askable_id => answerable[:askable_id],
      :country_code => answerable[:country_code],
      :body => answerable[:body]
    )
  end
  
  def should_update?(params)
    params[:body] != self.body || params[:description] != self.description
  end
  
  def translate(from, to, is_update = false)
    array = [ self.body ]
    array << (self.description.blank? ? '' : self.description)
  
  # Using google translate
    result = EasyTranslate.translate(array, from: from, to: to)
  
    self.save_translation(result, to, is_update)
  end
  
  def save_translation(array, locale, is_update = false)
    self.transaction do
      I18n.with_locale(locale) do
        self.body = HTMLCoder.decode(array[0])
        self.description = array[1].blank? ? nil : HTMLCoder.decode(array[1])
        self.auto_translated = true
        
        self.save!
      end
    
      self.add_locale_to_event(locale) unless is_update
    end
  end
end
