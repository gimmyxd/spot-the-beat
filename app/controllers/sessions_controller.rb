class SessionsController < ApplicationController

  def new
    reset_session
  end

  def create
    redirect_to '/auth/spotify'
  end

  def callback
    user = User.find_by(email: auth.info.email)
    if user
      user.spotify_data=auth.to_json if auth.provider == 'spotify'
      user.uber_data=auth.to_json if auth.provider == 'uber'
      user.save
    else
      user =  User.create_with_omniauth(auth)
    end

    reset_session
    session[:email] = user.email
    session['state']=nil
    if auth.provider == 'uber'
      redirect_to dashboard_url
    else
      redirect_to dashboard_url
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  def map
    render 'dashboard/map'
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
