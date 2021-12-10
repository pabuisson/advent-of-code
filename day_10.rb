# frozen_string_literal: true

require './advent_day.rb'
require 'set'

class Day10 < AdventDay

  def compute_part_1!
    corrupted_lines = data.filter(&:corrupted?)
    corrupted_lines.each { |l| puts l }
    corrupted_lines.map(&:corrupted_score).sum
  end

  def compute_part_2!
  end

  private

  def format_line(line:)
    Part1::Line.new(line: line)
  end

  module Part1
    class Char
      OPENING_CHARS = ['[', '(', '{', '<'].freeze
      CLOSING_CHARS = [']', ')', '}', '>'].freeze
      CORRUPTION_SCORE = { ')' => 3, ']' => 57, '}' => 1_197, '>' => 25_137 }.freeze

      attr_reader :char

      def initialize(char:)
        @char = char
      end

      def corrupted_score
        CORRUPTION_SCORE[char]
      end

      def opening?
        OPENING_CHARS.include?(char)
      end

      def valid_closing_for?(opening_char:)
        CLOSING_CHARS.index(char) == OPENING_CHARS.index(opening_char.char)
      end

      def to_s
        char.to_s
      end
    end

    class Line
      attr_reader :first_corrupted_char

      def initialize(line:)
        @line = line.chars.map { |char| Char.new(char: char) }
        @first_corrupted_char = nil
      end

      def corrupted?
        opening_chars_stack = []
        line.each do |char|
          if char.opening?
            opening_chars_stack << char
          else
            if char.valid_closing_for?(opening_char: opening_chars_stack.last)
              opening_chars_stack.pop
            else
              self.first_corrupted_char = char
              return true
            end
          end
        end

        false
      end

      def corrupted_score
        first_corrupted_char.corrupted_score
      end

      def to_s
        line.map(&:to_s).join('')
      end

      private

      attr_reader :line
      attr_writer :first_corrupted_char
    end
  end
end
