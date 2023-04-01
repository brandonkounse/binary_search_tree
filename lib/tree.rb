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

  def insert(value, node = @root)
    if node.nil?
      return Node.new(value)
    elsif value > node.data
      node.right = insert(value, node.right)
    else
      node.left = insert(value, node.left)
    end

    node
  end

  def delete(value, node = @root)
    if node.nil?
      nil
    elsif value > node.data
      node.right = delete(value, node.right)
    elsif value < node.data
      node.left = delete(value, node.left)
    elsif value == node.data
      if node.left.nil?
        node = node.right
      elsif node.right.nil?
        node = node.left
      else
        node.data = inorder_successor(node.right)
        node.right = delete(node.data, node.right)
      end
    end
    node
  end

  def inorder_successor(node = @root)
    lowest_value = node.data
    until node.left.nil?
      lowest_value = node.left.data
      node = node.left
    end
    lowest_value
  end

  def find(value, node = @root)
    if node.nil?
      puts "#{value} not found!"
      nil
    elsif value == node.data
      node
    elsif value > node.data
      find(value, node.right)
    else
      find(value, node.left)
    end
  end

  def level_order(node = @root, queue = [])
    queue << node

    until queue.empty?
      node = queue.shift
      block_given? ? yield(node) : @data
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
  end

  def inorder(node = @root, arr = [], &block)
    return nil if node.nil?

    inorder(node.left, arr, &block)
    block_given? ? yield(node) : arr << node.data
    inorder(node.right, arr, &block)

    arr
  end

  def preorder(node = @root, arr = [], &block)
    return nil if node.nil?

    block_given? ? yield(node) : arr << node.data
    preorder(node.left, arr, &block)
    preorder(node.right, arr, &block)

    arr
  end

  def postorder(node = @root, arr = [], &block)
    return nil if node.nil?

    postorder(node.left, arr, &block)
    postorder(node.right, arr, &block)
    block_given? ? yield(node) : arr << node.data

    arr
  end

  def height(value, node = find(value))
    return 0 if node.left.nil? && node.right.nil?

    left_height = node.left.nil? ? 0 : height(value, node.left)
    right_height = node.right.nil? ? 0 : height(value, node.right)

    left_height > right_height ? left_height + 1 : right_height + 1
  end

  def depth(value, node = @root)
    return nil unless find(value)
    return 0 if node.nil? || node.data == value

    if value < node.data
      depth(value, node.left) + 1
    else
      depth(value, node.right) + 1
    end
  end

  def balanced?(node = @root)
    left_subtree = height(node.data, node.left) + 1
    right_subtree = height(node.data, node.right) + 1

    difference = left_subtree - right_subtree
    difference = difference.negative? ? (difference * -1) : difference
    difference <= 1
  end

  def rebalance
    if balanced?
      puts 'tree is balanced!'
    else
      build_tree(inorder)
    end
  end

  # credit for this method provided in README
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
