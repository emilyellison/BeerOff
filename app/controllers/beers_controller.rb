class BeersController < ApplicationController
  
  def index
    @beers = Beer.search_for(params[:query]).page(params[:page]).per(10)
    # render :json => @beers
  end
  
end