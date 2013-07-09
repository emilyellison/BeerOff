class Importer
  
  def initialize class_name, hash, options = {}
    @class_name      = class_name
    @data            = hash['data']
    @current_page    = hash['currentPage']
    @number_of_pages = hash['numberOfPages']
    @options         = options
    validate
    normalize
    import
  end
  
  def validate
    raise ArgumentError, "Can only import beers, breweries, glassware, categories, and styles" if ![ Category, Style, Beer, Brewery, Glassware ].include?(@class_name)
  end
  
  def normalize
    @data.each { |datum| scrub_hash datum } if @data.present?
  end
  
  def import
    @data.each { |datum| create_or_update_from datum } if @data.present?
  end
    
  private
    
    def scrub_hash datum
      # datum = Hash[ datum.map{|(k,v)| [ k.underscore ,v ]} ]
      datum.keep_if {|key, value| @class_name.fields.keys.include?(key) || key == 'id' }
    end
    
    def create_or_update_from datum
      object = @class_name.find_or_initialize_by(bd_id: datum['id'])
      @options.keys.each { |key| object.send("#{key}=", @options[key]) }
      object.update_attributes(datum)
      puts "#{object.name} has been imported."
    end
    
end