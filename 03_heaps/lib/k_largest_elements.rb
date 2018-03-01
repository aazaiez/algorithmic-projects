require_relative 'heap'
require_relative 'heap_sort'

def k_largest_elements(array, k)
  array.heap_sort!
  array[(array.length - k)..-1]
end
