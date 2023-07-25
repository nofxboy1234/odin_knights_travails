require 'pry-byebug'
require_relative 'graph/graph'
require_relative 'graph/node'
require_relative 'knight'
require_relative 'board'
require_relative 'position'

board = Board.new(3, 3)
knight = Knight.new(Position.new(0, 0))
graph = Graph.new(board, knight)
knight.routes = graph.root
# binding.pry
p knight.shortest_path_to_destination


