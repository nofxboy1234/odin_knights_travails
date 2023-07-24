class Position
  attr_accessor :x_pos, :y_pos

  def initialize(x_pos, y_pos)
    @x_pos = x_pos
    @y_pos = y_pos
  end

  def valid?(board)
    x_valid = x_pos >= board.start_index && x_pos <= board.end_index
    y_valid = y_pos >= board.start_index && y_pos <= board.end_index
    x_valid && y_valid
  end
end