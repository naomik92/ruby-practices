#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'
require 'date'

COL_COUNT = 3
FILE_TYPE_CHARACTER = {
  'file' => '-',
  'directory' => 'd',
  'characterSpecail' => 'c',
  'blockSpecial' => 'b',
  'fifo' => 'p',
  'link' => 'l',
  'socket' => 's'
}.freeze

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
  options[:l] ? display_file_details(sorted_files) : display_files(sorted_files)
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

def display_file_details(files)
  file_stats = files.to_h { |file| [file, File::Stat.new(file)] }
  linksize_width = file_stats.values.map(&:nlink).max.to_s.bytesize + 2
  filesize_width = file_stats.values.map(&:size).max.to_s.bytesize + 2
  puts "total #{file_stats.values.sum(&:blocks)}"

  file_stats.each do |file, file_stat|
    print FILE_TYPE_CHARACTER[file_stat.ftype]
    # display_file_permission(file_stat)

    file_permissions(file_stat).each do |file_permission|
      print file_permission[0] == '1' ? 'r' : '-'
      print file_permission[1] == '1' ? 'w' : '-'
      print file_permission[2] == '1' ? 'x' : '-'
    end
    print file_stat.nlink.to_s.rjust(linksize_width)
    print " #{Etc.getpwuid(file_stat.uid).name}"
    print "  #{Etc.getgrgid(file_stat.gid).name}"
    print file_stat.size.to_s.rjust(filesize_width)
    file_updated_time = file_stat.mtime.to_date < Date.today << 6 ? '  %Y' : ' %H:%M'
    print file_stat.mtime.strftime(" %_m %_d#{file_updated_time}")
    puts " #{file}"
  end
end

# def display_file_permission(file_stat)
#   file_mode = file_stat.mode.to_s(8).rjust(6, '0')
#   file_permission = file_mode[3, 3].chars.map do |user_type_octal|
#     format('%b', user_type_octal).rjust(3, '0').chars
#   end
#   file_permission.each do |user_type_binary|
#     print user_type_binary[0] == '1' ? 'r' : '-'
#     print user_type_binary[1] == '1' ? 'w' : '-'
#     print user_type_binary[2] == '1' ? 'x' : '-'
#   end
# end

def file_permissions(file_stat)
  file_mode = file_stat.mode.to_s(8).rjust(6, '0')
  file_mode[3, 3].chars.map do |user_type_octal|
    format('%b', user_type_octal).rjust(3, '0').chars
  end
end

main
