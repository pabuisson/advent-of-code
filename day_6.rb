# frozen_string_literal: true

require './advent_day.rb'

class Day6 < AdventDay
  DAYS_ADULT_FISHES = 6
  DAYS_NEW_FISHES = 8

  def compute_part_1!
    compute(number_of_days: 80)
  end

  def compute_part_2!
    compute(number_of_days: 256)
  end

  private

  def initialize_data(data:)
    fishes = data.first.split(',').map(&:to_i)
    (0..9).map do |day|
      fishes.tally[day] || 0
    end
  end

  def compute(number_of_days:)
    fishes_by_day = initialize_data(data: data)

    number_of_days.times do |_|
      fishes_at_day_zero = fishes_by_day.shift
      fishes_by_day[DAYS_NEW_FISHES] ||= 0
      fishes_by_day[DAYS_NEW_FISHES] += fishes_at_day_zero
      fishes_by_day[DAYS_ADULT_FISHES] ||= 0
      fishes_by_day[DAYS_ADULT_FISHES] += fishes_at_day_zero
    end

    fishes_by_day.sum
  end
end
