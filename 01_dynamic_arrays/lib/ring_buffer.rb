require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
    @start_index = 0
  end

  # O(1)
  #Finds the index starting to count from the logical_index
  def [](index)
    check_index(index)
    @store[(@start_index + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[(@start_index + index) % @capacity] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    popped = self[@length - 1]
    @length -= 1
    popped
  end

  # O(1) ammortized
  def push(val)
    @length += 1
    resize! if @length > capacity
    self[@length - 1] = val
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    shifted = self[0]
    self[0] = nil
    @length -= 1
    @start_index = (@start_index + 1) % @capacity
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    @length += 1
    resize! if @length > @capacity
    @start_index -= 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_index, :store
  attr_writer :length

  def check_index(index)
    if index < 0 || index >= @length
      raise "index out of bounds"
    end
  end

  def resize!
    temp_capacity = @capacity * 2
    store = StaticArray.new(temp_capacity)
    @length.times{ |idx| store[idx] = self[idx] }
    @store = store
    @start_index = 0
    @capacity = temp_capacity
  end
end
