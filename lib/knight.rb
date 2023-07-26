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
    # root_node = Node.new(position)
    destination_node = Node.new(Position.new(destination.first, destination.last))
    # route = [root_node]
    # byebug
    routes = []

    first_route = []
    routes << first_route
    draw_routes(stops, destination_node, routes)
    # shortest_route = nil
    # byebug
    # routes.each do |route|
    #   shortest_route = route if (route.length - 1) > (shortest_route.length - 1)
    # end
    # shortest_route
  end

  private

  def draw_routes(root, destination, routes)
    byebug
    # if root.data == position
    #   routes << [root]
    # else
    #   routes.last << root
    # end
    routes.last << root

    if root == destination
      next_route = []
      next_route << stops
        
      routes << next_route
      return
    end

    root.children.each do |child_node|
      # rubocop:disable Style/IfUnlessModifier
      unless node_in_last_route?(child_node, routes)
        draw_routes(child_node, destination, routes)
      end
      # rubocop:enable Style/IfUnlessModifier
    end
    routes
  end

  def node_in_last_route?(node, route)
    # byebug
    if route.last.find { |route_node| node.data == route_node.data }
      true
    else
      false
    end
  end
end

[[[0, 0], [1, 2], [2, 1], [0, 2], [1, 0], [2, 2], [0, 1], [2, 0]]]