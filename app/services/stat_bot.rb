class StatBot
  
  def initialize array, options = {}
    @numerify = true || options[:numerify]
    @round    = 0 || options[:round]
    if array.first.class == String
      @dimensions = 1
    elsif array.first.class == Array
      @dimensions = 2
    end
    @array    = normalize array
    @data     = Hash.new
    @data[:x_label] = options[:x_label]
    @data[:y_label] = options[:y_label]
  end
  
  def one_way_freq     
    counts = Hash.new(0)
    @array.each { |item| counts[item] += 1 }
    @data[:data] = counts.keys.map { |key| { x: key, y: counts[key] } }
    return @data
  end
  
  def two_way_freq
    counts = Hash.new(0)
    @array.each { |item| counts[item] += 1 }
    @data[:data] = counts.keys.map { |key| { x: key[0], y: key[1], freq: counts[key] } }
    return @data
  end
      
  private
  
    def normalize array
      should_numerify_array? ? numerify(array) : array
    end
  
    def should_numerify_array?
      @numerify == true
    end
  
    def numerify array
      if @dimensions == 1
        numerified = array.map { |item| item.to_f.round(@round) }.sort!
      elsif @dimensions == 2
        numerified = array.map{ |x| x.map{ |y| y.index(".").present? ? y.to_f : y.to_i } }.sort_by(&:first)
      end
      return numerified
    end
      
end