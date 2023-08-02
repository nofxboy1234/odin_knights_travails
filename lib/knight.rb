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
  end

  private

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
    root_node = current

    queue = []
    queue.push(current)

    until queue.empty?
      current = queue.shift

      # --base case
      if current == destination
        puts 'destination reached!'
        # --return value
        return route(current, root_node)
      end

      # --recursive case
      current.children.each do |child_node|
        next if child_node == root_node ||
                route(current, root_node).include?(child_node)

        child_node.parent = current
        queue.push(child_node)
      end
    end
  end

  def route(current_node, root_node)
    route = []

    until current_node == root_node
      route.unshift(current_node)
      current_node = current_node.parent
    end
    route.unshift(root_node)

    route
  end
end
