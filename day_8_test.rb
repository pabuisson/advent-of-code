# frozen_string_literal: true

require './test_helper'
require './day_8'

class Day8Test < MiniTest::Test
  DATA = <<~TEXT
    be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
    edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
    fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
    fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
    aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
    fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
    dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
    bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
    egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
    gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_26_digits_with_uniq_number_of_segments
    assert_equal 26, Day8.new(io: @data).compute_part_1!
  end

  def test_returns_61229_for_output_value_of_each_entry
    assert_equal 61_229, Day8.new(io: @data).compute_part_2!
  end
end

class Day8PatternsUntanglerTest < MiniTest::Test
  DATA = 'acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf'

  def test_expected_mapping_is_found_from_the_input
    patterns = DATA.split('|').first.split(' ')
    decryptor = Day8::Part2::PatternsUntangler.new(patterns: patterns)

    expected_mapping = { a: 'd', b: 'e', c: 'a', d: 'f', e: 'g', f: 'b', g: 'c' }
    assert_equal expected_mapping, decryptor.decrypt
  end
end
