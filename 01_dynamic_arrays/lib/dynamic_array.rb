require_relative "static_array"
require 'byebug'

class DynamicArray
  attr_reader :length

  def initialize
    @store = StaticArray.new(8)
    @capacity = 8
    @length = 0
  end

  # O(1)
  def [](idx)
    check_idx(idx)
    @store[idx]
  end

  # O(1)
  def []=(idx, val)
    check_idx(idx)
    @store[idx] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" unless @length > 0
    @length -= 1
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible resize.
  def push(val)
    resize! if @length == @capacity
    @length += 1
    @store[@length - 1] = val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if (@length == 0)
    shifted = @store[0]
    (1...@length).each do |i|
      @store[i - 1] = @store[i]
    end
    @length -= 1
    shifted
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length == @capacity
    @length += 1
    (@length - 2).downto(0).each { |i| @store[i + 1] = @store[i] }
    @store[0] = val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_idx(idx)
    raise "index out of bounds" unless idx >= 0 && idx < @length
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    @length.times { |i| new_store[i] = @store[i]}
    @store = new_store
  end
end
