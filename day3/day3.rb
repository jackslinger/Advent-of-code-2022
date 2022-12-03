class Rucksack
  attr_reader :items, :first_compartment, :last_compartment

  def initialize(input)
    @items = input
    @first_compartment = input[0..((input.size / 2) - 1)]
    @last_compartment = input[(input.size / 2)..-1]
  end

  def to_s
    "#{@items} | #{@first_compartment} #{@last_compartment} | #{@items.size} #{@first_compartment.size} #{@last_compartment.size}"
  end

  def shared_items
    first_compartment.split("").uniq.sort & last_compartment.split("").uniq.sort
  end
end

def priority_of_item(item)
  (("a".."z").to_a + ("A".."Z").to_a).index(item) + 1
end

rucksacks = File.readlines("day3/input.txt").map(&:chomp).map{ |line| Rucksack.new(line) }

shared_items = rucksacks.map { |ruck| ruck.shared_items.first }

total = shared_items.map{ |item| priority_of_item(item) }.sum
puts "Total priority of shared items: #{total}"

# Part 2

class Group
  attr_reader :first, :second, :third

  def initialize(first, second, third)
    @first = first
    @second = second
    @third = third
  end

  def shared_items
    first.items.split("").uniq.sort & second.items.split("").uniq.sort & third.items.split("").uniq.sort
  end

end

groups = rucksacks.each_slice(3).map { |rucksacks| Group.new(rucksacks[0], rucksacks[1], rucksacks[2]) }
puts groups.map{ |group| group.shared_items.join(" ") }

badge_total = groups.map{ |group| priority_of_item(group.shared_items.first) }.sum
puts "Total priority of the badges: #{badge_total}"