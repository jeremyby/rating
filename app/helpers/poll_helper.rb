module PollHelper
  def new_poll_validation_error
    error_msg = ''

    error_msg << 'Please select a valid country to ask the question. ' if @poll.errors[:country_code].present?
    error_msg << "The question #{@poll.errors[:question][0]}." if @poll.errors[:question].present?
    
    return error_msg
  end
end
