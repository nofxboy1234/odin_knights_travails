require 'pry-byebug'
require_relative 'graph/graph'
require_relative 'knight'
require_relative 'board'
require_relative 'position'

start_position = [0, 0]
end_position = [1, 2]
board_size = [4, 4]

board = Board.new(*board_size)
knight = Knight.new(Position.new(*start_position))
graph = Graph.new(board, knight)
knight.stops = graph.root

shortest_route = knight.shortest_path_to_destination(end_position)
puts "The shortest route for a Knight from #{start_position} to #{end_position} on a #{board_size.first}x#{board_size.last} chess board is #{shortest_route}"
