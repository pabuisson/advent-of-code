# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/focus'
require './day_12'

class Day12NodeTest < MiniTest::Test
  def test_ancestors_returns_all_ancestors_until_root
    root = Day12::Node.new(value: 'end', parent: nil)
    child = Day12::Node.new(value: 'child', parent: root)
    grand_child = Day12::Node.new(value: 'grand child', parent: child)

    expected = [child, root]
    assert_equal expected, grand_child.ancestors
  end
end

class Day12Test < MiniTest::Test
  DATA_1 = <<~TEXT
    start-A
    start-b
    A-c
    A-b
    b-d
    A-end
    b-end
  TEXT

  DATA_2 = <<~TEXT
    dc-end
    HN-start
    start-kj
    dc-start
    dc-HN
    LN-dc
    HN-end
    kj-sa
    kj-HN
    kj-dc
  TEXT

  DATA_3 = <<~TEXT
    fs-end
    he-DX
    fs-he
    start-DX
    pj-DX
    end-zg
    zg-sl
    zg-pj
    pj-he
    RW-he
    fs-DX
    pj-RW
    zg-RW
    start-pj
    he-WI
    zg-he
    pj-fs
    start-RW
  TEXT

  def setup
    @data_1 = StringIO.new(DATA_1)
    @data_2 = StringIO.new(DATA_2)
    @data_3 = StringIO.new(DATA_3)
  end

  def test_neighbors_returns_the_neighbors_starting_from_end
    expected = %w[A b].sort
    assert_equal expected, Day12.new(io: @data_1).neighbors(value: 'end').sort
  end

  def test_neighbors_returns_the_neighbors_but_end_is_not_part_of_them
    expected = %w[c b start].sort
    assert_equal expected, Day12.new(io: @data_1).neighbors(value: 'A').sort
  end

  def test_returns_10_paths_in_first_part_1_example
    assert_equal 10, Day12.new(io: @data_1).compute_part_1!
  end

  def test_returns_19_paths_in_second_part_1_example
    assert_equal 19, Day12.new(io: @data_2).compute_part_1!
  end

  def test_returns_226_paths_in_third_part_1_example
    assert_equal 226, Day12.new(io: @data_3).compute_part_1!
  end

  def test_returns_36_in_first_part_2_example
    assert_equal 36, Day12.new(io: @data_1).compute_part_2!
  end

  def test_returns_103_in_second_part_2_example
    assert_equal 103, Day12.new(io: @data_2).compute_part_2!
  end

  def test_returns_3509_in_third_part_2_example
    assert_equal 3509, Day12.new(io: @data_3).compute_part_2!
  end
end
