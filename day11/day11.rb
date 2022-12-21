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

  def take_turn
    while items.size > 0
      inspect_next_item
    end
  end

  def receive(item)
    @items.push(item)
  end

  def to_s
    "Monkey #{index}: [#{items.join(", ")}]"
  end

  private

  def inspect_next_item
    item = items.shift
    @inspected_items += 1
    item = @operation.call(item) / 3

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

  def perform_round
    @monkeys.values.each do |monkey|
      monkey.take_turn
    end
  end

  def throw_to(item, index)
    @monkeys[index].receive(item)
  end

  def to_s
    @monkeys.values.map(&:to_s).join("\n")
  end

end

# Example

monkey_0 = Monkey.new(index: 0, starting_items: [79, 98], operation: -> (item) { item * 19 }, test: -> (item) { item % 23 == 0 }, if_true: 2, if_false: 3)
monkey_1 = Monkey.new(index: 1, starting_items: [54, 65, 75, 74], operation: -> (item) { item + 6 }, test: -> (item) { item % 19 == 0 }, if_true: 2, if_false: 0)
monkey_2 = Monkey.new(index: 2, starting_items: [79, 60, 97], operation: -> (item) { item * item }, test: -> (item) { item % 13 == 0 }, if_true: 1, if_false: 3)
monkey_3 = Monkey.new(index: 3, starting_items: [74], operation: -> (item) { item + 3 }, test: -> (item) { item % 17 == 0 }, if_true: 0, if_false: 1)

troop = Troop.new
troop.add_monkey(monkey_0)
troop.add_monkey(monkey_1)
troop.add_monkey(monkey_2)
troop.add_monkey(monkey_3)

puts troop
20.times { troop.perform_round }
puts ""
puts troop

puts ""
puts troop.monkeys.values.map { |monkey| "Monkey #{monkey.index} inspected items #{monkey.inspected_items} times" }

# puts monkey_0
# puts monkey_2
# puts monkey_3