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

    def right_order?(left_json_array = @left, right_json_array = @right)
      pp left_json_array
      left_json_array.as_a.each_with_index do |l, i|
        r = right_json_array.as_a[i]

        l_value =
          begin
            l.as_i
          rescue
            l.as_a
          end

        r_value =
          begin
            r.as_i
          rescue
            r.as_a
          end

        begin
          return 0 if l_value > r_value
        rescue
          right_order?(left_json_array: l_value, right_json_array: r_value)
        end
      end

      1
    end
  end
end
