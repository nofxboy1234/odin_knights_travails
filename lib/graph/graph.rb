# frozen_string_literal: true

# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Style/TrivialAccessors

require 'pry-byebug'
require_relative 'node'
require_relative 'byebug_syntax_highlighting'

# Graph represents all possible moves a chess piece can make
class Graph
  attr_reader :board, :piece, :nodes, :root

  def initialize(board, piece)
    @board = board
    @piece = piece

    # Each node in @nodes is a potential root, depending on piece position
    # @nodes = []
    # board.squares.each do |row, column|
    #   @nodes << build(Position.new(row, column))
    # end
    # @root = nodes.find { |node| node.data == piece.position}
  
    @root = build(piece.position)
  end

  def build(position, past_nodes = [])
    # byebug
    return unless position.valid?(board)
    
    node = Node.new(position)
    past_nodes << node
    
    children = piece.moves.map do |move|
      move_x_offset = move.first
      move_y_offset = move.last

      child_x_pos = position.x_pos + move_x_offset
      child_y_pos = position.y_pos + move_y_offset
      child_position = Position.new(child_x_pos, child_y_pos)
      
      found_node = past_nodes.find { |node| node.data == child_position }
      if found_node
        found_node
      else
        build(child_position, past_nodes)
      end
    end

    node.children = children.compact
    node
  end
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
