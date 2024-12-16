# frozen_string_literal: true

require './advent_day'
require 'debug'

class Day04 < AdventDay
  def part_1!
    Grid.new(@data).count_xmas()
  end

  def part_2!
    Grid.new(@data).count_mas()
  end

  class Grid
    def initialize(data)
      @data = data.map(&:chars)
    end

    def count_xmas
      data.flat_map.with_index do |line, line_index|
        line.map.with_index do |char, col_index|
          xmas_count?(line_index, col_index)
        end
      end.sum
    end

    def count_mas
      data.flat_map.with_index do |line, line_index|
        line.map.with_index do |char, col_index|
          mas?(line_index, col_index)
        end
      end.count { _1 == true }
    end

    private 

    attr_reader :data

    def xmas_count?(line_index, col_index)
      xmas_right?(line_index, col_index) +
        xmas_left?(line_index, col_index) +
        xmas_up?(line_index, col_index) +
        xmas_down?(line_index, col_index) +
        xmas_up_left?(line_index, col_index)  +
        xmas_up_right?(line_index, col_index) +
        xmas_bottom_left?(line_index, col_index) +
        xmas_bottom_right?(line_index, col_index)
    end

    def xmas_right?(from_line, from_col) 
      return 0 if from_col+3 >= data[from_line].size 

      data[from_line][from_col] == 'X' &&
        data[from_line][from_col+1] == 'M' &&
        data[from_line][from_col+2] == 'A' &&
        data[from_line][from_col+3] == 'S' ? 1 : 0
    rescue
      0
    end

    def xmas_left?(from_line, from_col) 
      return 0 if from_col-3 < 0

      data[from_line][from_col] == 'X' &&
        data[from_line][from_col-1] == 'M' &&
        data[from_line][from_col-2] == 'A' &&
        data[from_line][from_col-3] == 'S' ? 1 : 0
    rescue
      0
    end

    def xmas_up?(from_line, from_col)
      return 0 if from_line-3 < 0

      data[from_line][from_col] == 'X' &&
        data[from_line-1][from_col] == 'M' &&
        data[from_line-2][from_col] == 'A' &&
        data[from_line-3][from_col] == 'S' ? 1 : 0
    rescue
      0
    end

    def xmas_down?(from_line, from_col)
      return 0 if from_line+3 >= data.size 

      data[from_line][from_col] == 'X' &&
        data[from_line+1][from_col] == 'M' &&
        data[from_line+2][from_col] == 'A' &&
        data[from_line+3][from_col] == 'S' ? 1 : 0
    rescue
      0
    end

    def xmas_up_right?(from_line, from_col) 
      return 0 if from_line-3 < 0
      return 0 if from_col+3 >= data[from_line].size

      data[from_line][from_col] == 'X' &&
        data[from_line-1][from_col+1] == 'M' &&
        data[from_line-2][from_col+2] == 'A' &&
        data[from_line-3][from_col+3] == 'S' ? 1 : 0
    rescue
      0
    end

    def xmas_up_left?(from_line, from_col) 
      return 0 if from_line-3 < 0
      return 0 if from_col-3 < 0

      data[from_line][from_col] == 'X' &&
        data[from_line-1][from_col-1] == 'M' &&
        data[from_line-2][from_col-2] == 'A' &&
        data[from_line-3][from_col-3] == 'S' ? 1 : 0
    rescue
      0
    end

    def xmas_bottom_right?(from_line, from_col)
      return 0 if from_line+3 >= data.size
      return 0 if from_col+3 >= data[from_line].size

      data[from_line][from_col] == 'X' &&
        data[from_line+1][from_col+1] == 'M' &&
        data[from_line+2][from_col+2] == 'A' &&
        data[from_line+3][from_col+3] == 'S' ? 1 : 0
    rescue
      0
    end

    def xmas_bottom_left?(from_line, from_col)
      return 0 if from_line+3 >= data[from_line].size
      return 0 if from_col-3 < 0

      data[from_line][from_col] == 'X' &&
        data[from_line+1][from_col-1] == 'M' &&
        data[from_line+2][from_col-2] == 'A' &&
        data[from_line+3][from_col-3] == 'S' ? 1 : 0
    rescue
      0
    end

    def mas?(line_index, col_index)
      return false if line_index-1 < 0 || col_index-1 < 0
      return false if line_index+1 >= data.size || col_index+1 >= data[line_index].size

      data[line_index][col_index] == 'A' && (
        data[line_index-1][col_index-1] == 'M' && data[line_index+1][col_index+1] == 'S' ||
        data[line_index-1][col_index-1] == 'S' && data[line_index+1][col_index+1] == 'M' 
      ) && (
        data[line_index-1][col_index+1] == 'M' && data[line_index+1][col_index-1] == 'S' ||
        data[line_index-1][col_index+1] == 'S' && data[line_index+1][col_index-1] == 'M' 
      ) 
    end
  end
end
