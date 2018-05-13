require 'rspotify/oauth'
require 'omniauth-uber'
spotify_creds = Rails.application.credentials.spotify
spotify_auth_scopes   = %w(
  user-top-read
  user-follow-read
  user-read-private
  user-read-email
  user-read-birthdate
)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, spotify_creds[:client_id], spotify_creds[:client_secret], scope: spotify_auth_scopes.join(' ')
  provider :uber, ENV['UBER_CLIENT_ID'], ENV['UBER_CLIENT_SECRET'], scope: 'delivery profile'
end
