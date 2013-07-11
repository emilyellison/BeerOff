class StatBot
  
  def initialize array, options = {}
    @numerify = true || options[:numerify]
    @round    = 0 || options[:round]
    @x_label  = options[:x_label]
    @y_label  = options[:y_label]
    @array    = normalize array
  end
  
  def freqs     
    counts = Hash.new(0)
    @array.each { |item| counts[item] += 1 }
    counts.keys.map { |key| { measure: key, freq: counts[key] } }
  end
  
  def one_way_freq
    hash = Hash.new
    hash[:x_label] = @x_label
    hash[:y_label] = @y_label
    hash[:data] = freqs
    return hash
  end
  
  private
  
    def normalize array
      should_numerify_array? ? numerify(array) : array
    end
  
    def should_numerify_array?
      @numerify == true
    end
  
    def numerify array
      array.map { |item| item.to_f.round(@round) }.sort!
    end
  
end