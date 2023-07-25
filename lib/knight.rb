class Knight
  attr_reader :position, :moves
  attr_accessor :routes

  def initialize(position)
    @moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    @position = position
  end

  def shortest_path_to_destination
    routes.children.map { |node| node.data }
  end
end
