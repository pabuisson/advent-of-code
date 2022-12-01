# frozen_string_literal: true

require './advent_day.rb'

class Day11 < AdventDay
  def compute_part_1!
    octomap = Octomap.new(data: data)

    (1..100).sum do |step|
      flashed_at_step = 0
      octomap.reset_flash_status!
      octomap.increment_all_energy!

      loop do
        flashed = octomap.flash_loaded_octopuses!
        flashed_at_step += flashed
        break if flashed.zero?
      end

      flashed_at_step
    end
  end

  def compute_part_2!
    octomap = Octomap.new(data: data)

    # 10_000: arbitrary max to avoid an infinite loop
    (1..10_000).each do |step|
      flashed_at_step = 0
      octomap.reset_flash_status!
      octomap.increment_all_energy!

      loop do
        flashed = octomap.flash_loaded_octopuses!
        flashed_at_step += flashed
        break if flashed.zero?
      end

      return step if octomap.all_flashed?
    end
  end

  private

  def format_line(line:)
    line.chars.map(&:to_i)
  end

  class Octomap
    def initialize(data:)
      @octomap =
        data.map.with_index do |row, row_index|
          row.map.with_index do |_, col_index|
            Octo.new(row: row_index, col: col_index, energy: data[row_index][col_index])
          end
        end
    end

    def at(row:, col:)
      return if row.negative? || row >= @octomap.size
      return if col.negative? || col >= @octomap.first.size

      octomap[row][col]
    end

    def reset_flash_status!
      octomap.each do |row|
        row.each(&:reset_flash!)
      end
    end

    def increment_all_energy!
      octomap.each do |row|
        row.each(&:increase_energy!)
      end
    end

    def flash_loaded_octopuses!
      flashed_count = 0
      octomap.each do |row|
        row.select(&:loaded?).reject(&:flashed?).each do |octopus|
          flashed_count += 1
          octopus.flash!
          octopus.neighbors(map: self).reject(&:flashed?).each(&:increase_energy!)
        end
      end

      flashed_count
    end

    def all_flashed?
      octomap.all? do |row|
        row.all?(&:flashed?)
      end
    end

    def print
      octomap.each do |row|
        puts row.map {|o| o.flashed? ? "!#{o.energy}" : o.energy }
                .map { |n| n.to_s.rjust(3) }.join('')
      end
    end

    private

    attr_reader :octomap
  end

  class Octo
    attr_reader :energy, :row, :col

    def initialize(row:, col:, energy:)
      @row = row
      @col = col
      @energy = energy
    end

    def loaded?
      energy > 9
    end

    def increase_energy!
      # debugger if row == 0 && col == 2
      self.energy += 1
    end

    def flash!
      self.energy = 0
      self.has_flashed = true
    end

    def flashed?
      has_flashed
    end

    def reset_flash!
      self.has_flashed = false
    end

    def neighbors(map:)
      [
        map.at(row: row - 1, col: col - 1),
        map.at(row: row - 1, col: col),
        map.at(row: row - 1, col: col + 1),
        map.at(row: row, col: col - 1),
        map.at(row: row, col: col + 1),
        map.at(row: row + 1, col: col - 1),
        map.at(row: row + 1, col: col),
        map.at(row: row + 1, col: col + 1)
      ].compact
    end

    private

    # attr_reader :row, :col
    attr_writer :energy
    attr_accessor :has_flashed
  end
end
