require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(@capacity)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if @length <= index
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length == 0
    @length -= 1

  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    @length += 1
    resize! if @length == capacity
    self[length-1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise 'index out of bounds' if @length == 0
    first_element = self.first
    temp_array = StaticArray.new(@capacity)
    @store.each_index do |idx|
      temp_array[idx] = @store[idx+1]
      break if idx == @length - 1
    end
    @store = temp_array
    @length -= 1
    first_element
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    @length += 1
    temp_array = StaticArray.new(@capacity)
    temp_array[0] = val
    @store.each_index  do |idx|
    end

  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
  end
end
