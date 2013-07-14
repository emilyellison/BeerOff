class BreweriesController < ApplicationController
  
  def index
    @breweries = Brewery.search_for(params[:query]).page(params[:page]).per(10)
    # render :json => @breweries 
  end
  
end