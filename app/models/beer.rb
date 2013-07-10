# Import status: 0 - 400

class Beer
  
  # Gems
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Associations
  belongs_to :style, foreign_key: :styleId
  belongs_to :brewery, foreign_key: :breweryId
  belongs_to :glassware, foreign_key: :glasswareId
      
  # Attributes
  field :name, type: String
  field :description, type: String
  field :available, type: String
  field :status, type: String
  field :servingTemperature, type: String
  field :originalGravity, type: String
  field :abv, type: String
  field :ibu, type: String
  field :srm, type: Array
  field :styleId, type: Integer
  field :breweryId, type: String
  field :glasswareId, type: Integer
  field :isOrganic, type: String
  field :images, type: Hash
  field :bd_id, type: String
  field :_id, type: String, default: ->{ bd_id }
  
  # Class Methods  
  def self.import_for_brewery brewery_id
    page = 1
    importer = { 'current_page' => 0, 'number_of_pages' => 1 }
    until importer['current_page'] == importer['number_of_pages']
      importer = Importer.new(Beer, BreweryDb.beers_for_brewery(brewery_id, page: page), breweryId: brewery_id).as_json
      page += 1
    end
  end
  
  # The range of ids to pull, e.g. - 0..10 would pull the first 11 breweries
  def self.import_for_breweries range
    brewery_ids = Brewery.pluck(:id)[range]
    brewery_ids.each do |brewery_id|
      self.import_for_brewery brewery_id
    end
  end
  
  # Instance Methods
  def category
    style.category
  end
  
end