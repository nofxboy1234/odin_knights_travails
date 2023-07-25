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
    root_node = stops
    destination_node = Node.new(Position.new(destination.first, destination.last))
    routes = draw_routes(root_node, destination_node)

    shortest_route = nil
    routes.each do |route|
      shortest_route = route if (route.length - 1) > (shortest_route.length - 1)
    end
    shortest_route
  end

  private

  def draw_routes(root, destination, routes = [])
    # byebug
    # Add root node to routes array
    routes << root
    # if root.data == position
    # else
    #   routes << root
    # end
    # If the chosen child.data == destination, return routes array
    return routes if root.data == destination.data

    # <Iterate> through each child in children
    root.children.each do |child_node|
      # Route through next child (Recurse) - exclude past nodes in routes array .last
      if routes.last.find { |node| node.data == child_node.data }
        next
      else
        draw_routes(child_node, destination, routes)
      end
    end

    # Return routes array
    routes
  end
end
