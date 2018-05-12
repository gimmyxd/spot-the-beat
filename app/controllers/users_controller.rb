require 'rspotify'

class UsersController < ApplicationController
  def spotify
    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # Now you can access user's private data, create playlists and much more

    # Access private data
    @spotify_user.country #=> "US"
    Rails.logger.info @spotify_user.to_hash
    #
    # user = User.new do |u|
    #   u.email = @spotify_user.email   #=> "example@email.com"
    # end
    # user.save

    Rails.logger.info(@spotify_user.top_artists.first.images.first['url'])

    render "dashboard/index"
  end
end
