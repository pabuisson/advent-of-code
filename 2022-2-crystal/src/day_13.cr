require "json"

class Aoc2022::Day13
  def self.part_1(input, log = false)
    pairs = format(input)
  end

  def self.format(input)
    pairs = input.split("\n\n", remove_empty: true)
    r = pairs.map_with_index do |pair, index|
      left, right = pair.split("\n", remove_empty: true)
      index + 1 if Pair.new(left_string: left, right_string: right).right_order?
    end.compact

    p r

    r.sum
  end

  struct Pair
    getter left, right

    def initialize(left_string, right_string)
      @left = JSON.parse(left_string).as_a
      @right = JSON.parse(right_string).as_a
    end

    def right_order?(left_json_array : Array(JSON::Any) = @left, right_json_array : Array(JSON::Any) = @right)
      left_json_array.each_with_index do |l, i|
        begin
          r = right_json_array[i]
        rescue
          return false
        end

        if l.as_i? && r.as_i?
          if l.as_i < r.as_i
            next
          elsif l.as_i > r.as_i
            return false
          end
        elsif l.as_i? && !r.as_i?
          return right_order?(left_json_array: JSON.parse("[#{l.as_i}]").as_a, right_json_array: r.as_a)
        elsif !l.as_i? && r.as_i?
          return right_order?(left_json_array: l.as_a, right_json_array: JSON.parse("[#{r.as_i}]").as_a)
        else
          return right_order?(left_json_array: l.as_a, right_json_array: r.as_a)
        end
      end

      true
    end
  end
end
