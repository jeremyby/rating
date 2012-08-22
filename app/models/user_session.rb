class UserSession < Authlogic::Session::Base  
  # before_validation :check_presence
  # 
  # # generalize_credentials_error_messages true
  # 
  # private
  #   def check_presence
  #     errors.add(:email, "can't be blank") if email.blank?
  #     errors.add(:password, "can't be blank") if password.blank?
  # end
end