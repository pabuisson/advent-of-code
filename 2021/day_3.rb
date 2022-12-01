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
    oxygen_rating = compute_rating(data: data, computer: :oxygen_indice_value)
    co2_rating = compute_rating(data: data, computer: :co2_indice_value)

    oxygen_rating.join('').to_i(2) * co2_rating.join('').to_i(2)
  end

  private

  def gamma(aggregate)
    aggregate.map { |char| char['1'] > char['0'] ? '1' : '0' }.join('')
  end

  def epsilon(aggregate)
    aggregate.map { |char| char['1'] > char['0'] ? '0' : '1' }.join('')
  end

  def compute_rating(data:, computer:)
    rating = []
    lines = data.dup

    (0...lines.first.size).map do |i|
      lines = lines.select { |line| line.start_with?(rating.join('')) }
      tally = lines.map { |line| line[i] }.tally
      rating << send(computer, tally)
    end

    rating
  end

  def oxygen_indice_value(tally)
    if tally.keys.one?
      tally.keys.first
    else
      tally['0'] > tally['1'] ? '0' : '1'
    end
  end

  def co2_indice_value(tally)
    if tally.keys.one?
      tally.keys.first
    else
      tally['0'] <= tally['1'] ? '0' : '1'
    end
  end
end
