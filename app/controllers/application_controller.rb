require_relative '../../app/models/uber_helper'

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_spotify_user
  helper_method :user_signed_in?
  helper_method :uber_token
  helper_method :uber_products

  rescue_from RestClient::Forbidden do |_|
    redirect_to root_url
  end

  protected

  def current_user
    @current_user ||= User.find_by(email: session[:email])
  rescue ActiveRecord::RecordNotFound
    @current_user = nil
  end

  def current_spotify_user
    @current_spotify_user ||= current_user ? RSpotify::User.new(MultiJson.load(current_user.spotify_data)) : nil
  rescue
    reset_session
  end

  def uber_token
    MultiJson.load( current_user.uber_data)["credentials"]["token"]
  end

  def uber_products lat, long
    where = {
        lat: lat,
        long: long
    }
    Uber.products where, uber_token
  end

  def user_signed_in?
    current_user.present?
  end
end
