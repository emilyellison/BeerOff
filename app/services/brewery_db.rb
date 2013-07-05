require 'json'
require 'open-uri'

class BreweryDb
  
  @@api_key = nil
  
  def self.categories
    json_parse "/categories"
  end
      
  def self.json_parse query
    JSON.parse(open("http://api.brewerydb.com/v2#{query}/?key=#{api_key}").read)
  end
      
  def self.api_key
    @@api_key
  end

  def self.api_key=(api_key)
    @@api_key = api_key
  end

  def self.configure
    yield self
  end
      
end