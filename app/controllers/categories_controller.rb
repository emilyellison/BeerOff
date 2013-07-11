class CategoriesController < ApplicationController
  
  before_filter :fetch_categories
  
  def index
    method = params[:measure] || 'abv'
    gon.beerData = StatBot.new(Beer.send(method.downcase), x_label: params[:measure], y_label: 'Number of Beers').one_way_freq
  end
  
  def show
    @category = Category.find(params[:id])
    method = params[:measure] || 'abv'
    gon.beerData = StatBot.new(@category.beers.send(method.downcase), x_label: params[:measure], y_label: 'Number of Beers').one_way_freq
  end
  
  private
  
    def fetch_categories
      @categories = Category.alphabetic.all
    end

end