class Screen
  attr_reader :width, :rows, :position

  def initialize(width = 40)
    @width = width
    @rows = []
    @position = 0
  end

  def clock(x)
    if position % 40 == 0
      rows << []
      @position = 0
    end
    if (position - 1) == x || position == x || (position + 1) == x
      rows.last << "#"
    else
      rows.last << "."
    end
    @position += 1
  end

  def display
    rows.each do |row|
      puts row.join("")
    end
  end

end

class Cpu
  attr_reader :x, :cycle, :instructions

  def initialize(instructions, screen = nil)
    @x = 1
    @cycle = 1
    @instructions = instructions
    @signals = []
    @screen = screen
  end

  def run
    instructions.each do |instruction|
      if instruction == "noop"
        advance_cycle
      else
        value = instruction.split.last.to_i
        advance_cycle
        advance_cycle
        @x += value
      end
      # puts "Instruction #{instruction}, X: #{x}, Cycle: #{cycle}"
    end
  end

  def total_signal_strength
    @signals.sum
  end

  private

  def advance_cycle
    if cycle == 20 || (cycle > 20 && (cycle - 20) % 40 == 0)
      strength = cycle * x
      @signals << strength
      puts "Cycle #{cycle} - X #{x}, strength #{strength}"
    end
    if @screen
      @screen.clock(x)
    end
    @cycle += 1
  end

end

instructions = File.open("day10/input.txt").read.split("\n")
screen = Screen.new
cpu = Cpu.new(instructions, screen)
cpu.run

puts "Signal strength: #{cpu.total_signal_strength}"

# Part 2

puts "\n"
puts "Part 2\n\n"
screen.display

