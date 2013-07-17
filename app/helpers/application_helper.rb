module ApplicationHelper

  # Active Measurement

  def is_measuring?(measure, params)
    "active" if params[:measure] == measure || is_default_measure?(measure, params)
  end
  
  def is_default_measure?(measure, params)
    params[:measure].nil? && measure == 'Traits'
  end
  
  # Active Category
  
  def is_category?(category, params)
    "active" if params[:controller] == 'categories' && (is_all_categories?(category, params) || params[:id] == category.try(:id).try(:to_s))
  end
  
  def is_all_categories?(category, params)
    params[:id].nil? && category == nil
  end

end
