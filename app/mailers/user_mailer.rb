class UserMailer < ActionMailer::Base
  default from: "mailer@askac.co"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(u)
    @user = u
    mail :to => u.email
  end
end
