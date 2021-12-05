# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['*_test.rb']
end

task :run, [:day] do |_, args|
  puts args
  file_name = "./day_#{args[:day]}.rb"
  require file_name

  class_name = "Day#{args[:day]}"
  class_const = Object.const_get(class_name)
  puts "Day #{args[:day]}".center(10, '-')
  puts "Part 1 => #{class_const.new.compute_part_1!}"
  puts "Part 2 => #{class_const.new.compute_part_2!}"
end

task default: :test
