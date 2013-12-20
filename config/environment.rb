# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
FormCraft::Application.initialize!



# Sendgrid

if Rails.env.production?
  # only send real emails in production; use Sengrid
  ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => 'heroku.com'
  }
  ActionMailer::Base.delivery_method ||= :smtp
elsif Rails.env.development?
  # This gem won't send real emails
  # It just opens them in another tab.
  ActionMailer::Base.delivery_method = :letter_opener
end