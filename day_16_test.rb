# frozen_string_literal: true

require './test_helper'
require './day_16'

class Day16PacketTest < MiniTest::Test
  def test_translates_hexa_values_to_binary_correctly
    assert_equal '110100101111111000101000', Day16::Packet.new(hexa: 'D2FE28').binary
  end

  def test_translates_binary_values_to_hexa_correctly
    assert_equal 'D2FE28', Day16::Packet.new(binary: '110100101111111000101000').hexa
  end

  def test_parses_a_literal_packet_correctly
    literal = Day16::Packet.new(hexa: 'D2FE28')
    assert_equal '110100101111111000101000', literal.binary
    assert_equal 6, literal.version
    assert_equal 4, literal.type_id
    assert_equal 2021, literal.value
  end

  def test_parses_an_operator_packet_with_length_type_id_0_correctly
    operator = Day16::Packet.new(hexa: '38006F45291200')
    assert_equal '00111000000000000110111101000101001010010001001000000000', operator.binary
    assert_equal 1, operator.version
    assert_equal 6, operator.type_id
    assert_equal 0, operator.length_type_id
    assert_equal 2, operator.subpackets.size
    assert_equal 3, operator.self_and_subpackets.size
  end

  def test_parses_an_operator_packet_with_length_type_id_1_correctly
    operator = Day16::Packet.new(hexa: 'EE00D40C823060')
    assert_equal '11101110000000001101010000001100100000100011000001100000', operator.binary
    assert_equal 7, operator.version
    assert_equal 3, operator.type_id
    assert_equal 1, operator.length_type_id
    assert_equal 3, operator.subpackets.size
    assert_equal 4, operator.self_and_subpackets.size
  end

  def test_self_and_subpacket_returns_the_expected_number_of_packets
    assert_equal 4, Day16::Packet.new(hexa: '8A004A801A8002F478').self_and_subpackets.size
    assert_equal 7, Day16::Packet.new(hexa: '620080001611562C8802118E34').self_and_subpackets.size
    assert_equal 7, Day16::Packet.new(hexa: 'C0015000016115A2E0802F182340').self_and_subpackets.size
    assert_equal 8, Day16::Packet.new(hexa: 'A0016C880162017C3686B18A3D4780').self_and_subpackets.size
  end
end

class Day16Part2OperatorTest < MiniTest::Test
end

class Day16Test < MiniTest::Test
  def test_returns_expected_version_sums_for_4_examples_of_part_1
    assert_equal 16, Day16.new(io: StringIO.new('8A004A801A8002F478')).compute_part_1!
    assert_equal 12, Day16.new(io: StringIO.new('620080001611562C8802118E34')).compute_part_1!
    assert_equal 23, Day16.new(io: StringIO.new('C0015000016115A2E0802F182340')).compute_part_1!
    assert_equal 31, Day16.new(io: StringIO.new('A0016C880162017C3686B18A3D4780')).compute_part_1!
  end

  def test_sum_operator_packet_returns_sum_value
    assert_equal 3, Day16.new(io: StringIO.new('C200B40A82')).compute_part_2!
  end

  def test_product_operator_packet_returns_product_value
    assert_equal 54, Day16.new(io: StringIO.new('04005AC33890')).compute_part_2!
  end

  def test_min_operator_packet_returns_min_value
    assert_equal 7, Day16.new(io: StringIO.new('880086C3E88112')).compute_part_2!
  end

  def test_max_operator_packet_returns_max_value
    assert_equal 9, Day16.new(io: StringIO.new('CE00C43D881120')).compute_part_2!
  end

  def test_less_than_operator_packet_returns_comparison_as_0_or_1
    assert_equal 1, Day16.new(io: StringIO.new('D8005AC2A8F0')).compute_part_2!
  end

  def test_greater_than_operator_packet_returns_comparison_as_0_or_1
    assert_equal 0, Day16.new(io: StringIO.new('F600BC2D8F')).compute_part_2!
  end

  def test_equal_operator_packet_returns_equality_as_0_or_1
    assert_equal 0, Day16.new(io: StringIO.new('9C005AC2F8F0')).compute_part_2!
  end

  def test_combined_operator_packets_still_works
    assert_equal 1, Day16.new(io: StringIO.new('9C0141080250320F1802104A08')).compute_part_2!
  end
end
