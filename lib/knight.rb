# frozen_string_literal: true

require_relative 'graph/graph'
require_relative 'graph/node'
require_relative 'position'

require 'pry-byebug'

# Knight represents the chess piece and the moves it can do
class Knight
  attr_reader :position, :moves, :board, :queue, :all_routes

  def initialize(position, board)
    @moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]
    @queue = []
    @all_routes = []
    @position = position
    @board = board
  end

  def graph
    @graph ||= Graph.new(board, self)
  end

  def root_node
    @root_node ||= graph.root
  end

  def shortest_path_to_destination(destination)
    destination_node = Node.new(Position.new(destination.first, destination.last))

    queue.push(root_node)
    draw_routes_iterative(root_node, destination_node)

    puts 'all routes:'
    all_routes.each { |route| p route }
    puts "\n"

    shortest_route
  end

  def shortest_route
    shortest = nil
    all_routes.each do |route|
      if shortest
        shortest = route if route.length < shortest.length
      else
        shortest = route
      end
    end

    shortest
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

  def exists_in_all_routes?(current_route)
    all_routes.any? do |route|
      route == route_shortened(current_route)
    end
  end

  def draw_routes_iterative(current, destination)
    until queue.empty?
      current = queue.shift
      if current == destination
        current_route = route(current, root_node)
        # rubocop:disable Style/IfUnlessModifier
        unless exists_in_all_routes?(current_route)
          all_routes.push(route_shortened(current_route))
        end
        # rubocop:enable Style/IfUnlessModifier
      else
        add_children_to_queue(current, root_node, queue)
      end
    end
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
