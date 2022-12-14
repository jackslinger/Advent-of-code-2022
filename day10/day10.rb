class Cpu
  attr_reader :x, :cycle, :instructions

  def initialize(instructions)
    @x = 1
    @cycle = 1
    @instructions = instructions
    @signals = []
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
    @cycle += 1
  end

end

instructions = File.open("day10/input.txt").read.split("\n")
cpu = Cpu.new(instructions)
cpu.run

puts "Signal strength: #{cpu.total_signal_strength}"

