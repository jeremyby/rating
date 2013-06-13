class Question < Askable
  has_many :answers, :foreign_key => 'askable_id', :dependent => :destroy

  def answer_complex(current_user_id, last_ballot_id, n = Complex_Number)
    is_end = true

    cond = last_ballot_id.blank? ? '1 = 1' : ['answerables.updated_at < ?', Answerable.find(last_ballot_id).updated_at]

    all = self.answers.where(cond).limit(n + 1).order('updated_at DESC')

    is_end = false if all.size > n

    return all.first(n), is_end
  end

  def build_answerable(user, answerable)
    user.answerables.answers.build(
      :poll_id => answerable[:askable_id],
      :country_code => answerable[:country_code],
      :answer => answerable[:body]
    )
  end
end
