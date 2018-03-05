require 'binary_search_tree'

class BSTNode
  attr_reader :value
  attr_accessor :right, :left, :parent

  def initialize(value)
    @value = value
    @right = nil
    @left = nil
  end

  def insert(insert)
    return @value == insert if @value == nil
    if insert <= @value
      if @left == nil
        @left = BSTNode.new(insert)
        @left.parent = self
        return
      end
      @left.insert(insert)
    else
      if @right == nil
        @right = BSTNode.new(insert)
        @right.parent = self
        return
      end
      @right.insert(insert)
    end
  end

end