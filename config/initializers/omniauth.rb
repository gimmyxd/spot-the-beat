<<<<<<< HEAD
spotfiy_creds = Rails.application.credentials.spotify
auth_scopes = %w(
  user-top-read
  user-follow-read
  user-read-private
  user-read-email
  user-read-birthdate
)

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, spotfiy_creds[:client_id], spotfiy_creds[:client_secret], scope: auth_scopes
end
=======
require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify,
           ENV['SPOTIFY_CLIENT_ID'],
           ENV['SPOTIFY_CLIENT_SECRET'],
           {
               scope: 'user-read-email playlist-modify-public user-library-read user-library-modify user-top-read'
           }
end
>>>>>>> master
