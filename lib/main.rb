require 'pry-byebug'
require_relative 'graph/graph'
require_relative 'graph/node'
require_relative 'knight'
require_relative 'board'
require_relative 'position'

board = Board.new(3, 2)
knight = Knight.new(Position.new(0, 0))
graph = Graph.new(board, knight)
knight.stops = graph.root

p knight.shortest_path_to_destination([1, 2])


