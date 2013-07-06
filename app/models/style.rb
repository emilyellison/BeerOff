class Style
  
  # Gems
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Associations
  belongs_to :category
    
  # Attributes
  field :name, type: String
  field :description, type: String
  field :ibuMin, type: String
  field :ibuMax, type: String
  field :abvMin, type: String
  field :abvMax, type: String
  field :srmMin, type: String
  field :srmMax, type: String
  field :ogMin, type: String
  field :fgMin, type: String
  field :fgMax, type: String
  field :categoryId, type: Integer
  field :bd_id, type: Integer
  field :_id, type: Integer, default: ->{ bd_id }
  
end
