# frozen_string_literal: true

require_relative 'graph/graph'
require_relative 'graph/node'
require_relative 'position'

require 'pry-byebug'

# Knight represents the chess piece and the moves it can do
class Knight
  attr_reader :position, :moves, :board, :root_node

  def initialize(position, board)
    @moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    @position = position
    @board = board
  end

  def shortest_path_to_destination(destination)
    destination_node = Node.new(Position.new(destination.first, destination.last))
    graph = Graph.new(board, self)
    @root_node = graph.root

    all_routes = draw_routes_iterative(root_node, destination_node)

    puts 'all routes:'
    all_routes.each { |route| p route }
    puts "\n"

    shortest_route(all_routes)
  end

  def shortest_route(all_routes)
    shortest_route = nil
    all_routes.each do |route|
      if shortest_route
        shortest_route = route if route.length < shortest_route.length
      else
        shortest_route = route
      end
    end

    shortest_route
  end

  def route_shortened(route)
    route.each_with_index do |parent_node, parent_index|
      next_index = parent_index + 1
      route[next_index..].each do |child_node|
        next unless parent_node.children.include?(child_node)

        child_index = route.index(child_node)
        # cut out the inbetween nodes
        route.slice!(next_index...child_index)
      end
    end

    route
  end

  private

  def exists_in_all_routes?(all_routes, current_route)
    all_routes.any? do |route|
      route == route_shortened(current_route)
    end
  end

  def draw_routes_iterative(current, destination)
    queue = []
    queue.push(current)

    all_routes = []
    until queue.empty?
      current = queue.shift
      if current == destination
        current_route = route(current, root_node)

        # rubocop:disable Style/IfUnlessModifier
        unless exists_in_all_routes?(all_routes, current_route)
          all_routes.push(route_shortened(current_route))
        end
        # rubocop:enable Style/IfUnlessModifier
        next
      end
      add_children_to_queue(current, root_node, queue)
    end

    all_routes
  end

  def add_children_to_queue(current, root_node, queue)
    current.children.each do |child_node|
      next if child_node == root_node ||
              route(current, root_node).include?(child_node)

      child_node.parent = current

      exists_in_queue = queue.any? do |node|
        route(node, root_node) == route(child_node, root_node)
      end
      next if exists_in_queue

      queue.push(child_node)
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
