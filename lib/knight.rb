require_relative 'graph/node'
require_relative 'position'

require 'pry-byebug'
require_relative 'graph/byebug_syntax_highlighting'

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

  def route_shortened2(route)
    # byebug
    route.each_with_index do |parent_node, parent_index|
      next_index = parent_index + 1
      route[(next_index)..].each do |child_node|
        next unless parent_node.children.include?(child_node)

        child_index = route.index(child_node)
        # cut out the inbetween nodes
        route.slice!(next_index...child_index)
      end
    end

    route
  end

  private

  def draw_routes_iterative(current, destination)
    root_node = current

    queue = []
    queue.push(current)

    until queue.empty?
      current = queue.shift

      if current == destination
        current_route = route(current, root_node)
        return route_shortened2(current_route)
      end

      current.children.each do |child_node|
        next if child_node == root_node ||
                route(current, root_node).include?(child_node)

        child_node.parent = current
        queue.push(child_node)
      end
    end
  end

  def route_shortened(route)
    # Are there nodes further down in the route that are also children of the current parent?
    route.each_with_index do |parent_node, parent_index|
      later_child_node = nil
      route.reverse.each do |child_node|
        if parent_node.children.include?(child_node)
          later_child_node = child_node
          break
        end
      end

      next unless later_child_node

      later_index = route.index(later_child_node)
      # cut out the inbetween nodes
      shortened = route[..parent_index] + route[later_index..]
      return shortened
    end

    route
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

# p1 = Position.new(1, 1)
# p2 = Position.new(2, 1)
# p3 = Position.new(3, 1)
# p4 = Position.new(4, 1)
# p5 = Position.new(5, 1)
# p6 = Position.new(6, 1)
# p7 = Position.new(7, 1)
# p8 = Position.new(8, 1)

# n1 = Node.new(p1)
# n2 = Node.new(p2)
# n3 = Node.new(p3)
# n4 = Node.new(p4)
# n5 = Node.new(p5)
# n6 = Node.new(p6)
# n7 = Node.new(p7)
# n8 = Node.new(p8)

# n1.children = [n5]
# n5.children = [n8]

# route = [n1, n2, n3, n4, n5, n6, n7, n8]

# knight = Knight.new(p1)

# # 1,1->5,1->8,1
# p knight.route_shortened2(route)


# byebug
# a = %w[a b c d e f]
# a.each do |element|
#   # a = %w[x y z]
#   # a[5] = 'z' if element == 'a'
#   # a.delete_at(5) if element == 'a'
#   a.slice!(1...5) if element == 'a'
#   p element
# end
# p a
