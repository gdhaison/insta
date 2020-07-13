# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end
require "instagram"
Instagram.configure do |config|
  config.client_id = "client_id goes here"
  config.access_token = "access_token goes here"
end
