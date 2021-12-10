# frozen_string_literal: true

require './advent_day.rb'
require 'set'

class Day10 < AdventDay

  def compute_part_1!
    corrupted_lines = data.select(&:corrupted?)
    corrupted_lines.map(&:corrupted_score).sum
  end

  def part_2_scores
    data.reject(&:corrupted?).map(&:completion_score)
  end

  def compute_part_2!
    part_2_scores.sort[part_2_scores.size / 2]
  end

  private

  def format_line(line:)
    Line.new(line: line)
  end

  class Char
    OPENING_CHARS = ['[', '(', '{', '<'].freeze
    CLOSING_CHARS = [']', ')', '}', '>'].freeze
    CORRUPTION_SCORE = { ')' => 3, ']' => 57, '}' => 1_197, '>' => 25_137 }.freeze
    COMPLETION_SCORE ={ ')' => 1, ']' => 2, '}' => 3, '>' => 4 }.freeze

    attr_reader :char

    def initialize(char:)
      @char = char
    end

    def corrupted_score
      CORRUPTION_SCORE[char]
    end

    def completion_score
      COMPLETION_SCORE[char]
    end

    def opening?
      OPENING_CHARS.include?(char)
    end

    def valid_closing_for?(opening_char:)
      CLOSING_CHARS.index(char) == OPENING_CHARS.index(opening_char.char)
    end

    def closing_char
      Char.new(char: CLOSING_CHARS[OPENING_CHARS.index(char)])
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
      @missing_closing_chars  = []
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

    def completion_score
      missing_chars.reduce(0) do |score, char|
        5 * score + char.completion_score
      end
    end

    def to_s
      line.map(&:to_s).join('')
    end

    private

    attr_reader :line
    attr_writer :first_corrupted_char, :missing_closing_chars

    def missing_chars
      opening_chars_stack = []
      line.each do |char|
        if char.opening?
          opening_chars_stack << char
        elsif char.valid_closing_for?(opening_char: opening_chars_stack.last)
          opening_chars_stack.pop
        end
      end

      opening_chars_stack.reverse.map(&:closing_char)
    end

  end
end
