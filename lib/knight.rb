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
    destination_node = Node.new(Position.new(destination.first, destination.last))
    current_position_node = stops

    draw_routes_iterative(current_position_node, destination_node)

    # Find routes in routes hash that end with a value of {} (destination was reached)
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

  def draw_routes_iterative(root_node, destination)
    byebug

    route = []
    routes = {}
    routes[root_node] = {}

    queue = []
    queue.push(root_node)

    while queue.length.positive?
      current = queue.shift
      route.push(current)

      if current == destination
        puts 'destination reached!'

        route.pop until route.last == current.parent

        next
      end

      # route.pop until route.last == current.parent if current.parent

      current_child_routes = routes.dig(*route)
      unless current_child_routes
        route_to_parent = route[0..-2]
        routes.dig(*route_to_parent)[current] = {}
      end

      current.children.each do |child_node|
        next if node_is_start_node?(child_node) ||
                node_visited?(child_node, routes, route)

        routes.dig(*route)[child_node] = {}

        child_node.parent = current
        queue.push(child_node)
      end
    end

    routes
    # byebug
  end

  def node_is_start_node?(child_node)
    child_node.data == position
  end

  def node_visited?(child_node, routes, route)
    has_existing_child_route = routes.dig(*route).has_key?(child_node)
    child_node_in_current_route = route.include?(child_node)

    has_existing_child_route || child_node_in_current_route
  end
end
