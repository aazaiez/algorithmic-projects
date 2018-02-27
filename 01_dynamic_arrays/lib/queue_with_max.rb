# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'
require 'byebug'

class QueueWithMax
  attr_accessor :store, :max

  def initialize
    @store = RingBuffer.new
    @max_store = RingBuffer.new
  end

  def enqueue(val)
    @store.push(val)
    until (@max_store.length == 0 || @max_store[(@max_store.length) - 1] > val)
      @max_store.pop
    end
      @max_store.push(val)

  end

  def dequeue
    if (@max_store.length > 0) && @max_store[0] == @store[0]
      @max_store.shift
    end
    @store.shift
  end

  def max
    @max_store[0]
  end

  def length
    @store.length
  end

end
