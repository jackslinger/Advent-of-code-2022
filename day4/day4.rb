class Range
  attr_reader :lower_bound, :upper_bound

  def initialize(input)
    @lower_bound, @upper_bound = input.split("-").map(&:to_i)
  end

  def to_s
    "#{lower_bound} - #{upper_bound}"
  end

  def contains?(other)
    lower_bound <= other.lower_bound && upper_bound >= other.upper_bound
  end

  def overlaps?(other)
    (lower_bound <= other.lower_bound && other.lower_bound <= upper_bound) || (lower_bound <= other.upper_bound && upper_bound >= other.upper_bound)
  end
end

class Pair
  attr_reader :first, :second

  def initialize(input)
    a, b = input.split(",")
    @first = Range.new(a)
    @second = Range.new(b)
  end

  def to_s
    "#{first} | #{second}"
  end

  def one_contains_the_other?
    first.contains?(second) || second.contains?(first)
  end

  def overlaps?
    first.overlaps?(second) || second.overlaps?(first)
  end

end

lines = File.readlines("day4/input.txt").map(&:chomp)
pairs = lines.map{ |line| Pair.new(line) }

puts "Size #{pairs.size}"

# puts pairs.map { |pair| "#{pair.first} | #{pair.second} | #{pair.one_contains_the_other? ? "contains" : ""}" }

total = pairs.select{ |pair| pair.one_contains_the_other? }.size
puts "Total contains: #{total}"

overlaps = pairs.select{ |pair| pair.overlaps? }.size
puts "Total overlaps: #{overlaps}"