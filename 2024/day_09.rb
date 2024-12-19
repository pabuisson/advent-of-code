# frozen_string_literal: true

require './advent_day'
require 'debug'

# - The digits alternate between indicating the length of a file and the length of free space.
# - Each file on disk also has an ID number based on the order of the files as
#   they appear before they are rearranged, starting with ID 0.
class Day09 < AdventDay
  attr_reader :repacked_blocks

  Blocks = Data.define(:id, :size) do
    def space? = id.nil?
    def file? = !space?

    def to_s = (id ? id : '.') * size
    def to_a = Array.new(size, Blocks[id, 1])
  end

  # 20241218 01:27 : 79_375_201_249 is too low
  # 20241219 21:46 : 5_767_562_236_581 too low
  # 20241219 22:05 : 6_366_665_108_136 OK
  def part_1!
    all_blocks = parse(@data)

    # Move the files around
    repacked_blocks = []
    while all_blocks.any?
      first_block = all_blocks.shift
      last_block = nil

      if first_block.file?
        repacked_blocks << first_block
      elsif first_block.space?
        available_space = first_block.size

        # We REMOVE the last block from all_blocks
        # If we consume it only partly, we'll have to append a new Blocks at the end with the remainder
        while all_blocks.any? && available_space > 0
          last_block = all_blocks.pop
          last_block = all_blocks.pop while last_block.space?

          if available_space >= last_block.size
            repacked_blocks << last_block
            available_space -= last_block.size
          else
            repacked_blocks << Blocks[last_block.id, available_space]
            all_blocks << Blocks[last_block.id, last_block.size - available_space]
            available_space = 0
          end
        end
      end
    end

    # NOTE: repacking this way is wrong, but is what the test input expects
    #       why wrong? because it would show ID:99, size: 2 as 9999, which is not correct, it's 99 twice, not 9 four times
    #       I should keep an array of size 1 blocks, each one maintaining its ID
    { repacked: repacked_blocks.join(''), result: result(repacked_blocks) }
  end

  # 20241219 23:07 : 6_398_065_450_842 OK
  def part_2!
    all_blocks = parse(@data)

    # Move the files around
    (0...all_blocks.size).to_a.reverse.each do |i|
      file_to_move = all_blocks[i]
      next if file_to_move.space?

      matching_space_index = all_blocks[0..i].find_index { |b| b.space? && b.size >= file_to_move.size }
      next if matching_space_index.nil?

      matching_space = all_blocks[matching_space_index]

      # 1. replace item with a same size block of nil id
      all_blocks[i] = Blocks[nil, file_to_move.size]

      # 2. replace space with item + maybe a remainder space item if space is larger than file
      if matching_space.size == file_to_move.size
        all_blocks[matching_space_index] = Blocks[file_to_move.id, file_to_move.size]
      elsif matching_space.size > file_to_move.size
        all_blocks[matching_space_index] = [
          Blocks[file_to_move.id, file_to_move.size],
          Blocks[nil, matching_space.size - file_to_move.size]
        ]
        all_blocks = all_blocks.flatten
      else
        raise "should not happen"
      end
    end

    # Compute the result
    result(all_blocks)
  end

  private

  def parse(data)
    data
      .first
      .chomp
      .chars
      .each_slice(2)
      .map.with_index { |(file_blocks, space_blocks), id| [Blocks[id.to_s, file_blocks.to_i], Blocks[nil, space_blocks.to_i]] }
      .flatten
  end

  # Expands the blocks to consecutive size-1 blocks
  # And do the result calculation
  def result(blocks)
    blocks
      .flat_map(&:to_a)
      .each_with_index.reduce(0) { |total, (b, index)| total + index * b.id.to_i }
  end
end
