#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'

COL_COUNT = 3

def main
  opt = OptionParser.new

  options = {}
  opt.on('-a') { |v| options[:a] = v }
  opt.on('-r') { |v| options[:r] = v }
  opt.on('-l') { |v| options[:l] = v }
  opt.parse(ARGV)

  all_files = find_all_files
  visible_files = options[:a] ? all_files : select_visible_files(all_files)
  sorted_files = options[:r] ? visible_files.reverse : visible_files
  options[:l] ? display_files_detail(sorted_files) : display_files(sorted_files)
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

def display_files_detail(files)
  files_data = files.map { |file| File::Stat.new(file) }
  files_detail = Hash[files.zip(files_data)] # new
  linksize_width = files_data.map(&:nlink).max.to_s.bytesize + 2
  filesize_width = files_data.map(&:size).max.to_s.bytesize + 2
  puts "total #{files_data.map(&:blocks).sum}"

  files_detail.each do |file, file_data|
    display_filetype(file_data)
    display_file_permission(file_data)
    print file_data.nlink.to_s.rjust(linksize_width)
    print " #{Etc.getpwuid(file_data.uid).name}"
    print "  #{Etc.getgrgid(file_data.gid).name}"
    print file_data.size.to_s.rjust(filesize_width)
    print file_data.mtime.strftime(' %_m %_d')
    display_file_updated_time(file_data)
    puts " #{file}"
  end
end

def display_filetype(file_data)
  file_type_character = { 'file' => '-', 'directory' => 'd', 'characterSpecail' => 'c', 'blockSpecial' => 'b', 'fifo' => 'p', 'link' => 'l', 'socket' => 's' }
  print file_type_character[file_data.ftype]
end

def display_file_permission(file_data)
  file_mode = file_data.mode.to_s(8).rjust(6, '0')
  file_permission = file_mode[3, 3].chars.map do |user_type_octal|
    format('%b', user_type_octal).rjust(3, '0').chars
  end
  file_permission.each do |user_type_binary|
    print user_type_binary[0] == '1' ? 'r' : '-'
    print user_type_binary[1] == '1' ? 'w' : '-'
    print user_type_binary[2] == '1' ? 'x' : '-'
  end
end

def display_file_updated_time(file_data)
  if file_data.mtime.to_date < Date.today << 6
    print file_data.mtime.strftime('  %Y')
  else
    print file_data.mtime.strftime(' %H:%M')
  end
end

main
