# frozen_string_literal: true

require './advent_day.rb'

class Day4 < AdventDay
  def compute_part_1!
    draw = initialize_draw(data: data)
    boards = initialize_boards(data: data)
    winning_score = 0

    draw.each do |number_called|
      boards.each { |b| b.mark!(number_called) }
      winning_board = boards.find(&:winner?)

      if winning_board
        winning_score = winning_board.score(number_called)
        break
      end
    end

    winning_score
  end

  def compute_part_2!
  end

  private

  def initialize_draw(data:)
    data.first.split(',').map(&:to_i)
  end

  def initialize_boards(data:)
    boards = []
    data.each.with_index do |line, index|
      next if index.zero?

      if line.empty?
        boards.push(Board.new)
      else
        boards.last.add_line(line)
      end
    end

    boards
  end

  BoardNumber = Struct.new(:value, :marked, keyword_init: true) do
    def mark!
      self.marked = true
    end

    def marked?
      marked
    end
  end

  class Board
    def initialize
      @lines = []
    end

    def add_line(raw_line)
      @lines << raw_line.split(' ').map(&:to_i).map { |value| BoardNumber.new(value: value, marked: false) }
    end

    def mark!(number_to_mark)
      @lines.each do |line|
        line.each do |number|
          if number.value == number_to_mark
            number.mark!
            break
          end
        end
      end
    end

    def winner?
      winner_row? || winner_column?
    end

    def score(last_number_called)
      unmarked_sum = @lines.sum { |line| line.reject(&:marked?).sum(&:value) }
      unmarked_sum * last_number_called
    end

    private

    attr_reader :lines

    def winner_row?
      lines.any? do |line|
        line.all?(&:marked?)
      end
    end

    def winner_column?
      (0...lines.first.size).any? do |col_index|
        lines.map { |line| line[col_index] }.all?(&:marked?)
      end
    end

  end

  class BoardNumber

  end
end
