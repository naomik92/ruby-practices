#!/usr/bin/env ruby
# frozen_string_literal: true

COL_COUNT = 3

def main
  all_files = find_all_files
  visible_files = delete_hiddenfile(all_files)
  display_files(visible_files)
end

def find_all_files
  Dir.entries('.').sort
end

def delete_hiddenfile(files)
  files.reject { |file| file.start_with?(/\./) }
end

def display_files(files)
  max_file_length = files.flatten.map(&:bytesize).max
  row_count = (files.size - 1).div(COL_COUNT) + 1
  rows_order = []

  row_count.downto(1) do |n|
    files_order = (0..files.size - 1).select { |i| i % row_count == (row_count - n) }
    rows_order.push(files_order)
  end

  rows_order.each do |files_order|
    files_order.each do |index_number|
      print files[index_number].ljust(max_file_length + 1)
    end
    print "\n"
  end
end

main
