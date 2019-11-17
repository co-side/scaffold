# frozen_string_literal: true

# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  require 'devise/orm/active_record'
  config.omniauth :google_oauth2,
                  ENV['GOOGLE_APP_ID'],
                  ENV['GOOGLE_APP_SECRET'],
                  name: :google,
                  scope: %w(email)

  config.warden do |manager|
    manager.failure_app = CustomFailure
  end
end
