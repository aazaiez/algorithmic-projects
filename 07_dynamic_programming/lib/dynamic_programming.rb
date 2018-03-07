require 'byebug'

class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = {
      1 => [[1]],
      2 => [[2], [1,1]],
      3 => [[1,1,1], [2,1], [1,2], [3]]
    }
  end

  def blair_nums(num)
    return @blair_cache[num] unless @blair_cache[num].nil?
    ans = blair_nums(num-1) + blair_nums(num-2) + 2*(num-1) - 1
    @blair_cache[num] = ans
    ans
  end

  def frog_hops_bottom_up(n)
    hops = frog_cache_builder(n)
    hops[n]
  end

  def frog_cache_builder(num)
    cache = [[], [[1]], [[2], [1,1]], [[1,1,1], [2,1], [1,2], [3]]]
    return cache if num < 4
    (4..num).to_a.each do |i|
      total_hops = []
      cache[i - 1].each do |hops|
        total_hops << hops + cache[1][0]
      end
      cache[i - 2].each do |hops|
          total_hops << hops + cache[2][0]
          total_hops << hops + cache[2][1]
      end
      cache[i - 3].each do |hops|
          total_hops << hops + cache[3][0]
          total_hops << hops + cache[3][1]
          total_hops << hops + cache[3][2]
          total_hops << hops + cache[3][3]
      end
      cache[i] = total_hops.uniq
    end
    cache
  end

  def frog_hops_top_down(n)
    return @frog_cache[n] if @frog_cache[n]
    frog_hops_top_down_helper(n)
    @frog_cache[n]
  end

  def frog_hops_top_down_helper(n)
    results = []
    results += frog_hops_top_down(n - 1).map do |hop|
      hop + [1]
    end
    results += frog_hops_top_down(n - 2).map do |hop|
      hop + [2]
    end
    results += frog_hops_top_down(n - 3).map do |hop|
      hop + [3]
    end
    @frog_cache[n] = results
  end

  def super_frog_hops(n, k)
    super_frog_cache = super_frog_cache_builder(n, k)
    super_frog_cache[k][n]
  end

  def super_frog_cache_builder(n, k)
    cache = {}
    (1..n).each do |col|
      (1..k).each do |row|
        cache[row] = [[[]]] unless cache[row]
        result = []
        if row == 1
          result << cache[row][col - 1][0] + [1]
        elsif row == col
          result = cache[row - 1][col].dup
          result << [row]
        elsif col > row
          (1...col).each do |column|
            cache[row][column].each do |hop|
              next if (col - column) > k
              result << hop + [col - column]
            end
          end
        elsif row > col
          result = cache[col][col]
        end
        cache[row][col] = result
      end
    end
    cache
  end

  def knapsack(weights, values, capacity)
    knapsack_cache = knapsack_table(weights, values, capacity)
    knapsack_cache[capacity].last
  end

  # Helper method for bottom-up implementation

  def knapsack_table(weights, values, capacity)
    knapsack_cache = {0 => Array.new(weights.length, 0)}
    (1..capacity).each do |c|
      knapsack_cache[c] = c == weights[0] ? [values[0]] : [0]
    end
    (1...weights.length).each do |col|
      (1..capacity).each do |c|
        current_weight = weights[col]
        current_value = values[col]
        if c < current_weight
          knapsack_cache[c][col] = knapsack_cache[c][col - 1]
        else
          new_value = knapsack_cache[c - current_weight][col - 1] + current_value
          knapsack_cache[c][col] = [new_value, knapsack_cache[c][col - 1]].max
        end
      end
    end
    knapsack_cache

  end


end
