class Position
  include Comparable

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

# p1 = Position.new(1, 2)
# past_positions = [p1]

# p2 = Position.new(1, 2)
# p p1 == p2
# p past_positions.include?(p2)
# # p past_positions.find { |pos| pos.eql?(p2) }
# p past_positions.find { |pos| pos == p2 }

# p3 = Position.new(1, 3)
# p past_positions.find { |pos| pos == p3 }

# p4 = Position.new(0, 2)
# p past_positions.find { |pos| pos == p4 }

