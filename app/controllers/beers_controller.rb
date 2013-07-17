class BeersController < ApplicationController
  
  def index
    # @beers = Beer.search_for(params[:query]).page(params[:page]).per(10)
    @beers = Beer.limit(1000).offset(14589)
    render :json => @beers
  end
  
end