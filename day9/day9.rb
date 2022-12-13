class Position
  include Comparable
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

  # def distance_to(other)
  #   ([x, other.x].max - [x, other.x].min) + ([y, other.y].max - [y, other.y].min)
  # end
end

class Rope
  attr_reader :head, :tail

  def initialize
    @head = Position.new(0, 0)
    @tail = Position.new(0, 0)
    @tail_locations = [@tail]
  end

  def move_right()
    @head = Position.new(head.x + 1, head.y)
    if tail_to_far?
      # @tail = Position.new(head.x - 1, head.y)
      move_tail
      @tail_locations << @tail
    end
  end
  
  def move_left()
    @head = Position.new(head.x - 1, head.y)
    if tail_to_far?
      # @tail = Position.new(head.x + 1, head.y)
      move_tail
      @tail_locations << @tail
    end
  end
  
  def move_up()
    @head = Position.new(head.x, head.y + 1)
    if tail_to_far?
      # @tail = Position.new(head.x, head.y - 1)
      move_tail
      @tail_locations << @tail
    end
  end
  
  def move_down()
    @head = Position.new(head.x, head.y - 1)
    if tail_to_far?
      # @tail = Position.new(head.x, head.y + 1)
      move_tail
      @tail_locations << @tail
    end
  end

  def unique_tail_locations
    @tail_locations.uniq{ |pos| pos.to_s }
  end

  private

  def tail_to_far?
    # head.distance_to(tail) > 1
    ([head.x, tail.x].max - [head.x, tail.x].min) > 1 || ([head.y, tail.y].max - [head.y, tail.y].min) > 1
  end

  def move_tail
    dx = head.x <=> tail.x
    dy = head.y <=> tail.y
    @tail = Position.new(tail.x + dx, tail.y + dy)
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
    # puts self
    if direction == "R"
      distance.times do
        rope.move_right
        # display_grid(rope)
      end
    elsif direction == "L"
      distance.times do
        rope.move_left
        # display_grid(rope)
      end
    elsif direction == "U"
      distance.times do
        rope.move_up
        # display_grid(rope)
      end
    elsif direction == "D"
      distance.times do
        rope.move_down
        # display_grid(rope)
      end
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
instructions = File.open("day9/input.txt").read.split("\n").map { |line| Instruction.new(line) }

# puts "== Initial state =="
# puts "\n"

# display_grid(rope)

instructions.each do |instruction|
  instruction.follow(rope)
end

puts "Unique tail locations: #{rope.unique_tail_locations.size}"

# max_x = rope.unique_tail_locations.map(&:x).max
# max_y = rope.unique_tail_locations.map(&:y).max
# display_tail_locations(rope.unique_tail_locations, max_x + 1, max_y + 1)

# display_tail_locations(rope.unique_tail_locations)