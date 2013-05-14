class Poll < Askable
  scope :has_result, where(' yes_count > no_count ')
  
  has_many :ballots, :foreign_key => 'askable_id'
  has_many :polling_numbers
  
  def to_s(truncate = true)
    str = String.new(self.body)

    unless self.simple?
      unless self.or_negative?
        str << " #{ truncater(self.yes, truncate) }"
      end

      str << " or #{ truncater(self.no, truncate) }?"
    end

    return str
  end
  
  def truncater(ans, flag)
    flag ? ans.truncate(30, :separator => ' ') : ans
  end

  def simple?
    self.yes == 'Yes' && self.no == 'No'
  end

  def or_negative?
    self.yes == 'Yes' && self.no != 'No'
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
      :body => answerable[:body]
    )
  end
end
