# frozen_string_literal: true

# class to represent data and next nodes
class Node
  attr_reader :data, :left_child, :right_child

  def initialize(data, left_child, right_child)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end
