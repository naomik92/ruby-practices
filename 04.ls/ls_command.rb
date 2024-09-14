#!/usr/bin/env ruby
# frozen_string_literal: true

contain_files = Dir.entries('.').sort
contain_files.delete_if do |file|
  file.match(/^\.$|^\..+/)
end

# # copy_layout = all_layout.dup
col_numbers = 3
row_numbers = (contain_files.size - 1).div(col_numbers) + 1
row_countdown = row_numbers
all_layout = []

row_countdown -= 1
# copy_layout = all_layout.dup
row_layout = (1..contain_files.size).select { |int| int % row_numbers == row_countdown }
all_layout.push(row_layout)
