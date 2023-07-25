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
    return unless position.valid?(board)

    found_node = past_nodes.find { |node| node.position.eql(position) }
    return found_node if found_node

    node = Node.new(position)
    past_nodes << node

    children = piece.moves.map do |move|
      move_x_offset = move.first
      move_y_offset = move.last

      child_x_pos = position.x_pos + move_x_offset
      child_y_pos = position.y_pos + move_y_offset
      child_position = Position.new(child_x_pos, child_y_pos)

      build(child_position) if child_position.valid?(board)
    end

    node.children = children
    node
  end

  # def build
  #   nodes.map do |node|
  #     node.children = piece.moves.map do |horizontal, vertical|
  #       child_x_pos = node.x_pos + horizontal
  #       child_y_pos = node.y_pos + vertical
  #       nodes.find { |node| node.data == [child_x_pos, child_y_pos]}
  #     end
  #     node
  #   end
  # end

  # private

  # def level_order_recursive(&my_block)
  #   nodes = (0..height_recursive(root)).map do |level|
  #     nodes_on_level(root, level)
  #   end

  #   if block_given?
  #     nodes.flatten.each { |node| my_block.call(node) }
  #     nil
  #   else
  #     nodes.flatten.map { |node| node.data }
  #   end
  # end

  # def find(value)
  #   find_recursive(root, value)
  # end

  # private
end

# rubocop:enable Lint/RedundantCopDisableDirective
# rubocop:enable Style/TrivialAccessors
