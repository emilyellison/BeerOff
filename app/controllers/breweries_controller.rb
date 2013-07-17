class BreweriesController < ApplicationController
  
  def index
    @breweries = Brewery.search_for(params[:query]).page(params[:page]).per(10)
    # @breweries = Brewery.offset(2152)
    # render :json => @breweries 
  end
  
  def show
    @brewery = Brewery.find(params[:id])
    @beers = @brewery.beers.search_for(params[:query]).page(params[:page]).per(10)
  end
  
end