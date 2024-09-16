#!/usr/bin/env ruby
# frozen_string_literal: true

COL_NUMBERS = 3

def find_all_files
  Dir.entries('.').sort
end

def delete_hiddenfile(files)
  files.delete_if do |file|
    file.match(/^\.$|^\..+/)
  end
end

def align_columns(files)
  max_file_length = 0
  files.each do |file|
    max_file_length = file.bytesize if file.bytesize > max_file_length
  end

  row_numbers = (files.size - 1).div(COL_NUMBERS) + 1
  all_layout = []
  row_numbers.downto(1) do |rest_rows|
    row_layout = (0..files.size - 1).select { |int| int % row_numbers == (row_numbers - rest_rows) }
    all_layout.push(row_layout)
  end

  all_layout.each do |row_layout|
    row_layout.each do |index_number|
      print files[index_number].ljust(max_file_length + 1)
    end
    print "\n"
  end
end

all_files = find_all_files
display_files = delete_hiddenfile(all_files)
align_columns(display_files)
