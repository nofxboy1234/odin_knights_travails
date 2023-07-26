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
    
    all_possible_routes = draw_routes(stops, destination_node)
    # byebug
    puts 'end'
    # shortest_route = nil
    # byebug
    # routes.each do |route|
    #   shortest_route = route if (route.length - 1) > (shortest_route.length - 1)
    # end
    # shortest_route
  end

  private
  
  # Follow ALL possible routes
  # Each Orange array is a route_piece
  # A route_piece will start (get created) at a child iteration (recurse).
  # A route piece will be added to routes array when destination is reached.
  # route_piece = [[[0, 0], [1, 2]]]
  # route_piece = [        [[2, 1], [0, 2], [1, 0], [2, 2], [0, 1], [2, 0], [1, 2]]]
  # route_piece = [                                [[a, a], [b, b], [1, 2]]]

  # more than 1 path? - recursion
  # how to record all path options? - recursion
  def draw_routes(root, destination, routes = [], route_piece = [])
    byebug
    
    if root == destination
      route_piece << root
      return routes
    end
    
    route_piece = []
    route_piece << root
    routes << route_piece

    root.children.each do |child_node|
      # rubocop:disable Style/IfUnlessModifier
      # unless route_piece.include?(child_node)
      unless routes.flatten.include?(child_node)
        draw_routes(child_node, destination, routes, route_piece)
      end
      # rubocop:enable Style/IfUnlessModifier
    end
    routes
  end
end
