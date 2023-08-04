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
    destination_node = Node.new(Position.new(destination.first, destination.last))
    current_position_node = stops

    draw_routes_iterative(current_position_node, destination_node)
  end

  private

  def draw_routes_iterative(current, destination)
    root_node = current

    queue = []
    queue.push(current)

    routes = []
    until queue.empty?
      current = queue.shift

      current_route = route(current, root_node)
      route_piece_exists = routes.any? do |route|
        (route & current_route) == current_route
      end
      next if route_piece_exists

      # --base case
      if current == destination
        puts 'destination reached!'

        # --return value
        # return route(current, root_node)
        byebug
        routes.push(route(current, root_node))
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
