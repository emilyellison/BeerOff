# Development: Up to Brewery #1905
# Production: Up to Brewery #1905

class Beer
  
  # Gems
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::TagsArentHard
  
  taggable_with :tags
  
  # Associations
  belongs_to :style, foreign_key: :styleId
  belongs_to :brewery, foreign_key: :breweryId
  belongs_to :glassware, foreign_key: :glasswareId
      
  # Scopes
  default_scope order_by('created_at asc') 
  scope :has_abv, all_of(:abv.ne => nil)
  scope :has_ibu, all_of(:ibu.ne => nil)
  scope :has_srm, all_of(:srm.ne => nil)
      
  # Attributes
  field :name, type: String
  field :description, type: String
  field :available, type: Hash
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
  def self.abv
    self.pluck(:abv)
  end
  
  def self.ibu
    self.pluck(:ibu)
  end
  
  def self.srm
    self.pluck(:srm).map{ |x| x['name'][/\d+/] }
  end
  
  def self.traits
    self.pluck(:tags).flatten
  end
  
  def self.abv_and_ibu
    self.has_abv.has_ibu.pluck(:abv, :ibu)
  end
  
  def self.abv_and_srm
    self.has_abv.has_srm.map { |x| [ x.abv, x.srm['name'][/\d+/] ] }
  end
  
  def self.srm_and_ibu
    self.has_srm.has_ibu.map { |x| [ x.srm['name'][/\d+/], x.ibu ] }
  end
  
  def self.search_for(query)
    any_of({name: /.*#{query}.*/i}, {description: /.*#{query}.*/i})
  end
  
  # Importing Beers
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
  
  # Data cleaning
  # Beer.where(:abv => '61', bd_id: "9xaRRt").to_a.first.update_attributes(abv: '6.1')
  
end
