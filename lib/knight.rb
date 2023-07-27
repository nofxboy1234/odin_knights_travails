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
  # [[{1, 2}], [{2, 1}], [{0, 2}], [{1, 0}], [{2, 2}], [{0, 1}], [{2, 0}]]

  def draw_routes(root, destination, routes = [], route_piece = [])
    byebug
    route_piece.push(root) unless root.data == position
    
    if root == destination
      routes << route_piece
      return
    end
    
    root.children.each do |child_node|
      # rubocop:disable Style/IfUnlessModifier
      unless route_piece.include?(child_node) || child_node.data == position
        draw_routes(child_node, destination, routes, route_piece)
        route_piece = []
      end
      # rubocop:enable Style/IfUnlessModifier
    end
  end

  # def draw_routes(root, destination, routes = [], route_piece = [])
  #   # byebug
    
  #   route_piece.push(root) unless root.data == position

  #   if root == destination
  #     routes << route_piece
  #     return
  #   end
    
  #   root.children.each do |child_node|
  #     # rubocop:disable Style/IfUnlessModifier
  #     unless route_piece.include?(child_node) || child_node.data == position
  #       draw_routes(child_node, destination, routes, route_piece)

  #       # Create new route pieces and add to routes when destination reached
  #       route_piece = []
  #     end
  #     # rubocop:enable Style/IfUnlessModifier
  #   end
  #   routes
  # end
end
