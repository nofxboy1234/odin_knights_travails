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

      node_in_another_route = routes.any? do |route|
        route.include?(current)
      end
      next if node_in_another_route

      if current == destination
        current_route = route(current, root_node)
        routes.push(route_shortened(current_route))
        p routes
        next
      end

      current.children.each do |child_node|
        next if child_node == root_node ||
                route(current, root_node).include?(child_node)

        child_node.parent = current
        queue.push(child_node)
      end
    end

    shortest_route(routes)
  end

  def route_shortened(route)
    # Are there nodes further down in the route that are also children of the root_node?
    route.each_with_index do |parent_node, parent_index|
      later_child_node = nil
      route.reverse.each do |child_node|
        if parent_node.children.include?(child_node)
          later_child_node = child_node
          break
        end
      end
      
      if later_child_node
        later_index = route.index(later_child_node)
        # cut out the inbetween nodes
        shortened = route[..parent_index] + route[later_index..]
        return shortened
      end
    end

    route
  end

  def shortest_route(routes)
    shortest = nil
    routes.each do |route|
      if shortest
        shortest = route if route.length < shortest.length
      else
        shortest = route
      end
    end

    shortest
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
