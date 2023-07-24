# frozen_string_literal: true

# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Style/TrivialAccessors

# Node represents a node in a Binary Search Tree
class Node
  include Comparable

  def initialize(data: nil, left: nil, right: nil)
    @data = data
    @left = left
    @right = right
  end

  def data
    @data
  end

  def left
    @left
  end

  def left=(value)
    @left = value
  end

  def right
    @right
  end

  def right=(value)
    @right = value
  end

  def <=>(other)
    data <=> other.data
  end

  def leaf?
    left.nil? && right.nil?
  end

  def has_one_child?
    (left.nil? && right) || (left && right.nil?)
  end

  def has_two_children?
    left && right
  end
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
