require "big"

class Aoc2022::Day11
  def self.part_1(input, log = false)
    monkeys = format(input)
    20.times do |round|
      puts "round #{round}".center(20, '=') if log

      monkeys.each do |id, monkey|
        puts "monkey #{id}" if log

        while monkey.has_items?
          item = monkey.pick_item!
          puts "[#{id}] considering item #{item}" if log
          new_worry_level = monkey.apply_operation(initial_worry_level: item) // 3
          target_monkey_id = monkey.monkey_to_throw_to(worry_level: new_worry_level)
          target_monkey = monkeys[target_monkey_id]

          raise "No monkey found with ID=#{target_monkey_id}" unless target_monkey

          puts "[#{id}] throwing item #{new_worry_level} to monkey #{target_monkey.id}" if log
          target_monkey.receive_item!(new_worry_level)
        end
      end
    end

    result(monkeys: monkeys.values)
  end

  def self.part_2(input, log = false)
    monkeys = format(input)
    common_divisor = common_divisor(monkeys.values)

    10_000.times do |round|
      puts "round #{round}".center(20, '=') if round.divisible_by?(500) && log

      monkeys.each do |id, monkey|
        puts "monkey #{id}" if log

        while monkey.has_items?
          item = monkey.pick_item!
          puts "[#{id}] considering item #{item}" if log
          # This is the critical part to keep the worry level (and running time) manageable
          # Only keep the remainder of division by all monkeys divisors multiple
          new_worry_level = monkey.apply_operation(initial_worry_level: item) % common_divisor
          target_monkey_id = monkey.monkey_to_throw_to(worry_level: new_worry_level)
          target_monkey = monkeys[target_monkey_id]

          raise "No monkey found with ID=#{target_monkey_id}" unless target_monkey

          puts "[#{id}] throwing item #{new_worry_level} to monkey #{target_monkey.id}" if log
          target_monkey.receive_item!(new_worry_level)
        end
      end
    end

    result(monkeys: monkeys.values)
  end

  def self.format(input) : Hash(Int32, Monkey)
    input
      .split("\n\n")
      .each_with_object({} of Int32 => Monkey) do |monkey_input, h|
        monkey = Monkey.parse(input: monkey_input)
        h[monkey.id] = monkey
      end
  end

  def self.common_divisor(monkeys : Array(Monkey))
    monkeys
      .map { |m| m.test_divisible_by }
      .reduce(1) { |acc, n| acc * n }
  end

  def self.result(monkeys : Array(Monkey))
    monkeys
      .sort_by { |m| m.inspected_items }
      .last(2)
      .reduce(1) { |acc, m| acc * m.inspected_items }
  end

  class Monkey
    getter id, test_divisible_by
    getter inspected_items : BigInt
    private getter items, operation, if_test_false_throw_to_monkey, if_test_true_throw_to_monkey
    private setter inspected_items : BigInt

    def self.parse(input)
      monkey_lines = input.split("\n", remove_empty: true)
      monkey_id = monkey_lines[0][/\d/]
      monkey_items = monkey_lines[1][/\d.+$/].split(", ")
      monkey_operation = monkey_lines[2][/\= (.*)/, 1]
      monkey_test_divisible_by = monkey_lines[3][/divisible by (\d+)/, 1]
      monkey_if_test_true_throw_to = monkey_lines[4][/throw to monkey (\d+)/, 1]
      monkey_if_test_false_throw_to = monkey_lines[5][/throw to monkey (\d+)/, 1]

      self.new(
        id: monkey_id.to_i,
        items: monkey_items.map { |i| BigInt.new(i) },
        operation: monkey_operation,
        test_divisible_by: monkey_test_divisible_by.to_i,
        if_test_true_throw_to_monkey: monkey_if_test_true_throw_to.to_i,
        if_test_false_throw_to_monkey: monkey_if_test_false_throw_to.to_i
      )
    end

    def apply_operation(initial_worry_level)
      if operation.includes?("*")
        operands = operation.split(" * ").map { |n| n == "old" ? initial_worry_level : BigInt.new(n) }
        operands[0] * operands[1]
      else
        operands = operation.split(" + ").map { |n| n == "old" ? initial_worry_level : BigInt.new(n) }
        operands[0] + operands[1]
      end
    end

    def monkey_to_throw_to(worry_level)
      if test?(worry_level: worry_level)
        if_test_true_throw_to_monkey
      else
        if_test_false_throw_to_monkey
      end
    end

    def has_items?
      items.any?
    end

    def pick_item!
      self.inspected_items += 1
      items.shift
    end

    def receive_item!(item)
      self.items << item
    end

    private def initialize(@id : Int32, @items : Array(BigInt), @test_divisible_by : Int32, @operation : String,
        @if_test_true_throw_to_monkey : Int32, @if_test_false_throw_to_monkey : Int32)
      @inspected_items = BigInt.new(0)
    end

    private def test?(worry_level)
      worry_level.divisible_by?(test_divisible_by)
    end
  end
end
