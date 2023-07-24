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
    # piece_position = piece.current_position
    # @root = Node.new([piece_position.first, piece_position.last])
    @root = build
  end

  
  def build
    # byebug

    nodes.each do |node|
      node.children = piece.moves.map do |horizontal, vertical|
        child_x_pos = node.x_pos + horizontal
        child_y_pos = node.y_pos + vertical
        nodes.find { |node| node.data == [child_x_pos, child_y_pos]}
      end
    end
  end

  def position_valid?(position)
    x_pos = position.first
    y_pos = position.last
    
    x_valid = x_pos >= 0 && x_pos <= 7
    y_valid = y_pos >= 0 && y_pos <= 7
    x_valid && y_valid
  end

  private

  def nodes
    board.squares.map do |horizontal, vertical|
      Node.new([horizontal, vertical])
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
