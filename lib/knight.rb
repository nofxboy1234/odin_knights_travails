require_relative 'graph/node'
require_relative 'position'
require_relative 'stack_status'

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
    stack_status = StackStatus.new('winding')
    all_possible_routes = draw_routes(current_position_node, destination_node, stack_status)
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

  def draw_routes(node, destination, stack_status, visited_nodes = [], routes = [])
    byebug
    visited_nodes.push(node) unless node_in_same_position_as_knight?(node)
    stack_status.status = 'winding'

    # base case
    if node == destination
      puts 'found destination!'
      routes.push(visited_nodes.clone)
      visited_nodes.clear
      stack_status.status = 'unwinding'
      return
    end

    # recursive case
    node.children.each do |child_node|
      unless node_visited?(child_node, routes, visited_nodes, stack_status)
        draw_routes(child_node, destination, stack_status, visited_nodes, routes)
      end
    end

    # return?
  end

  def first_child?(parent_node, child_node)
    parent_node.children.first == child_node
  end

  def node_visited?(child_node, routes, visited_nodes, stack_status)
    node_in_same_position = node_in_same_position_as_knight?(child_node)
    
    if stack_status.unwinding?
      visited = routes.last.include?(child_node)
    elsif stack_status.winding?
      visited = visited_nodes.include?(child_node)
    end

    node_in_same_position || visited
  end

  def node_in_same_position_as_knight?(node)
    node.data == position
  end

  # def unwinding_stack?(visited_nodes)
  #   visited_nodes.empty?
  # end
end

