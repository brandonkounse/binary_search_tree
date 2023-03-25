# frozen_string_literal: true

require './lib/node'
require './lib/tree'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.build_tree(tree.data)
tree.insert(40)
tree.delete(8)
tree.find(9)
tree.pretty_print
