require 'json'
require 'open-uri'

class BreweryDb
  
  @@api_key = nil
  
  def self.categories
    json_parse "/categories"
  end
  
  def self.styles
    json_parse "/styles"
  end
  
  def self.glassware
    json_parse "/glassware"
  end

  def self.breweries_established_in(year, options = {})
    if options[:page].present?
      json_parse "/breweries", established: year, p: options[:page]
    else
      json_parse "/breweries", established: year
    end
  end

  def self.beers_for_brewery(brewery_id, options = {})
    if options[:page].present?
      json_parse "/brewery/#{brewery_id}/beers", p: options[:page]
    else
      json_parse "/brewery/#{brewery_id}/beers"
    end
  end
      
  def self.json_parse query, options = {}
    uri = "http://api.brewerydb.com/v2#{query}/?key=#{api_key}"
    options.keys.each { |key| uri += "&#{key}=#{options[key]}" }
    JSON.parse(open(uri).read)
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