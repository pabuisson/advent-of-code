# frozen_string_literal: true

require './advent_day.rb'

class Day8 < AdventDay
  def compute_part_1!
    data.sum do |(_, output)|
      output.count { |output_digit| [2, 3, 4, 7].include?(output_digit.size) }
    end
  end

  def compute_part_2!
    numbers =
      data.map do |(patterns, output)|
        mapping = Part2::PatternsUntangler.new(patterns: patterns).decrypt
        digits = output.map { |digit| Part2::Pattern.new(value: digit).to_number(mapping: mapping) }
        digits.join('').to_i
      end

    numbers.reduce(:+)
  end

  private

  def format_line(line:)
    line.split('|').map { |side| side.split(' ') }
  end

  module Part2
    class Pattern
      PATTERNS = {
        abcefg: 0,
        cf: 1,
        acdeg: 2,
        acdfg: 3,
        bcdf: 4,
        abdfg: 5,
        abdefg: 6,
        acf: 7,
        abcdefg: 8,
        abcdfg: 9
      }.freeze

      def initialize(value:)
        @value = value
      end

      def to_number(mapping:)
        input_values = mapping.values.join('')
        matching_values = mapping.keys.join('')

        translated_pattern = value.tr(input_values, matching_values)

        PATTERNS[translated_pattern.split('').sort.join('').to_sym]
      end

      private

      attr_reader :value
    end

    class PatternsUntangler
      def initialize(patterns:)
        @patterns = patterns
      end

      def decrypt
        order = %w[b e f a c d g].freeze
        order.each_with_object({}) do |char, mapping|
          mapping[char.to_sym] = char_in_slot(slot: char, slots: mapping)
        end
      end

      private

      attr_reader :patterns

      def char_in_slot(slot:, slots:)
        case slot
        when 'b', 'e', 'f' then char_by_number_of_occurrences(char: slot)
        when 'a' then char_in_a_slot
        when 'c' then char_in_c_slot(slots: slots)
        when 'd' then char_in_d_slot(slots: slots)
        when 'g' then char_in_g_slot(slots: slots)
        end
      end

      EXPECTED_NUMBER_OF_OCCURENCES = { b: 6, e: 4, f: 9 }.freeze
      def char_by_number_of_occurrences(char:)
        expected_count = EXPECTED_NUMBER_OF_OCCURENCES[char.to_sym]
        char_tally.find { |_, char_count| char_count == expected_count }.first
      end

      def char_in_a_slot
        one_digit = patterns.find { |pattern| pattern.size == 2 }
        seven_digit = patterns.find { |pattern| pattern.size == 3 }
        (seven_digit.chars - one_digit.chars).first
      end

      def char_in_c_slot(slots:)
        char_tally.find { |k, count| k != slots[:a] && count == 8 }.first
      end

      def char_in_d_slot(slots:)
        four_digit = patterns.find { |pattern| pattern.size == 4 }
        (four_digit.chars - slots.slice(:b, :c, :f).values).first
      end

      def char_in_g_slot(slots:)
        char_tally.find { |k, count| k != slots[:d] && count == 7 }.first
      end

      def char_tally
        @char_tally ||= patterns.join('').chars.tally
      end
    end
  end
end
