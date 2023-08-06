# frozen_string_literal: true

class Position
  include Comparable

  attr_reader :x_pos, :y_pos

  def initialize(x_pos, y_pos)
    @x_pos = x_pos
    @y_pos = y_pos
  end

  def valid?(board)
    x_valid = x_pos >= board.columns_start_index && x_pos <= board.columns_end_index
    y_valid = y_pos >= board.rows_start_index && y_pos <= board.rows_end_index
    x_valid && y_valid
  end

  def <=>(other)
    [x_pos, y_pos] <=> [other.x_pos, other.y_pos]
  end

  def to_s
    "{#{x_pos}, #{y_pos}}"
  end

  def inspect
    "{#{x_pos}, #{y_pos}}"
  end
end
