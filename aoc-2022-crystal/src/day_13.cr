require "json"

class Aoc2022::Day13
  def self.part_1(input, log = false)
    pairs = format(input)
  end

  def self.format(input)
    pairs = input.split("\n\n", remove_empty: true)
    pairs.map do |p|
      left, right = p.split("\n", remove_empty: true)
      Pair.new(left_string: left, right_string: right)
    end
  end

  struct Pair
    getter left, right

    def initialize(left_string, right_string)
      @left = JSON.parse(left_string)
      @right = JSON.parse(right_string)
    end

    def right_order?(
      left_json_array : JSON::Any = @left,
      right_json_array : JSON::Any = @right
    )
      left_json_array.as_a.each_with_index do |l, i|
        r = right_json_array.as_a[i]

        if l.as_i? && r.as_i?
          return 0 if l.as_i > r.as_i
        elsif l.as_i? && !r.as_i?
          right_order?(left_json_array: JSON.parse("[#{l.as_i}]"), right_json_array: r.as_a)
        elsif !l.as_i? && r.as_i?
          right_order?(left_json_array: l.as_a, right_json_array: JSON.parse("[#{r.as_i}]"))
        else
          right_order?(left_json_array: l.as_a, right_json_array: r.as_a)
        end
      end

      1
    end
  end
end
