class Glassware
  
  # Gems
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Associations
  has_many :beers, foreign_key: :glasswareId
  
  # Attributes
  field :name, type: String
  field :bd_id, type: Integer
  field :_id, type: Integer, default: ->{ bd_id }
  
  # Class Methods
  def self.import
    Importer.new(Glassware, BreweryDb.glassware)
  end
  
end
