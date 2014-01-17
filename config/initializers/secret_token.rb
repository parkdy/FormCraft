# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

# In production environment (Heroku)
# Set secret token by entering the command:
# heroku config:set SECRET_TOKEN=`rake secret`

# or add it to 'config/application.yml':
# SECRET_TOKEN: <insert secret token>

FormCraft::Application.config.secret_token =
  (Rails.env.production? ? ENV["SECRET_TOKEN"] : 'a'*30)