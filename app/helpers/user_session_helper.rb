module UserSessionHelper
  def login_validation_error
    if @user_session.errors[:base].present?
      form_error = ['base', @user_session.errors[:base][0]]
      @user_session.errors[:email] = @user_session.errors[:password] = ['just to fire up error marking']
    else
      @user_session.errors.messages.each do |e|
        if e[1].present?
          form_error = [e[0].to_s, "#{e[0].capitalize} #{e[1][0]}."]
        end
      end
    end
    
    form_error[1]
  end
end
