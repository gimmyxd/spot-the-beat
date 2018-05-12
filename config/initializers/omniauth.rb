require 'rspotify/oauth'

spotify_creds = Rails.application.credentials.spotify
auth_scopes   = %w(
  user-top-read
  user-follow-read
  user-read-private
  user-read-email
  user-read-birthdate
)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, spotify_creds[:client_id], spotify_creds[:client_secret], scope: auth_scopes.join(' ')
end
