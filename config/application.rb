require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ddp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.autoload_paths += Dir["#{Rails.root}/app/**/"]

    config.time_zone = 'Central America'
    config.i18n.default_locale = :es
    config.encoding = 'utf-8'

    config.to_prepare do
      Devise::SessionsController.layout false
      Devise::RegistrationsController.layout false
      Devise::PasswordsController.layout false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
