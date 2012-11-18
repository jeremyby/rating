class UserSession < Authlogic::Session::Base
  generalize_credentials_error_messages "Your account information is not vaild."
end