# frozen_string_literal: true

require 'pry-byebug'
require_relative 'graph/graph'
require_relative 'knight'
require_relative 'board'
require_relative 'position'

puts "Welcome to Knight's Travails!"
puts 'It calculates the shortest route from a square to another square on a chess board'
puts "\n"
puts 'Enter number of board rows (8 for standard chess board): '
board_rows = gets.chomp.strip.to_i
puts 'Enter number of board columns (8 for standard chess board): '
board_columns = gets.chomp.strip.to_i
puts "\n"

start_x = -1
until (0...board_columns).include?(start_x)
  puts "Enter start x position (0-#{board_columns - 1}): "
  start_x = gets.chomp.strip.to_i
end

start_y = -1
until (0...board_rows).include?(start_y)
  puts "Enter start y position (0-#{board_rows - 1}): "
  start_y = gets.chomp.strip.to_i
end

end_x = -1
until (0...board_columns).include?(end_x)
  puts "Enter end x position (0-#{board_columns - 1}): "
  end_x = gets.chomp.strip.to_i
end

end_y = -1
until (0...board_rows).include?(end_y)
  puts "Enter end y position (0-#{board_rows - 1}): "
  end_y = gets.chomp.strip.to_i
end

board_size = [board_rows, board_columns]
start_position = [start_x, start_y]
end_position = [end_x, end_y]

board = Board.new(*board_size)
knight = Knight.new(Position.new(*start_position))
graph = Graph.new(board, knight)
knight.stops = graph.root

shortest_route = knight.shortest_path_to_destination(end_position)
puts "The shortest route for a Knight from #{start_position} to #{end_position} on a #{board_size.first}x#{board_size.last} chess board is #{shortest_route}"
