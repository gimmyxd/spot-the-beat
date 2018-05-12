class SessionsController < ApplicationController

  def new
    reset_session
  end

  def create
    redirect_to '/auth/spotify'
  end

  def callback
    user = User.find_by(provider: auth.provider, uid: auth.uid) || User.create_with_omniauth(auth)
    reset_session
    session[:user_id]   = user.id
    session[:auth_data] = auth.deep_stringify_keys

    redirect_to dashboard_url
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
