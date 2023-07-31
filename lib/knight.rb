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
    # draw_routes(current_position_node, destination_node)
    draw_routes_iterative(current_position_node, destination_node)

    # shortest_route = nil
    # routes.each do |route|
    #   shortest_route = route if (route.length - 1) > (shortest_route.length - 1)
    # end
    # shortest_route
  end

  private

  # def level_order_iterative(&my_block)
  #   return if root.nil?

  #   queue = []
  #   queue.push(root)

  #   values = []
  #   while queue.length.positive?
  #     current = queue.shift

  #     if block_given?
  #       puts my_block.call(current)
  #     else
  #       values.push(current.data)
  #     end

  #     queue.push(current.left) if current.left
  #     queue.push(current.right) if current.right
  #   end

  #   values unless block_given?
  # end

  def draw_routes_iterative(node, destination)
    byebug

    queue = []
    queue.push(node)

    parent_children = {}

    while queue.length.positive?
      current = queue.shift
      
      next if current.data == position

      if current == destination
        parent_children[current] = nil
        next
      end

      parent_children[current] = {}

      current.children.each do |child_node|
        queue.push(child_node)
        parent_children[current][child_node] = {}
      end
    end
    
    # byebug
  end

  def draw_routes(node, destination, node_chain = [], routes = {})
    byebug
    
    # base case
    if node == destination
      child_chain = node_chain.clone
      child_chain.push(node)
      return child_chain
    else
      # recursive case
      child_chains = []
      node.children.each do |child_node|
        unless node_visited?(child_node, routes, node_chain)
          child_chain = draw_routes(child_node, destination, node_chain, routes)
          child_chains.push(child_chain)
        end
      end

      node_chain.push(node)
      routes[node_chain] = child_chains
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
