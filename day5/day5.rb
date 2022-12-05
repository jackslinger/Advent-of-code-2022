# Read the file and split into starting state and instructions
diagram, instructions = File.open("day5/example.txt").read.split("\n\n")
# diagram, instructions = File.open("day5/input.txt").read.split("\n\n")

class Cargo
  attr_reader :stacks

  def initialize(crates_as_arrays)
    @stacks = crates_as_arrays
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

# TODO: Read the state from the diagram
state = [
  ["Z", "N"],
  ["M", "C", "D"],
  ["P"]
]

cargo = Cargo.new(state)
puts cargo

instructions = instructions.split("\n").map{ |text| Instruction.new(text) }

puts "\n"
puts instructions[0]
cargo.follow_instruction(instructions[0])
puts "\n"
puts cargo
