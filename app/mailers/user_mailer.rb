class UserMailer < ActionMailer::Base
  default from: "notifications@example.com"

  def activation_email(user)
  	@user = user
  	@activation_url = activate_user_url(user, activation_token: user.activation_token)

  	mail(to: user.email, subject: "Activate your FormCraft account")
  end

  def recovery_email(user)
  	@user = user
  	@recovery_url = reset_password_user_url(user, recovery_token: user.recovery_token)

  	mail(to: user.email, subject: "Recover your FormCraft account")
  end
end
