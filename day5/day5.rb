# Read the file and split into starting state and instructions

# Example
# diagram, instructions = File.open("day5/example.txt").read.split("\n\n")

# TODO: Read the state from the diagram
#     [D]    
# [N] [C]    
# [Z] [M] [P]
#  1   2   3 
# state = [
#   ["Z", "N"],
#   ["M", "C", "D"],
#   ["P"]
# ]

diagram, instructions = File.open("day5/input.txt").read.split("\n\n")
#             [C]         [N] [R]    
# [J] [T]     [H]         [P] [L]    
# [F] [S] [T] [B]         [M] [D]    
# [C] [L] [J] [Z] [S]     [L] [B]    
# [N] [Q] [G] [J] [J]     [F] [F] [R]
# [D] [V] [B] [L] [B] [Q] [D] [M] [T]
# [B] [Z] [Z] [T] [V] [S] [V] [S] [D]
# [W] [P] [P] [D] [G] [P] [B] [P] [V]
#  1   2   3   4   5   6   7   8   9 

state = [
  ["W", "B", "D", "N", "C", "F", "J"],
  ["P", "Z", "V", "Q", "L", "S", "T"],
  ["P", "Z", "B", "G", "J", "T"],
  ["D", "T", "L", "J", "Z", "B", "H", "C"],
  ["G", "V", "B", "J", "S"],
  ["P", "S", "Q"],
  ["B", "V", "D", "F", "L", "M", "P", "N"],
  ["P", "S", "M", "F", "B", "D", "L", "R"],
  ["V", "D", "T", "R"]
]


class Cargo
  attr_reader :stacks

  def initialize(crates_as_arrays)
    @stacks = crates_as_arrays.map(&:clone)
  end

  def to_s
    # TODO: Display in the same way as the puzzle
    stacks.map{ |line| line.join(" ") }.join("\n")
  end

  def follow_instruction(instruction)
    instruction.quantity.times.each do
      stacks[instruction.target - 1].push(stacks[instruction.origin - 1].pop)
    end
  end

  def follow_instruction_9001(instruction)
    to_move = stacks[instruction.origin - 1].last(instruction.quantity)
    instruction.quantity.times.each { stacks[instruction.origin - 1].pop }
    stacks[instruction.target - 1] += to_move
  end

  def tops
    stacks.map(&:last)
  end

end

class Instruction
  attr_reader :quantity, :origin, :target

  def initialize(text)
    capture = text.match(/move (\d+) from (\d+) to (\d+)/)
    @quantity = capture[1].to_i
    @origin = capture[2].to_i
    @target = capture[3].to_i
  end

  def to_s
    "Move #{quantity} from #{origin} to #{target}."
  end

end

instructions = instructions.split("\n").map{ |text| Instruction.new(text) }

# Part 1
puts "Part 1\n"

cargo = Cargo.new(state)
puts cargo


instructions.each do |instruction|
  cargo.follow_instruction(instruction)
end

puts "\n"
puts cargo
puts cargo.tops.join("")

# Part 2
puts "\nPart 2\n"

cargo = Cargo.new(state)
puts cargo

instructions.each do |instruction|
  cargo.follow_instruction_9001(instruction)
end

puts "\n"
puts cargo
puts cargo.tops.join("")