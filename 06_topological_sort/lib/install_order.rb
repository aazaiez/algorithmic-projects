# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to
require_relative 'graph'
require_relative 'topological_sort'

def install_order(arr)
  vertices = {}
  arr.each do |package, dependency|
    vertices[package] = Vertex.new(package) unless vertices[package]
    vertices[dependency] = Vertex.new(dependency) unless vertices[dependency]
    Edge.new(vertices[dependency], vertices[package])
  end
  max_id = vertices.keys.max # can do this inside the loop to save a bit of time
  unconnected_vertices = (1..max_id).to_a - vertices.keys

  unconnected_vertices + topological_sort(vertices.values).map(&:value)
end
