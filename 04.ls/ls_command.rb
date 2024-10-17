#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

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
  file_blocks = files.map do |file|
    File::Stat.new(file).blocks
  end
  print "total #{file_blocks.sum}\n"

  files.each do |file|
    file_data = File::Stat.new(file)
    file_type = file_data.ftype
    file_mode = file_data.mode.to_s(8).rjust(6, '0')
    file_permission = file_mode[3, 3].chars.map do |user_type_octal|
      format('%b', user_type_octal).rjust(3, '0').chars
    end
    filesize_width = find_files_bytesize(files).max + 2

    check_special_permission(file_data, file_permission)
    display_filetype(file_type)
    display_file_permission(file_permission)
    print file_data.nlink.to_s.rjust(3)
    print " #{Etc.getpwuid(file_data.uid).name}"
    print "  #{Etc.getgrgid(file_data.gid).name}"
    print file_data.size.to_s.rjust(filesize_width)
    print file_data.mtime.month.to_s.rjust(3)
    print file_data.mtime.day.to_s.rjust(3)
    print file_data.mtime.strftime('%H:%M').rjust(6)
    print " #{file}\n"
  end
end

def check_special_permission(file_data, permission)
  if file_data.setuid?
    permission[0][2] = (permission[0][2] == '1' ? 's' : 'S')
  elsif file_data.setgid?
    permission[1][2] = (permission[1][2] == '1' ? 's' : 'S')
  elsif file_data.sticky?
    permission[2][2] = (permission[2][2] == '1' ? 't' : 'T')
  end
end

def display_filetype(file_type)
  case file_type
  when 'directory'
    print 'd'
  when 'characterSpecial'
    print 'c'
  when 'blockSpecial'
    print 'b'
  when 'fifo'
    print 'p'
  when 'link'
    print 'l'
  when 'socket'
    print 's'
  else
    print '-'
  end
end

def display_file_permission(file_permission)
  file_permission.each do |user_type_binary|
    print user_type_binary[0] == '1' ? 'r' : '-'
    print user_type_binary[1] == '1' ? 'w' : '-'
    if user_type_binary[2] != '1' && user_type_binary[2] != '0'
      print user_type_binary[2]
    else
      print user_type_binary[2] == '1' ? 'x' : '-'
    end
  end
end

def find_files_bytesize(files)
  files.map do |file|
    File::Stat.new(file).size.to_s.bytesize
  end
end

main
