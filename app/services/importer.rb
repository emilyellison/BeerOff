class Importer
  
  def initialize class_name, hash
    @class_name = class_name
    @data = hash['data']
    validate
    normalize
    import
  end
  
  def validate
    raise ArgumentError, "Can only import categories and styles" if ![ Category, Style ].include?(@class_name)
  end
  
  def normalize
    @data.each { |datum| scrub_hash datum }
  end
  
  def import
    @data.each { |datum| create_or_update_from datum }
  end
  
  private
    
    def scrub_hash datum
      # datum = Hash[ datum.map{|(k,v)| [ k.underscore ,v ]} ]
      datum.keep_if {|key, value| @class_name.fields.keys.include?(key) || key == 'id' }
    end
    
    def create_or_update_from datum
      object = @class_name.find_or_initialize_by(bd_id: datum['id'])
      object.update_attributes(datum)
    end
  
end