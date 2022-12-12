class Position
  # include Comparable

  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    "(#{x},#{y})"
  end

  def ==(other)
    x == other.x && y == other.y
  end

  # def <=>(other)

  # end

  def distance_to(other)
    ([x, other.x].max - [x, other.x].min) + ([y, other.y].max - [y, other.y].min)
  end
end

class Rope
  attr_reader :head, :tail

  def initialize
    @head = Position.new(0, 0)
    @tail = Position.new(0, 0)
    @tail_locations = [@tail]
  end

  def move_right(n = 1)
    n.times do
      @head = Position.new(head.x + 1, head.y)
      if head.distance_to(tail) > 1
        @tail = Position.new(head.x - 1, head.y)
        @tail_locations << @tail
      end
    end
  end
  
  def move_left(n = 1)
    n.times do
      @head = Position.new(head.x - 1, head.y)
      if head.distance_to(tail) > 1
        @tail = Position.new(head.x + 1, head.y)
        @tail_locations << @tail
      end
    end
  end
  
  def move_up(n = 1)
    n.times do
      @head = Position.new(head.x, head.y + 1)
      if head.distance_to(tail) > 1
        @tail = Position.new(head.x, head.y - 1)
        @tail_locations << @tail
      end
    end
  end
  
  def move_down(n = 1)
    n.times do
      @head = Position.new(head.x, head.y - 1)
      if head.distance_to(tail) > 1
        @tail = Position.new(head.x, head.y + 1)
        @tail_locations << @tail
      end
    end
  end

  def unique_tail_locations
    @tail_locations.uniq
  end

end

class Instruction
  attr_reader :direction, :distance

  def initialize(text)
    @direction, @distance = text.split(" ")
    @distance = @distance.to_i
  end

  def to_s
    "#{direction} #{distance}"
  end

  def follow(rope)
    if direction == "R"
      rope.move_right(distance)
    elsif direction == "L"
      rope.move_left(distance)
    elsif direction == "U"
      rope.move_up(distance)
    elsif direction == "D"
      rope.move_down(distance)
    else
      raise "Unknown direction: #{direction}"
    end
  end

end

def display_grid(rope, width = 6, height = 5)
  (0..height-1).to_a.reverse.each do |y|
    row = []
    (0..width-1).each do |x|
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

def display_tail_locations(locations, width = 6, height = 5)
  (0..height-1).to_a.reverse.each do |y|
    row = []
    (0..width-1).each do |x|
      if locations.include?(Position.new(x, y))
        row << "#"
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
instructions = File.open("day9/example.txt").read.split("\n").map { |line| Instruction.new(line) }

display_grid(rope)
instructions.each do |instruction|
  instruction.follow(rope)
  display_grid(rope)
end

puts "Unique tail locations: #{rope.unique_tail_locations.size}"
display_tail_locations(rope.unique_tail_locations)