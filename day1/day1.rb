class Elf
  attr_reader :food

  def initialize(string_representation)
    @food = string_representation.split("\n").map(&:to_i)
  end

  def total_calories
    food.sum
  end
end

elves = File.open("day1/input.txt").read.split("\n\n").map{ |string| Elf.new(string) }
puts "Highest calorie elf is carying: #{elves.map(&:total_calories).max}"
puts "Calorie sum of the top three elves: #{elves.map(&:total_calories).sort.reverse[0...3].sum}"