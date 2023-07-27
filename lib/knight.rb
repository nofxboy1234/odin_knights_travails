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
    
    current_position_node = stops
    all_possible_routes = draw_routes(current_position_node, destination_node)
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

  def draw_routes(node, destination, visited_nodes = [], routes = [])
    byebug
    visited_nodes.push(node) unless node_in_same_position_as_knight?(node)

    if node == destination
      puts 'found destination!'
      routes.push(visited_nodes.clone)
      visited_nodes.clear
      return
    end

    node.children.each do |child_node|
      unless node_visited?(child_node, visited_nodes)
        draw_routes(child_node, destination, visited_nodes)
      end
    end
    
  end

  def node_visited?(child_node, visited_nodes)
    node_in_same_position_as_knight?(child_node) || visited_nodes.include?(child_node)
  end

  def node_in_same_position_as_knight?(node)
    node.data == position
  end
end
