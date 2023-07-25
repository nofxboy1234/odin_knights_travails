require_relative 'graph/node'
require_relative 'position'

class Knight
  attr_reader :position, :moves
  attr_accessor :stops

  def initialize(position)
    @moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    @position = position
  end

  def shortest_path_to_destination(destination)
    # byebug
    root_node = Node.new(position)
    destination_node = Node.new(Position.new(destination.first, destination.last))
    # route = [root_node]
    route = []

    # byebug
    draw_routes(stops, destination_node, route)
    # shortest_route = nil
    # byebug
    # routes.each do |route|
    #   shortest_route = route if (route.length - 1) > (shortest_route.length - 1)
    # end
    # shortest_route
  end

  private

  def draw_routes(root, destination, route)
    route << root
    return if root == destination

    root.children.each do |child_node|
      # rubocop:disable Style/IfUnlessModifier
      unless found_node_in_route?(child_node, route)
        draw_routes(child_node, destination, route)
      end
      # rubocop:enable Style/IfUnlessModifier
    end
    route
  end

  def found_node_in_route?(node, route)
    if route.find { |route_node| node.data == route_node.data }
      true
    else
      false
    end
  end
end
