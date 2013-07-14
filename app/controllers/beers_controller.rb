class BeersController < ApplicationController
  
  def index
    @beers = Beer.search_for(params[:query]).page(params[:page]).per(20)
    # render :json => @beers
  end
  
end