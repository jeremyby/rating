module UserSessionHelper
  def login_validation_error
    if @user_session.errors[:base].present?
      error_message = @user_session.errors[:base][0]
      @user_session.errors[:email] = @user_session.errors[:password] = ['just to fire up error display for email field']
    else
      e = @user_session.errors.messages.first

      error_message = "#{e[0].capitalize} #{e[1][0]}." if e[1].present?
    end
    
    return error_message
  end
end
