require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pediditos
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.assets.precompile += %w( entidades.js pedidos.js)
    config.active_record.raise_in_transactional_callbacks = true
    config.sms_api = ENV["SMS_API"]
    config.sms_auth_id = ENV["SMS_AUTH_ID"]
    config.sms_auth_token = ENV["SMS_AUTH_TOKEN"]
    config.sms_src_number = ENV['SMS_SRC_NUMBER']
    config.sms_prefix = ENV['SMS_PREFIX']
    config.nombre_sitio = "ENV['NOMBRE_SITIO']"
    config.usuario_id_admin = '1'
    config.sms_habilitado = true
    config.paperclip_defaults = {
      :storage => :s3,
      :s3_credentials => {
        :bucket => ENV['S3_BUCKET_NAME'],
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
      }
    }
    config.default_entidad_image = "/assets/avatar-not-found.png"
  end
end

