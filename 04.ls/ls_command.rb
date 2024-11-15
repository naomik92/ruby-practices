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

FILE_PERMISSION = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
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

  puts "total #{file_stats.values.sum(&:blocks)}"
  print build_file_details_rows(file_stats).join("\n")
end

def build_file_details_rows(file_stats)
  linksize_width = file_stats.values.map(&:nlink).max.to_s.bytesize
  filesize_width = file_stats.values.map(&:size).max.to_s.bytesize

  file_stats.map do |file, file_stat|
    cols = []
    cols << FILE_TYPE_CHARACTER[file_stat.ftype]
    cols << convert_file_permissions(file_stat)
    cols << "  #{file_stat.nlink.to_s.rjust(linksize_width)}"
    cols << " #{Etc.getpwuid(file_stat.uid).name}"
    cols << "  #{Etc.getgrgid(file_stat.gid).name}"
    cols << "  #{file_stat.size.to_s.rjust(filesize_width)}"
    cols << " #{format_updated_time(file_stat)}"
    cols << " #{file}"
    cols.join
  end
end

def convert_file_permissions(file_stat)
  file_mode = file_stat.mode.to_s(8).rjust(6, '0')
  file_mode[3, 3].chars.map { |user_type| FILE_PERMISSION[user_type] }.join
end

def format_updated_time(file_stat)
  updated_time = file_stat.mtime.to_date < Date.today << 6 ? '  %Y' : ' %H:%M'
  file_stat.mtime.strftime("%_m %_d#{updated_time}")
end

main
