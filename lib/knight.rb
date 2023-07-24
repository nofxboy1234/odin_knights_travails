class Knight
  attr_reader :current_position, :moves
  attr_accessor :possible_moves

  def initialize(current_position)
    @moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    @current_position = current_position
  end

end
