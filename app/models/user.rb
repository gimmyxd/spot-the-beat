class User < ApplicationRecord

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.avatar_url = auth.info.images.first.url if auth&.info&.images&.first
    end
  end

  def username
    uid
  end
end
