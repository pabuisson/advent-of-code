# frozen_string_literal: true

require 'minitest/autorun'
require './advent_day.rb'

class AdventDayTest < MiniTest::Test
  class SomeTest1 < AdventDay
  end

  class SomeTest25 < AdventDay
  end

  def test_data_filename_is_infered_from_class_with_numbers
    assert_equal 'data/some_test_1.txt', SomeTest1.new(io: StringIO.new('')).send(:data_filename)
  end

  def test_data_filename_is_infered_from_class_with_consecutive_numbers
    assert_equal 'data/some_test_25.txt', SomeTest25.new(io: StringIO.new('')).send(:data_filename)
  end
end
