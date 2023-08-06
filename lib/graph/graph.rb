# frozen_string_literal: true

# rubocop:disable Lint/RedundantCopDisableDirective
# rubocop:disable Style/TrivialAccessors

require 'pry-byebug'
require_relative 'node'
require_relative 'byebug_syntax_highlighting'

# Graph represents all possible moves a chess piece can make
class Graph
  attr_reader :board, :piece, :root

  def initialize(board, piece)
    @board = board
    @piece = piece

    @root = build(piece.position)
  end

  def build(position, past_nodes = [])
    return unless position.valid?(board)

    node = Node.new(position)
    past_nodes << node

    children = piece.moves.map do |move|
      child_position = create_child_position(move, position)

      found_node = past_nodes.find { |past_node| past_node.data == child_position }
      found_node || build(child_position, past_nodes)
    end

    node.children = children.compact
    node
  end

  private

  def create_child_position(move, position)
    move_x_offset = move.first
    move_y_offset = move.last

    child_x_pos = position.x_pos + move_x_offset
    child_y_pos = position.y_pos + move_y_offset
    Position.new(child_x_pos, child_y_pos)
  end

end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
