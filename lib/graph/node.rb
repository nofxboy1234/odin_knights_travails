# frozen_string_literal: true

# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Style/TrivialAccessors

# Node represents a node in a Binary Search Tree
class Node
  include Comparable

  attr_accessor :data, :children, :parent

  def initialize(data, children = nil, parent = nil)
    @parent = parent
    @children = children
    @data = data
  end

  # def valid?
  #   x_valid = x_pos >= 0 && x_pos <= 7
  #   y_valid = y_pos >= 0 && y_pos <= 7
  #   x_valid && y_valid
  # end

  def to_s
    "{#{data.x_pos}, #{data.y_pos}}"
  end

  def inspect
    "{#{data.x_pos}, #{data.y_pos}}"
  end

  def <=>(other)
    [data.x_pos, data.y_pos] <=> [other.data.x_pos, other.data.y_pos]
  end
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
