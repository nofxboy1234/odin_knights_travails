require 'pry-byebug'
require_relative 'bst/tree'
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

knight = Knight.new
board = Board.new

p knight_moves(knight, [0,0], [1, 2])

