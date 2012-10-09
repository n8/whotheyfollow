class SessionsController < ApplicationController
  def create
    @you = env['omniauth.auth']['info']['nickname']
    @user_twitter_token = env['omniauth.auth']['credentials']['token']
    @user_twitter_secret = env['omniauth.auth']['credentials']['secret']

    if session[:list_name].present?
      create_list
    end
  end

private 

  def create_list

    name = session[:list_name].delete("@") 
    session[:list_name] = nil

    client = Grackle::Client.new(:auth=>{
      :type => :oauth,
      :consumer_key => ENV['TWITTER_KEY'], :consumer_secret => ENV['TWITTER_SECRET'],
      :token => @user_twitter_token, :token_secret => @user_twitter_secret
    })

    following = client.friends.ids? :screen_name => name
    following_ids = following.ids

    list = client.lists.create! :name => name, :mode => 'private'

    begin
      list_ids = following_ids[0..99]
      
      client.lists.members.create_all! list_id: list.id, user_id: list_ids.join(",")
    rescue

    end
    
    redirect_to lists_show_path(list_name: list.slug, you: @you)
  end


end