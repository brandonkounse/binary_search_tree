# frozen_string_literal: true

# class to represent data and next nodes
class Node
  attr_reader :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end
