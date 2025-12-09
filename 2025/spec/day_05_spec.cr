require "./spec_helper"
require "../src/day_05"

# run this specific file with: crystal spec --tag 'day_05'

describe Day05, tags: "day_05" do
  describe "part 1" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_05_test.txt")
      Day05.part_1(test_data, must_log: false).should eq 3
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_05.txt")
      Day05.part_1(test_data, must_log: false).should eq 828
    end
  end

  describe "part 2" do
    describe Day05::FreshRange, tags: "support" do
      describe "#overlaps_or_consecutive?" do
        it "return false for distinct ranges" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(14, 18)

          first.overlaps_or_consecutive?(second).should eq false
          second.overlaps_or_consecutive?(first).should eq false
        end

        it "returns true for consecutive ranges" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(12, 18)

          first.overlaps_or_consecutive?(second).should eq true
          second.overlaps_or_consecutive?(first).should eq true

          first = Day05::FreshRange.new(10, 18)
          second = Day05::FreshRange.new(1, 10)

          first.overlaps_or_consecutive?(second).should eq true
          second.overlaps_or_consecutive?(first).should eq true
        end

        it "returns true for same range" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(1, 12)

          first.overlaps_or_consecutive?(second).should eq true
          second.overlaps_or_consecutive?(first).should eq true
        end

        it "returns true if one range is included in the other" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(5, 8)

          first.overlaps_or_consecutive?(second).should eq true
          second.overlaps_or_consecutive?(first).should eq true
        end

        it "returns true for regular overlaps" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(5, 14)

          first.overlaps_or_consecutive?(second).should eq true
          second.overlaps_or_consecutive?(first).should eq true

          first = Day05::FreshRange.new(10, 18)
          second = Day05::FreshRange.new(5, 14)

          first.overlaps_or_consecutive?(second).should eq true
          second.overlaps_or_consecutive?(first).should eq true
        end

        it "returns true for overlaps with same begin" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(1, 14)

          first.overlaps_or_consecutive?(second).should eq true
          second.overlaps_or_consecutive?(first).should eq true

          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(1, 20)

          first.overlaps_or_consecutive?(second).should eq true
          second.overlaps_or_consecutive?(first).should eq true
        end

        it "returns true for overlaps with same end" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(5, 12)

          first.overlaps_or_consecutive?(second).should eq true
          second.overlaps_or_consecutive?(first).should eq true

          first = Day05::FreshRange.new(10, 18)
          second = Day05::FreshRange.new(5, 18)

          first.overlaps_or_consecutive?(second).should eq true
          second.overlaps_or_consecutive?(first).should eq true
        end
      end

      describe "#merge" do
        it "raises for distinct ranges" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(14, 18)

          expect_raises(Exception) do
            first.merge(second)
          end

          expect_raises(Exception) do
            second.merge(first)
          end
        end

        it "merges two consecutive ranges" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(12, 18)

          res = first.merge(second)
          res.begin.should eq 1
          res.end.should eq 18

          res = second.merge(first)
          res.begin.should eq 1
          res.end.should eq 18
        end

        it "merges two same ranges into a single one" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(1, 12)

          res = first.merge(second)
          res.begin.should eq 1
          res.end.should eq 12

          res = second.merge(first)
          res.begin.should eq 1
          res.end.should eq 12
        end

        it "merges and extends the range if one range is included in the other" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(5, 8)

          res = first.merge(second)
          res.begin.should eq 1
          res.end.should eq 12

          res = second.merge(first)
          res.begin.should eq 1
          res.end.should eq 12
        end

        it "returns true for regular overlaps" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(5, 14)

          res = first.merge(second)
          res.begin.should eq 1
          res.end.should eq 14

          res = second.merge(first)
          res.begin.should eq 1
          res.end.should eq 14

          first = Day05::FreshRange.new(10, 18)
          second = Day05::FreshRange.new(5, 14)

          res = first.merge(second)
          res.begin.should eq 5
          res.end.should eq 18

          res = second.merge(first)
          res.begin.should eq 5
          res.end.should eq 18
        end

        it "returns true for overlaps with same begin" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(1, 14)

          res = first.merge(second)
          res.begin.should eq 1
          res.end.should eq 14

          res = second.merge(first)
          res.begin.should eq 1
          res.end.should eq 14
        end

        it "returns true for overlaps with same end" do
          first = Day05::FreshRange.new(1, 12)
          second = Day05::FreshRange.new(5, 12)

          res = first.merge(second)
          res.begin.should eq 1
          res.end.should eq 12

          res = second.merge(first)
          res.begin.should eq 1
          res.end.should eq 12
        end
      end

      describe "#size" do
        it "return 1 if begin and end are the same" do
          Day05::FreshRange.new(10, 10).size.should eq 1
        end

        it "return the number of items for regular ranges" do
          # 1, 2, 3, 4
          Day05::FreshRange.new(1, 4).size.should eq 4
        end
      end
    end

    it "works with example data", tags: "focus" do
      test_data = File.read_lines("./data/day_05_test.txt")
      Day05.part_2(test_data, must_log: false).should eq 14
    end

    it "works with custom data" do
      data = ["1-2", "2-2", "2-4", "10-12", "9-13"]
      Day05.part_2(data, must_log: false).should eq 4 + 5

      data = ["2-3", "5-6", "1-8", "5-10", "6-12"]
      Day05.part_2(data, must_log: false).should eq 12
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_05.txt")
      Day05.part_2(test_data, must_log: false).should eq 352_681_648_086_146
    end
  end
end
