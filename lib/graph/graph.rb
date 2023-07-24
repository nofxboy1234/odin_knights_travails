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
    @root = build(piece.current_position)
  end

  def build(root)
    # byebug``
    piece.moves.map do |horizontal, vertical|
      child_horizontal = root.first + horizontal
      child_vertical = root.last + vertical

      child = Node.new([child_horizontal, child_vertical])
      child.data if child.valid?
    end
  end

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
