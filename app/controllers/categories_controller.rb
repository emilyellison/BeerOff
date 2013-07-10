class CategoriesController < ApplicationController
  
  before_filter :fetch_categories
  
  def index
    gon.abvs = StatBot.new(Beer.pluck(:abv), numerify: true, round: 0).freqs
  end
  
  def show
    @category = Category.find(params[:id])
    gon.abvs = StatBot.new(@category.beers.pluck(:abv), numerify: true, round: 0).freqs
  end
  
  private
  
    def fetch_categories
      @categories = Category.alphabetic.all
    end

end