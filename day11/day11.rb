class Monkey
  attr_accessor :troop
  attr_reader :index, :items, :inspected_items

  def initialize(index:, starting_items:, operation:, test:, if_true:, if_false:)
    @troop = nil
    @index = index
    @items = starting_items
    @inspected_items = 0
    @operation = operation
    @test = test
    @if_true = if_true
    @if_false = if_false
  end

  def take_turn(reduce_worry)
    while items.size > 0
      inspect_next_item(reduce_worry)
    end
  end

  def receive(item)
    @items.push(item)
  end

  def to_s
    "Monkey #{index}: [#{items.join(", ")}]"
  end

  private

  def inspect_next_item(reduce_worry)
    item = items.shift
    @inspected_items += 1
    if reduce_worry
      item = @operation.call(item) / 3
    else
      item = @operation.call(item) % troop.reducing_factor
    end

    if @test.call(item)
      troop.throw_to(item, @if_true)
    else
      troop.throw_to(item, @if_false)
    end
  end

end

class Troop
  attr_reader :monkeys

  def initialize()
    @monkeys = {}
  end

  def add_monkey(monkey)
    monkey.troop = self
    @monkeys[monkey.index] = monkey
  end

  def perform_round(reduce_worry = true)
    @monkeys.values.each do |monkey|
      monkey.take_turn(reduce_worry)
    end
  end

  def throw_to(item, index)
    @monkeys[index].receive(item)
  end

  def to_s
    @monkeys.values.map(&:to_s).join("\n")
  end

  def reducing_factor
    # Input
    [3, 11, 7, 2, 19, 5, 17, 13].reduce(1) { |acc, n| acc.lcm(n) }
    
    # Example
    # [23, 19, 13, 17].reduce(1) { |acc, n| acc.lcm(n) }
  end

end

# Example

example_monkey_0 = Monkey.new(index: 0, starting_items: [79, 98], operation: -> (item) { item * 19 }, test: -> (item) { item % 23 == 0 }, if_true: 2, if_false: 3)
example_monkey_1 = Monkey.new(index: 1, starting_items: [54, 65, 75, 74], operation: -> (item) { item + 6 }, test: -> (item) { item % 19 == 0 }, if_true: 2, if_false: 0)
example_monkey_2 = Monkey.new(index: 2, starting_items: [79, 60, 97], operation: -> (item) { item * item }, test: -> (item) { item % 13 == 0 }, if_true: 1, if_false: 3)
example_monkey_3 = Monkey.new(index: 3, starting_items: [74], operation: -> (item) { item + 3 }, test: -> (item) { item % 17 == 0 }, if_true: 0, if_false: 1)

example_troop = Troop.new
example_troop.add_monkey(example_monkey_0)
example_troop.add_monkey(example_monkey_1)
example_troop.add_monkey(example_monkey_2)
example_troop.add_monkey(example_monkey_3)

20.times { example_troop.perform_round(true) }

# 10000.times do |i|
#   example_troop.perform_round(false)
#   if (i % 100 == 0)
#     puts "#{i}"
#   end
# end

puts ""
puts example_troop.monkeys.values.map { |monkey| "Monkey #{monkey.index} inspected items #{monkey.inspected_items} times" }

# Part 1

puts "\nPart 1\n\n"

monkey_0 = Monkey.new(index: 0, starting_items: [56, 56, 92, 65, 71, 61, 79], operation: -> (item) { item * 7 }, test: -> (item) { item % 3 == 0 }, if_true: 3, if_false: 7)
monkey_1 = Monkey.new(index: 1, starting_items: [61, 85], operation: -> (item) { item + 5 }, test: -> (item) { item % 11 == 0 }, if_true: 6, if_false: 4)
monkey_2 = Monkey.new(index: 2, starting_items: [54, 96, 82, 78, 69], operation: -> (item) { item * item }, test: -> (item) { item % 7 == 0 }, if_true: 0, if_false: 7)
monkey_3 = Monkey.new(index: 3, starting_items: [57, 59, 65, 95], operation: -> (item) { item + 4 }, test: -> (item) { item % 2 == 0 }, if_true: 5, if_false: 1)
monkey_4 = Monkey.new(index: 4, starting_items: [62, 67, 80], operation: -> (item) { item * 17 }, test: -> (item) { item % 19 == 0 }, if_true: 2, if_false: 6)
monkey_5 = Monkey.new(index: 5, starting_items: [91], operation: -> (item) { item + 7 }, test: -> (item) { item % 5 == 0 }, if_true: 1, if_false: 4)
monkey_6 = Monkey.new(index: 6, starting_items: [79, 83, 64, 52, 77, 56, 63, 92], operation: -> (item) { item + 6 }, test: -> (item) { item % 17 == 0 }, if_true: 2, if_false: 0)
monkey_7 = Monkey.new(index: 7, starting_items: [50, 97, 76, 96, 80, 56], operation: -> (item) { item + 3 }, test: -> (item) { item % 13 == 0 }, if_true: 3, if_false: 5)

troop = Troop.new
troop.add_monkey(monkey_0)
troop.add_monkey(monkey_1)
troop.add_monkey(monkey_2)
troop.add_monkey(monkey_3)
troop.add_monkey(monkey_4)
troop.add_monkey(monkey_5)
troop.add_monkey(monkey_6)
troop.add_monkey(monkey_7)

puts troop
20.times { troop.perform_round }
puts ""
puts troop

puts ""
puts troop.monkeys.values.map { |monkey| "Monkey #{monkey.index} inspected items #{monkey.inspected_items} times" }

# Part 2

puts "\nPart 2\n\n"

puts troop.reducing_factor

10000.times do |i|
  troop.perform_round(false)
  if (i % 100 == 0)
    puts "#{i}"
  end
end
puts troop.monkeys.values.map { |monkey| "Monkey #{monkey.index} inspected items #{monkey.inspected_items} times" }


# Wrong
# 126048 * 120409 = 15177313632