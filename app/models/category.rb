class Category
  
  # Gems
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Associations
  has_many :styles, foreign_key: :categoryId
  
  # Scopes
  scope :alphabetic, -> { order_by('name asc') }
  
  # Attributes
  field :name, type: String
  field :bd_id, type: Integer
  field :_id, type: Integer, default: ->{ bd_id }
  
  # Class Methods
  def self.import
    Importer.new(Category, BreweryDb.categories)
  end
  
  # Instance Methods
  def beers
    Beer.in(styleId: styles.pluck(:bd_id))
  end
  
end
