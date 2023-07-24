# frozen_string_literal: true

# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Style/TrivialAccessors

# Node represents a node in a Binary Search Tree
class Node
  # include Comparable

  attr_accessor :data, :x_pos, :y_pos, :children

  def initialize(data)
    @data = data
    @x_pos = data.first
    @y_pos = data.last
  end

  def valid?
    x_valid = x_pos >= 0 && x_pos <= 7
    y_valid = y_pos >= 0 && y_pos <= 7
    x_valid && y_valid
  end

  # def <=>(other)
  #   data <=> other.data
  # end
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors