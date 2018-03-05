require 'binary_search_tree'

def kth_largest(tree_node, k)
  size = BinarySearchTree.size(tree_node.right)
  return tree_node if size == k - 1
end