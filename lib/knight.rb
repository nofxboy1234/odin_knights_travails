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

    until queue.empty?
      current = queue.shift

      # --base case
      if current == destination
        puts 'destination reached!'
        # --return value
        return route(current, root_node)
      end

      # --recursive case
      closest = closest_child(current, destination, root_node)
      closest.parent = current
      queue.push(closest)
    end
  end

  def closest_child(parent, destination, root_node)
    byebug
    closest = nil
    parent.children.each do |child_node|
      next if child_node == root_node ||
              route(parent, root_node).include?(child_node)

      x_distance = (destination.data.x_pos -
                    child_node.data.x_pos).abs

      y_distance = (destination.data.y_pos -
                    child_node.data.y_pos).abs

      next if x_distance < 1 || y_distance < 2

      closest = if closest
                  [closest, child_node].min
                else
                  child_node
                end
    end

    closest
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
