require "./spec_helper"
require "../src/day_11.cr"

describe Aoc2022::Day11 do
  describe "part 1" do
    it "test data" do
      test_data = File.read("./data/day_11_test.txt")
      result = Aoc2022::Day11.part_1(input: test_data, log: false)
      result.should eq 10_605
    end

    it "real data" do
      real_data = File.read("./data/day_11.txt")
      result = Aoc2022::Day11.part_1(input: real_data, log: false)
      result.should be_truthy
      result.should eq 182_293
    end
  end

  describe "part 2" do
    it "test data" do
      test_data = File.read("./data/day_11_test.txt")
      result = Aoc2022::Day11.part_2(input: test_data)
      result.should eq 2_713_310_158
    end

    it "real data" do
      real_data = File.read("./data/day_11.txt")
      result = Aoc2022::Day11.part_2(input: real_data)
      result.should be_truthy
      result.should eq 54_832_778_815
    end
  end

  describe Aoc2022::Day11::Monkey do
    describe "#apply_operation" do
      it "for multiply operation" do
        monkey_raw = <<-TEXT
        Monkey 0:
          Starting items: 79, 98
          Operation: new = old * 19
          Test: divisible by 23
            If true: throw to monkey 2
            If false: throw to monkey 3
        TEXT

        monkey = Aoc2022::Day11::Monkey.parse(input: monkey_raw)
        result = monkey.apply_operation(initial_worry_level: 10)
        result.should eq 10 * 19
      end

      it "for add operation" do
        monkey_raw = <<-TEXT
        Monkey 0:
          Starting items: 79, 98
          Operation: new = old + 19
          Test: divisible by 23
            If true: throw to monkey 2
            If false: throw to monkey 3
        TEXT

        monkey = Aoc2022::Day11::Monkey.parse(input: monkey_raw)
        result = monkey.apply_operation(initial_worry_level: 10)
        result.should eq 10 + 19
      end
    end

    describe "#monkey_to_throw_to" do
      it "returns the monkey id depending on test result" do
        monkey_raw = <<-TEXT
        Monkey 0:
          Starting items: 79, 98
          Operation: new = old * 19
          Test: divisible by 23
            If true: throw to monkey 2
            If false: throw to monkey 3
        TEXT

        monkey = Aoc2022::Day11::Monkey.parse(input: monkey_raw)
        monkey.monkey_to_throw_to(worry_level: 46).should eq 2
        monkey.monkey_to_throw_to(worry_level: 48).should eq 3
      end
    end
  end
end
