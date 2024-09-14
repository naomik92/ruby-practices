#!/usr/bin/env ruby
# frozen_string_literal: true

contain_files = Dir.entries('.').sort
contain_files.delete_if do |file|
  file.match(/^\.$|^\..+/)
end

# 1行に出力したいインデックス番号を、別の二次元配列に格納(すべての行)
col_numbers = 3
row_numbers = (contain_files.size - 1).div(col_numbers) + 1
all_layout = []

(row_numbers - 1).downto(0) do |x|
  row_layout = (1..contain_files.size).select { |int| int % row_numbers == (row_numbers - x) % row_numbers }
  all_layout.push(row_layout)
end

p all_layout
