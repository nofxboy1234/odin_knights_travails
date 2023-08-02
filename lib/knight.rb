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

  def route_to_parent_of_child(routes, root_node, child, parent = nil)
    parent = routes[root_node]

    # base case
    if parent.children.include?(child)
      route = []
      route.unshift(parent)

      node = parent
      until node == root_node
        route.unshift(node)
        node = node.parent
      end
      route.unshift(root_node)

      return route
    end

    # recursive case
    route_to_parent_of_child(routes, root_node, child, parent)
  end

  def draw_routes_iterative(current, destination)
    # byebug

    root_node = current

    route = []
    # routes = {}
    # routes[current] = {}

    queue = []
    queue.push(current)

    until queue.empty?
      # if current.parent
      #   unless current.children.include?(queue.first)

      #     # go back to node that has queue.first as a child
      #     until route.last.children.include?(queue.first)
      #       route.pop
      #     end
      #   end
      # end

      current = queue.shift
      route.push(current)

      # --base case
      if current == destination
        puts 'destination reached!'
        # traverse back to root node and count 'moves' to get shortest route
        shortest_route = []
        until current == root_node
          shortest_route.unshift(current)
          current = current.parent
        end
        shortest_route.unshift(root_node)

        return shortest_route
      end

      # --recursive case

      # current_child_routes = routes.dig(*route)
      # unless current_child_routes
      #   route_to_parent = route[0..-2]
      #   routes.dig(*route_to_parent)[current] = {}
      # end

      current.children.each do |child_node|
        next if child_node == root_node ||
                route.include?(child_node)

        # routes.dig(*route)[child_node] = {}

        child_node.parent = current
        queue.push(child_node)
      end
    end
  end

  # def node_is_start_node?(child_node)
  #   child_node.data == position
  # end

  # def node_visited?(child_node, routes, route)
  #   has_existing_child_route = routes.dig(*route).has_key?(child_node)
  #   child_node_in_current_route = route.include?(child_node)

  #   has_existing_child_route || child_node_in_current_route
  # end
end
