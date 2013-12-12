class UserMailer < ActionMailer::Base
  default from: "notifications@example.com"

  def activation_email(user)
  	@user = user
  	@activation_url = activate_user_url(user, activation_token: user.activation_token)

  	mail(to: user.email, subject: "Activate your FormBuilder account!")
  end
end
