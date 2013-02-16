module PollHelper
  def question_answers(poll)
    str = poll.question
    
    unless poll.simple?
      unless poll.or_negative?
        str << " #{truncate(poll.yes.capitalize, :separator => ' ')}"
      end
      
      str << " or #{truncate(poll.no.capitalize, :separator => ' ')}?"
    end
    
    str
  end
end
