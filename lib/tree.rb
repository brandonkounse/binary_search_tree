# frozen_string_literal: true

# class to represent tree with nodes
class Tree
  attr_reader :root, :data

  def initialize(array)
    @data = array
  end

  def build_tree
    sorted_data = @data.uniq.sort
    middle = sorted_data.length / 2
    node = sorted_data[middle]
  end
end
