# frozen_string_literal: true

# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Style/TrivialAccessors

# Node represents a node in a Binary Search Tree
class Node
  include Comparable

  attr_accessor :data, :children

  def initialize(data, children = nil)
    @data = data
    @children = children
  end

  def valid?
    x_valid = x_pos >= 0 && x_pos <= 7
    y_valid = y_pos >= 0 && y_pos <= 7
    x_valid && y_valid
  end

  def to_s
    "[#{data.x_pos}, #{data.y_pos}]"
  end

  def inspect
    "[#{data.x_pos}, #{data.y_pos}]"
  end

  def <=>(other)
    [data.x_pos, data.y_pos] <=> [other.data.x_pos, other.data.y_pos]
  end
end

# require_relative '../position'
# n1 = Node.new(Position.new(1, 2))
# n2 = Node.new(Position.new(1, 2))
# p n1 == n2

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
