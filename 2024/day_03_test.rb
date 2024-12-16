# frozen_string_literal: true

require './test_helper'
require './day_03'

describe Day03 do
  it 'returns 161 for part 1' do
    data = StringIO.new("xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))")
    assert_equal 161, Day03.new(io: data).part_1!
  end

  it 'returns 48 for part 2' do
    data = StringIO.new("xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")
    assert_equal 48, Day03.new(io: data).part_2!
  end
end
