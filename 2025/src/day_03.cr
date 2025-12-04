require "./base"

class Day03 < Base
  def self.part_1(input, must_log = false)
    input
      .map do |line|
        line_as_ints = line.chars.map(&.to_i16)

        tens = line_as_ints[..-2].max
        first_occurrence_at = line_as_ints.index(tens).not_nil!
        units = line_as_ints[first_occurrence_at + 1..].max

        {tens, units}
      end
      .tap { |result| pp result if must_log }
      .sum { |tuple| tuple[0] * 10 + tuple[1]}
  end

  def self.part_2(input, must_log = false)
    input
      .map do |line|
        line_as_ints = line.chars.map(&.to_i16)
        result =
          (12..1).step(by: -1).to_a
            .reduce({result: [] of Int32, start_at: 0}) do |acc, i|
              non_processed_part = line_as_ints[acc[:start_at]..-i]
              value = non_processed_part.max
              first_occurrence_at = acc[:start_at] + non_processed_part.index(value).not_nil!

              {result: acc[:result] << value, start_at: first_occurrence_at + 1}
            end

        result[:result]
      end
      .tap { |result| pp result if must_log }
      .sum { |result| result.join().to_i64 }
  end
end
