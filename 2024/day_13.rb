# frozen_string_literal: true

require './advent_day'
require 'debug'

class Day13 < AdventDay
  def part_1!
    parse(@data, part: 1)
      .map(&:cheapeast_solution)
      .sum do |solution|
        case solution
        in [:ko, *] then 0
        in [:ok, {cost: cost}] then cost
        end
      end
  end


  # FIXME: this won't do. This thing is actually a system of 2 equations with 2 unknown
  #        it must be possible to implement something to mathematically solve this, instead
  #        of the current step 1 naive solution of looping through the couple of a, b hits
  def part_2!
    parse(@data, part: 2)
      .map(&:cheapeast_solution)
      .sum do |solution|
        case solution
        in [:ko, *] then 0
        in [:ok, {cost: cost}] then cost
        end
      end
  end

  class ClawMachine
    def initialize(text, part:)
      @a_button = Button.from_string(text[0])
      @b_button = Button.from_string(text[1])
      @prize = case part
               when 1 then Prize1.from_string(text[2])
               when 2 then Prize2.from_string(text[2])
               end
    end

    # A costs 3
    # B costs 1
    # so if we reach a point where we need 3x more B than A, it won't be the most cost-efficient anymore
    def cheapeast_solution
      return [:ko, :no_solution] if prize.x.odd? && a_button.x.even? && b_button.x.even?
      return [:ko, :no_solution] if prize.y.odd? && a_button.y.even? && b_button.y.even?

      all_solutions =
        (0..100).flat_map do |a|
          next [] if a_button.x * a > prize.x
          next [] if a_button.y * a > prize.y

          (0..100).filter_map do |b|
            current_x = a_button.x * a + b_button.x * b
            current_y = a_button.y * a + b_button.y * b

            if current_x == prize.x && current_y == prize.y
              cost = a_button.cost * a + b_button.cost * b
              {a:, b:, cost:}
            end
          end
        end

      all_solutions.empty? ? [:ko, :no_solution] : [:ok, all_solutions.min_by { |solution| solution[:cost] }]
    end

    private

    attr_reader :a_button, :b_button, :prize
  end

  Button = Data.define(:name, :x, :y, :cost) do
    def self.from_string(s)
      md = /^Button (?<name>\w): X\+(?<x>\d+), Y\+(?<y>\d+)$/.match(s)
      self.new(
        name: md[:name],
        x: md[:x].to_i,
        y: md[:y].to_i,
        cost: md[:name] == 'A' ? 3 : 1)
    end
  end

  Prize1 = Data.define(:x, :y) do
    def self.from_string(s)
      md = /^Prize: X=(?<x>\d+), Y=(?<y>\d+)$/.match(s)
      self.new(
        x: md[:x].to_i,
        y: md[:y].to_i
      )
    end
  end

  Prize2 = Data.define(:x, :y) do
    def self.from_string(s)
      md = /^Prize: X=(?<x>\d+), Y=(?<y>\d+)$/.match(s)
      self.new(
        x: md[:x].to_i + 10_000_000_000_000,
        y: md[:y].to_i + 10_000_000_000_000
      )
    end
  end

  def parse(data, part:)
    buffer = []
    machines =
      data.filter_map do |line|
        if line.empty?
          cm = ClawMachine.new(buffer, part:)
          buffer = []
          cm
        else
          buffer << line
          next
        end
      end

    machines << ClawMachine.new(buffer, part:)
    machines
  end
end
