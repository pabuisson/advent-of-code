# frozen_string_literal: true

require './test_helper'
require './advent_day'

describe AdventDay do
  class SomeTest1 < AdventDay
  end

  class SomeTest25 < AdventDay
  end

  it 'test_data_filename_is_infered_from_class_with_numbers' do
    assert_equal 'data/some_test_1.txt', SomeTest1.new(io: StringIO.new('')).send(:data_filename)
  end

  it 'test_data_filename_is_infered_from_class_with_consecutive_numbers' do
    assert_equal 'data/some_test_25.txt', SomeTest25.new(io: StringIO.new('')).send(:data_filename)
  end
end
