class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :user_signed_in?

  protected

  def current_user
    @current_user ||= User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    @current_user = nil
  end

  def user_signed_in?
    current_user.present?
  end
end
