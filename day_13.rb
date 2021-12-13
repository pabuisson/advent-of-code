# frozen_string_literal: true

require './advent_day.rb'

class Day13 < AdventDay
  HORIZONTAL = :horizontal
  VERTICAL = :vertical

  def compute_part_1!
    points = initialize_points(data: data)
    instructions = initialize_fold_instructions(data: data)
    first_fold = instructions.first

    points.each do |point|
      point.move_at_fold!(fold: first_fold) if point.will_move_at_fold?(fold: first_fold)
    end

    points.uniq.count
  end

  def compute_part_2!
  end

  private

  def initialize_points(data:)
    data
      .select { |line| line.include?(',') }
      .map { |line| Point.new(**%i[x y].zip(line.split(',').map(&:to_i)).to_h) }
  end

  def initialize_fold_instructions(data:)
    fold_instructions =
      data.map do |line|
        next unless line.include?('fold along')

        direction = line.include?('y=') ? HORIZONTAL : VERTICAL
        fold_at = line.split('=').last.to_i
        FoldInstruction.new(direction: direction, fold_at: fold_at)
      end

    fold_instructions.compact
  end

  FoldInstruction = Struct.new(:direction, :fold_at, keyword_init: true)
  Point = Struct.new(:x, :y, keyword_init: true) do
    def will_move_at_fold?(fold:)
      if fold.direction == HORIZONTAL
        y > fold.fold_at
      else
        x > fold.fold_at
      end
    end

    def move_at_fold!(fold:)
      if fold.direction == HORIZONTAL
        self.y = fold.fold_at - (y - fold.fold_at)
      else
        self.x = fold.fold_at - (x - fold.fold_at)
      end
    end
  end
end
