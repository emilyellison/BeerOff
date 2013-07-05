class Category
  
  # Gems
  include Mongoid::Document
  
  # Attributes
  field :name, type: String
  field :bd_id, type: Integer
  field :_id, type: Integer, default: ->{ bd_id }
  
end
