class ListsController < ApplicationController

  def new

    if params[:name].present?
      session[:list_name] = params[:name]

      redirect_to "/auth/twitter"
      return
    end
  end

  def show
  end

end
