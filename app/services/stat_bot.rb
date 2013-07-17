class StatBot
  
  def initialize array, options = {}
    @dimensions     = set_dimensions_for array
    @array          = array
    @data           = Hash.new
    @data[:x_label] = options[:x_label]
    @data[:y_label] = options[:y_label]
  end
  
  # This outputs a one-way frequency with numerical values.
  def one_way_freq     
    @array = numerify @array
    counts = Hash.new(0)
    @array.each { |item| counts[item] += 1 }
    @data[:data] = counts.keys.map { |key| { x: key, y: counts[key] } }
    return @data
  end
  
  # This outputs a two-way frequency with numerical x-values and numerical y-values.
  def two_way_freq
    @array = numerify @array
    counts = Hash.new(0)
    @array.each { |item| counts[item] += 1 }
    @data[:data] = counts.keys.map { |key| { x: key[0], y: key[1], freq: counts[key] } }
    return @data
  end
  
  # This outputs an array of hashes for categorical data counts.
  def bubble_freq
    counts = Hash.new(0)
    @array.each { |item| counts[item] += 1 }
    @data[:data] = { name: 'bubble', children: [] }
    @data[:data][:children]= counts.keys.map { |key| { name: key, size: counts[key] } }
    return @data
  end
      
  private
  
    def set_dimensions_for array
      if array.first.class == String
        return 1
      elsif array.first.class == Array
        return 2
      end
    end
    
    def numerify array
      if @dimensions == 1
        numerified = array.map { |item| item.to_f.round(0) }.sort!
      elsif @dimensions == 2
        numerified = array.map{ |x| x.map{ |y| y.index(".").present? ? y.to_f : y.to_i } }.sort_by(&:first)
      end
      return numerified
    end
      
end