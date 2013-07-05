api_key = YAML.load_file("#{Rails.root}/config/brewery_db.yml")[Rails.env]['api_key']

BreweryDb.configure do |config|
  config.api_key = api_key
end
