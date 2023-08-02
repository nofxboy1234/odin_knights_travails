require 'pry-byebug'
require_relative 'graph/graph'
require_relative 'knight'
require_relative 'board'
require_relative 'position'

board = Board.new(4, 4)
knight = Knight.new(Position.new(0, 0))
graph = Graph.new(board, knight)
knight.stops = graph.root

shortest_route = knight.shortest_path_to_destination([1, 2])
puts "The shortest route is #{shortest_route}"
