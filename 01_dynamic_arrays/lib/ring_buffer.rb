require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[index]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[index] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" unless @length > 0
    popped = @store[@length-1]
    @length -= 1
    popped
  end

  # O(1) ammortized
  def push(val)
    @length += 1
    @store[@length-1] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" unless @length > 0
    shifted = @store[@start_idx]
    @start_idx += 1
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    (@length - 2).downto(0).each { |i| @store[i+1] = @store[i] }
    @store[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" unless index >= 0 && index < @length
  end

  def resize!
    @capacity *= 2
    new_buffer = StaticArray.new(@capacity)
    @length.times { |i| new_buffer[i] = @store[i] }
    @store = new_buffer
  end
end
