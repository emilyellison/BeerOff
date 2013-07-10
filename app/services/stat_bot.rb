class StatBot
  
  def initialize array, options = {}
    @numerify = options[:numerify]
    @array   = normalize array
  end
  
  def freqs     
    counts = Hash.new(0)
    @array.each { |item| counts[item] += 1 }
    counts.keys.map { |key| { measure: key, freq: counts[key] } }
  end
  
  private
  
    def normalize array
      should_numerify_array? ? numerify(array) : array
    end
  
    def should_numerify_array?
      @numerify == true
    end
  
    def numerify array
      array.map { |item| item.to_f.round(1) }.sort!
    end
  
end