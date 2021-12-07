# frozen_string_literal: true

require './advent_day.rb'

class Day7 < AdventDay
  def compute_part_1!
    compute(initial_positions: data.first, fuel_consumption_computer: :fuel_consumption_part_1)
  end

  def compute_part_2!
    compute(initial_positions: data.first, fuel_consumption_computer: :fuel_consumption_part_2)
  end

  private

  def format_line(line:)
    line.split(',').map(&:to_i)
  end

  def compute(initial_positions:, fuel_consumption_computer:)
    position_max = initial_positions.max
    delta_by_crab =
      initial_positions.map do |crab|
        (0..position_max).map do |position|
          send(fuel_consumption_computer, from: crab, to: position)
        end
      end

    min_moves_position = position_with_fewer_moves(delta_by_crab: delta_by_crab)
    delta_by_crab.sum { |crab| crab[min_moves_position] }
  end

  # 0 to 1: 1
  # 0 to 2: 2
  # 0 to 3: 3
  def fuel_consumption_part_1(from:, to:)
    (from - to).abs
  end

  # 0 to 1: 1
  # 0 to 2: 1+2
  # 0 to 3: 1+2+3
  def fuel_consumption_part_2(from:, to:)
    distance = (to - from).abs

    @_fuel_bookkeeper ||= {}
    @_fuel_bookkeeper[distance] = (0..distance).sum
  end

  def position_with_fewer_moves(delta_by_crab:)
    nb_of_positions = delta_by_crab.first.size
    (0...nb_of_positions).min do |position_a, position_b|
      sum_position_a = delta_by_crab.sum { |crab| crab[position_a] }
      sum_position_b = delta_by_crab.sum { |crab| crab[position_b] }

      sum_position_a <=> sum_position_b
    end
  end
end
