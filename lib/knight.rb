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
    # root_node = Node.new(position)
    destination_node = Node.new(Position.new(destination.first, destination.last))
    # route = [root_node]
    
    current_position_node = stops
    draw_routes(current_position_node, destination_node)
    # shortest_route = nil
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

  def draw_routes(node, destination, node_chain = [], routes = {})
    byebug
    node_chain.push(node)
    child_chain = node_chain.clone
    
    # base case
    if node == destination
      puts 'found destination!'
      return child_chain
    end
    
    # recursive case
    node.children.each do |child_node|
      unless node_visited?(child_node, routes, node_chain)
        child_chain = draw_routes(child_node, destination, node_chain.clone, routes)
        # node_chain.pop

        if routes[node_chain]
          routes[node_chain].push(child_chain.clone)
        else
          routes[node_chain] = [child_chain.clone]
        end
      end
    end

    # return?
    routes
  end

  def first_child?(parent_node, child_node)
    parent_node.children.first == child_node
  end

  def node_visited?(child_node, routes, node_chain)
    is_direct_visited_child = direct_visited_child?(routes, node_chain, child_node)
    child_in_tail = child_in_tail?(node_chain, child_node)
    is_direct_visited_child || child_in_tail

    # if stack_status.unwinding?
    #   is_direct_visited_child = direct_visited_child?(routes, node_chain, child_node)
    #   child_in_tail = child_in_tail?(routes, child_node)

    #   visited = is_direct_visited_child || child_in_tail
    # elsif stack_status.winding?
    #   visited = child_in_tail?(node_chain, child_node)
    # end

    # visited
  end

  def direct_visited_child?(routes, node_chain, child_node)
    return false unless routes[node_chain]

    routes[node_chain].any? do |child_chain|
      child_chain.first == child_node
    end
  end

  def child_in_tail?(node_chain, child_node)
    node_chain.include?(child_node)
  end

  def node_in_same_position_as_knight?(node)
    node.data == position
  end
end
