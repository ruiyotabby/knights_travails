class Node
  attr_accessor :parent, :data, :distance

  def initialize(data)
    @data = data
    @parent = nil
    # @distance = Float::INFINITY
  end
end

def create_adjacent(node)
  temp = node.dup
  values = []
  moves =[[2,1],[1,2],[2,-1],[1,-2],[-2,-1],[-2,1],[-1,-2],[-1,2]]
  moves.each {|i,j| values << add_adjacent(temp, i, j)}
  values = values.compact
  values
end

def add_adjacent(node, col, row)
  value = []
  value << node[0] + col
  value << node[1] + row
  value.each {|i| value.delete(i) if (i < 0 || i > 7)}
  return value if value.length > 1
  return
end

def check_array(item, arr)
  return if arr.nil?
  arr.each {|i| return 0 if i.data == item}
  return 1
end

def knight_moves(source, destination)
  unvisited = visited = []
  unvisited.push(Node.new(source))
  until unvisited.empty?
    del = unvisited.shift
    visited << del
    values = create_adjacent(del.data)
    values.each do |item| 
      next unless check_array(item, visited) == 1
      next unless check_array(item, unvisited) == 1
      item = Node.new item
      item.parent = del
      unvisited << item
      if item.data == destination
        result = []
        until item.nil?
          result << item.data
          item = item.parent
        end
        puts "You made it in #{result.length-1} moves. Here's your path."
        return result.reverse.each {|i| p i}
      end
    end
  end
end

knight_moves([3,3],[4,3])
