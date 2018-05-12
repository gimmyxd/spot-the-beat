class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_spotify_user
  helper_method :user_signed_in?

  protected

  def current_user
    @current_user ||= User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    @current_user = nil
  end

  def current_spotify_user
    @current_spotify_user ||= RSpotify::User.new(session[:auth_data])
  end

  def user_signed_in?
    current_user.present?
  end
end
