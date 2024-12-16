# frozen_string_literal: true

require './advent_day'
require 'debug'

class Day07 < AdventDay
  def part_1!
    @data
      .map { |line| Equation.new(line) }
      .map { |e|
        case e.complete(with_ops: [:add, :multiply])
        in [:none, nil] then nil
        in [:one, calcul] then calcul
        in [:many, calculs] then calculs.first
        end
      }.compact.sum(&:result)
  end

  def part_2!
    @data
      .map { |line| Equation.new(line) }
      .map { |e|
        case e.complete(with_ops: [:add, :multiply, :concatenate])
        in [:none, nil] then nil
        in [:one, calcul] then calcul
        in [:many, calculs] then calculs.first
        end
      }.compact.sum(&:result)
  end

  class Equation
    def initialize(line)
      expected_result, rest = line.split(':')

      @expected_result = expected_result.to_i
      @numbers = rest.split(' ').map(&:to_i)
    end

    def complete(with_ops: [])
      numbers = @numbers.dup
      first_number = numbers.shift
      combinations = [
        Calcul.new([first_number], first_number)
      ]

      loop do
        next_number = numbers.shift

        combinations =
          combinations.reduce([]) do |new_combinations, combination|
            if with_ops.include?(:add)
              addition = Calcul.from(combination).add(next_number)
              new_combinations << addition if addition.result <= @expected_result
            end

            if with_ops.include?(:multiply)
              multiplication = Calcul.from(combination).multiply_by(next_number)
              new_combinations << multiplication if multiplication.result <= @expected_result
            end

            if with_ops.include?(:concatenate)
              concat = Calcul.from(combination).concatenate(next_number)
              new_combinations << concat if concat.result <= @expected_result
            end

            new_combinations
          end

        if numbers.empty?
          correct_combinations = combinations.select { _1.result == @expected_result }

          case correct_combinations.size
          when 0
            return [:none, nil]
          when 1
            return [:one, correct_combinations.first]
          else
            return [:many, correct_combinations]
          end
        end
      end
    end
  end

  # Holds an actual calculation chain, with the numbers and operators,
  # and computes the operation result after each operation (so that the
  # caller can exclude an operation as soon as it appends a new step)
  class Calcul
    attr_reader :tokens, :result

    class << self
      def from(calcul) = new(calcul.tokens, calcul.result)
    end

    def initialize(tokens, result)
      @tokens = tokens.dup
      @result = result
    end

    def add(number)
      @tokens = tokens + ["+", number]
      @result += number
      self
    end

    def multiply_by(number)
      @tokens = tokens + ["*", number]
      @result *= number
      self
    end

    def concatenate(number)
      @tokens = tokens + ["||", number]
      @result = "#{result}#{number}".to_i
      self
    end

    def to_s
      "#{tokens.join(' ')} = #{result}"
    end
  end
end
