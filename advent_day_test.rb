# frozen_string_literal: true

require 'minitest/autorun'
require './advent_day.rb'

class AdventDayTest < MiniTest::Test
  class SomeTest1 < AdventDay
  end

  class SomeTest25 < AdventDay
  end

  def test_filename_is_infered_from_class_with_numbers
    assert_equal 'some_test_1.txt', SomeTest1.new(io: StringIO.new('')).send(:filename)
  end

  def test_filename_is_infered_from_class_with_consecutive_numbers
    assert_equal 'some_test_25.txt', SomeTest25.new(io: StringIO.new('')).send(:filename)
  end
end
