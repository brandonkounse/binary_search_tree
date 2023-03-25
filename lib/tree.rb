# frozen_string_literal: true

require 'pry-byebug'

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

  def insert(value, current = @root)
    if current.nil?
      return Node.new(value)
    elsif value > current.data
      current.right = insert(value, current.right)
    else
      current.left = insert(value, current.left)
    end

    current
  end

  def delete(value, current = @root, previous = nil); end

  def find; end

  def level_order; end

  def inorder; end

  def preorder; end

  def postorder; end

  def height; end

  def depth; end

  def balanced?; end

  def rebalance; end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
