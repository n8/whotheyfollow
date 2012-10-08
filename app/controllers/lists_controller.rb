class ListsController < ApplicationController

  def new
    if params[:name]
      session[:list_name] = params[:name]
    end
        
    if params[:name].present?

      if session['user_twitter_token'].blank?

        
        redirect_to "/auth/twitter"
        return
      end


      create_list
      return
    end
  end

protected

  def create_list

    name = session[:list_name] 
    session[:list_name] = nil

    client = Grackle::Client.new(:auth=>{
      :type => :oauth,
      :consumer_key => 'WQgMu8YaifeiK3lYio4lfA', :consumer_secret => 'yV1E4eojtTbSNqbOvcHjlX1ATPXM6mfKvghrZZm2JQ',
      :token => session['user_twitter_token'], :token_secret => session['user_twitter_secret']
    })

    following = client.friends.ids? :screen_name => name
    following_ids = following.ids

    list = client.lists.create! :name => name, :mode => 'private'

    begin
      list_ids = following_ids[0..99]
      
      client.lists.members.create_all! list_id: list.id, user_id: list_ids.join(",")
    rescue

    end
    
    render text: name
  end


end
