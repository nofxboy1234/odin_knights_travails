# frozen_string_literal: true

require 'pry-byebug'
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

def get_input(range_max, value)
  input = -1
  until (0...range_max).cover?(input)
    puts "Enter #{value} position (0-#{range_max - 1}): "
    input = gets.chomp.strip.to_i
  end
  input
end

start_x = get_input(board_columns, 'start_x')
start_y = get_input(board_columns, 'start_y')
end_x = get_input(board_columns, 'end_x')
end_y = get_input(board_columns, 'end_y')

board_size = [board_rows, board_columns]
start_position = [start_x, start_y]
end_position = [end_x, end_y]

position = Position.new(*start_position)
board = Board.new(*board_size)
knight = Knight.new(position, board)

shortest_route = knight.shortest_path_to_destination(end_position)
puts "The shortest route for a Knight from #{start_position} to
      #{end_position} on a #{board_size.first}x#{board_size.last} chess board is
      #{shortest_route}"
