class CategoriesController < ApplicationController
  
  before_filter :fetch_categories
  before_filter :determine_method
  
  def index
    @beers = Beer.send(@method.parameterize.underscore.downcase)
    fetch_data_for(@beers) if @beers.present?
  end
  
  def show
    @category = Category.find(params[:id])
    @beers = @category.beers.send(@method.parameterize.underscore.downcase)
    fetch_data_for(@beers) if @beers.present?
  end
  
  private
  
    def fetch_categories
      @categories = Category.alphabetic.all
    end
    
    def determine_method
      @method = params[:measure] || 'abv'
    end
    
    def fetch_data_for(beers)
      if params[:measure].present? && params[:measure].index('and').present?
        gon.twoWay = StatBot.new(@beers, x_label: params[:measure].split(' ').first, y_label: params[:measure].split(' ').last).two_way_freq
      else
        gon.oneWay = StatBot.new(@beers, x_label: params[:measure], y_label: 'Number of Beers').one_way_freq
      end
    end

end