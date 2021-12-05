# frozen_string_literal: true

require './advent_day'

class Day3 < AdventDay
  # Power consumption
  def compute_part_1!
    aggregate = []
    data.first.size.times { |_| aggregate << { '0' => 0, '1' => 0 } }

    data.each do |line|
      line.each_char.with_index do |char, index|
        aggregate[index][char] += 1
      end
    end

    gamma(aggregate).to_i(2) * epsilon(aggregate).to_i(2)
  end

  # Life support rating
  def compute_part_2!
  end

  private

  def gamma(aggregate)
    aggregate.map { |char| char['1'] > char['0'] ? '1' : '0' }.join('')
  end

  def epsilon(aggregate)
    aggregate.map { |char| char['1'] > char['0'] ? '0' : '1' }.join('')
  end
end
