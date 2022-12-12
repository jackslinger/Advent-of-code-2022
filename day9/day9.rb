class Position
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def ==(other)
    x == other.x && y == other.y
  end
end

class Rope
  attr_reader :head, :tail

  def initialize
    @head = Position.new(0, 0)
    @tail = Position.new(0, 0)
  end

  def move_right
    @head = Position.new(head.x + 1, head.y)
  end

end

def display_grid(rope, width = 5, height = 5)
  (0..4).to_a.reverse.each do |y|
    row = []
    (0..4).each do |x|
      if rope.head == Position.new(x, y)
        row << "H"
      elsif rope.tail == Position.new(x, y)
        row << "T"
      else
        row << "."
      end
    end
    puts row.join("")
  end
  puts "\n"
end

# Part 1

rope = Rope.new

display_grid(rope)
rope.move_right
display_grid(rope)
rope.move_right
display_grid(rope)