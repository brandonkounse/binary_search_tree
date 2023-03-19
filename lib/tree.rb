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

  def insert(value)
    current = @root

    until current.left.nil? || current.right.nil?
      if value > current.data
        current = current.right
      else
        current = current.left
      end
    end

    if value > current.data
      current.right = Node.new(value)
    else
      current.left = Node.new(value)
    end
  end

  def delete; end

  def find; end

  def level_order; end

  def inorder; end

  def preorder; end

  def postorder; end

  def height; end

  def depth; end

  def balanced?; end

  def rebalance; end
end
