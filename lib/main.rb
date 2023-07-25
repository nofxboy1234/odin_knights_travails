require 'pry-byebug'
require_relative 'graph/graph'
require_relative 'graph/node'
require_relative 'knight'
require_relative 'board'
require_relative 'position'

board = Board.new(8, 8)
knight = Knight.new(Position.new(0, 0))
graph = Graph.new(board, knight)
knight.routes = graph.root

# binding.pry 
# puts 'end'


