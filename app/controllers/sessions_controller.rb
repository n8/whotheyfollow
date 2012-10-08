class SessionsController < ApplicationController
  def create
    session['user_twitter_token'] = env['omniauth.auth']['credentials']['token']
    session['user_twitter_secret'] = env['omniauth.auth']['credentials']['secret']

    if session[:list_name].present?
      redirect_to new_list_path(:name => session[:list_name])
    end
  end
end