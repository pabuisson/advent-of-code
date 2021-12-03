# frozen_string_literal: true

# To do this, count the number of times a depth measurement increases
# from the previous measurement. (There is no measurement before the first measurement.)
class Day1
  attr_reader :data

  def initialize(data: load_data)
    @data = data
  end

  def compute_part_1!
    result =
      data.each_with_object({ last_value: data.first, times: 0 }) do |depth, hash|
        hash[:times] += 1 if deeper?(current: depth, previous: hash[:last_value])
        hash[:last_value] = depth
      end

    result[:times]
  end

  def compute_part_2!
    acc = { last_sum: data[0..2].sum, times: 0 }

    data.each_with_index do |_, index|
      three_depths = data[index..index + 2]
      acc[:times] += 1 if deeper?(current: three_depths.sum, previous: acc[:last_sum])
      acc[:last_sum] = three_depths.sum
    end

    acc[:times]
  end

  private

  def deeper?(current:, previous:)
    current > previous
  end

  def load_data
    File.open('./day_1.txt').readlines.map(&:chomp).map(&:to_i)
  end
end
