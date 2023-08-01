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

  def draw_routes_iterative(current, destination)
    byebug

    route = []
    routes = {}
    routes[current] = {}

    stack = []
    stack.push(current)

    while stack.length.positive?
      current = stack.pop
      route.push(current)
      
      if current == destination
        puts 'destination reached!'

        if routes[current]
          route.each do |node|
            routes[]
          end

          routes[current][]
        else
          routes[current] = {}
        end

        route = []
        next
      end

      current.children.each do |child_node|
        unless 
          
          stack.push(child_node) 
        end
      end
    end
    
    # byebug
  end

  def node_is_start_node?(child_node)
    child_node.data == position
  end

  def node_visited?(child_node, routes)
    routes
  end

end
