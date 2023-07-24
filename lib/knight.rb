require_relative 'bst/tree'

class Knight
  attr_reader :moves

  def initialize
    array = []
    array << [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    @moves = Tree.new(array: array)
  end
end
