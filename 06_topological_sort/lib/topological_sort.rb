require_relative 'graph'
require 'byebug'

# Implementing topological sort using both Khan's and Tarjan's algorithms

# Kahn's Algo: O(|V| + |E|)
def topological_sort(vertices)
  top, sorted = [], []
  vertices.each do |vertex|
    top.unshift(vertex) if vertex.in_edges.empty?
  end

  until top.empty?
    current = top.pop
    sorted << current
    until current.out_edges.empty?
      edge = current.out_edges.first
      neighbor = edge.to_vertex
      edge.destroy!
      if neighbor.in_edges.empty?
        top.unshift(neighbor)
      end
    end

    vertices.delete(current)
  end

  vertices.empty? ? sorted : []
end

# from a/A solution:
# keep an in_edges *hash*, at each vertex store sum of weights of the edges
# instead of deleting, decrement count by weight of current edge.

def topological_sort_tarjans(vertices)
  sort_data = {
    sorted: [],
    visited: {},
    cycle: false
  }
  # easy to do with Sets
  vertices.each do |vertex|
    visit(vertex, :none, sort_data)
    return [] if sort_data[:cycle]
  end

  sort_data[:sorted]
end

# could have turned this into a DFS! method
def visit(vertex, from_vertex, sort_data)
  if sort_data[:visited][vertex]
    sort_data[:cycle] =
      check_for_cycle(sort_data[:visited], from_vertex, vertex)
  else
    vertex.out_edges.each do |edge|
      visit(edge.to_vertex, vertex, sort_data)
    end

    sort_data[:visited][vertex] = from_vertex
    sort_data[:sorted].unshift(vertex)
  end
end

def check_for_cycle(path_hash, from_vertex, to_vertex)
  return false if from_vertex == :none
  while path_hash[to_vertex]
    # this is so counter dfs, dont do this :(
    to_vertex = path_hash[to_vertex]
    return true if to_vertex == from_vertex
  end

  false
end

# note from a/A solution: a cycle will only happen in *one* DFS call
# instead of storing paths, store temp visited, add and remove from this
# during the dfs call.
