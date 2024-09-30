#!/usr/bin/env ruby
# frozen_string_literal: true

COL_COUNT = 3

def main
  all_files = find_all_files
  visible_files = select_visible_files(all_files)
  display_files(visible_files)
end

def find_all_files
  Dir.entries('.').sort
end

def select_visible_files(files)
  files.reject { |file| file.start_with?('.') }
end

def display_files(files)
  col_width = files.flatten.map(&:bytesize).max
  row_count = (files.size - 1).div(COL_COUNT) + 1

  table_indexes = (1..row_count).map do |row_no|
    files.size.times.select { |file_idx| file_idx % row_count == row_no - 1 }
  end

  table_indexes.each do |file_indexes|
    file_indexes.each do |file_idx|
      print files[file_idx].ljust(col_width + 1)
    end
    print "\n"
  end
end

main
