class User < ApplicationRecord

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.email
      user.avatar_url = auth.info.images.first.url if auth&.info&.images&.first
      user.spotify_data=auth.to_json if auth.provider == 'spotify'
      user.uber_data=auth.to_json if auth.provider == 'uber'
    end
  end

  def username
    uid
  end
end
