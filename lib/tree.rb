# frozen_string_literal: true

# class to represent tree with nodes
class Tree
  attr_reader :root, :data

  def initialize(array)
    @data = array.sort.uniq
  end

  def build_tree(array)
    if array.empty?
      nil
    else
      mid = array.length / 2

      node = Node.new(array[mid])
      node.left = build_tree(array[(0...mid)])
      node.right = build_tree(array[(mid + 1..array.length - 1)])

      @root = node
    end
  end
end
