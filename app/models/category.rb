class Category
  
  # Gems
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Associations
  has_many :styles, foreign_key: :categoryId
  
  # Attributes
  field :name, type: String
  field :bd_id, type: Integer
  field :_id, type: Integer, default: ->{ bd_id }
  
end
