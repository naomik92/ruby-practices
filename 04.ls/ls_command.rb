#!/usr/bin/env ruby
# frozen_string_literal: true

COL_NUMBERS = 3

contain_files = Dir.entries('.').sort

contain_files.delete_if do |file|
  file.match(/^\.$|^\..+/)
end

max_file_length = 0
contain_files.each do |file|
  max_file_length = file.bytesize if file.bytesize >= max_file_length
end

row_numbers = (contain_files.size - 1).div(COL_NUMBERS) + 1
all_layout = []
row_numbers.downto(1) do |x|
  row_layout = (0..contain_files.size - 1).select { |int| int % row_numbers == (row_numbers - x) }
  all_layout.push(row_layout)
end

all_layout.each do |row|
  row.each do |index_number|
    print contain_files[index_number].ljust(max_file_length + 1)
  end
  print "\n"
end
