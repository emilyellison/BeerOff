class CategoriesController < ApplicationController
  
  before_filter :fetch_categories
  
  def index
    if params[:measure] == "IBU"
      gon.ibus = StatBot.new(Beer.pluck(:ibu), numerify: true, round: 0).freqs
    else
      gon.abvs = StatBot.new(Beer.pluck(:abv), numerify: true, round: 0).freqs
    end
  end
  
  def show
    @category = Category.find(params[:id])
    if params[:measure] == "IBU"
      gon.ibus = StatBot.new(@category.beers.pluck(:ibu), numerify: true, round: 0).freqs
    else
      gon.abvs = StatBot.new(@category.beers.pluck(:abv), numerify: true, round: 0).freqs
    end
  end
  
  private
  
    def fetch_categories
      @categories = Category.alphabetic.all
    end

end