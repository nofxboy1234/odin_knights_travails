require_relative 'bst/tree'
require_relative 'knight'
require_relative 'board'

def knight_moves(knight, start, goal)
  [[0, 0], [1, 2]]
end

knight = Knight.new
board = Board.new

p knight_moves(knight, [0,0], [1, 2])

