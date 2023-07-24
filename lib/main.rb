require 'pry-byebug'
require_relative 'graph/graph'
require_relative 'graph/node'
require_relative 'knight'
require_relative 'board'

def knight_moves(knight, current_position, destination_position)
  # byebug
  moves = []
  moves << current_position

  knight.moves.each do |horizontal, vertical|
    current_horizontal = current_position.first
    current_vertical = current_position.last

    next_position = 
      [current_horizontal + horizontal, current_vertical + vertical]
    moves << next_position
    if next_position == destination_position
      break
    else
      puts 'no match'
    end
  end

  moves
end

board = Board.new
knight = Knight.new([0, 0])

graph = Graph.new(board, knight)
p graph.root



# p knight_moves(knight, [0,0], [1, 2])

