# frozen_string_literal: true

require './lib/node'
require './lib/tree'

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.build_tree(tree.data)
tree.insert(40)
tree.delete(8)
tree.find(9)
tree.level_order # { |element| puts element.data }
tree.inorder # { |element| puts element.data }
tree.preorder # { |element| puts element.data }
tree.postorder { |element| puts element.data }
tree.pretty_print
