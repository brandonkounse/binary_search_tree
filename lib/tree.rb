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

  def delete(value, current = @root)
    if current.nil?
      nil
    elsif value > current.data
      current.right = delete(value, current.right)
    elsif value < current.data
      current.left = delete(value, current.left)
    elsif value == current.data
      if current.left.nil?
        current = current.right
      elsif current.right.nil?
        current = current.left
      else
        current.data = inorder_successor(current.right)
        current.right = delete(current.data, current.right)
      end
    end
    current
  end

  def inorder_successor(current = @root)
    lowest_value = current.data
    until current.left.nil?
      lowest_value = current.left.data
      current = current.left
    end
    lowest_value
  end

  def find(value, current = @root)
    if current.nil?
      puts "#{value} not found!"
    elsif value == current.data
      current
    elsif value > current.data
      find(value, current.right)
    else
      find(value, current.left)
    end
  end

  def level_order(current = @root, queue = [])
    queue << current

    until queue.empty?
      current = queue.shift
      block_given? ? yield(current) : :data
      queue << current.left unless current.left.nil?
      queue << current.right unless current.right.nil?
    end
  end

  def inorder(current = @root, &block)
    if current.nil?
      nil
    else
      inorder(current.left, &block)
      block_given? ? yield(current) : :data
      inorder(current.right, &block)
    end
  end

  def preorder; end

  def postorder; end

  def height; end

  def depth; end

  def balanced?; end

  def rebalance; end

  # credit for this method provided in README
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
