#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file_detail'
require 'etc'
require 'date'

class DisplayFileDetail
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

  def initialize(data_for_display)
    @data_for_display = data_for_display
  end

  def build_rows
    array = []
    @data_for_display.each do |detail|
      cols = []
      cols << FILE_TYPE_CHARACTER[detail.file_stat.ftype]
      cols << convert_file_permissions(detail.file_stat)
      cols << "  #{detail.file_stat.nlink.to_s.rjust(linksize_width)}"
      cols << " #{Etc.getpwuid(detail.file_stat.uid).name}"
      cols << "  #{Etc.getgrgid(detail.file_stat.gid).name}"
      cols << "  #{detail.file_stat.size.to_s.rjust(filesize_width)}"
      cols << " #{format_updated_time(detail.file_stat)}"
      cols << " #{detail.filename}"
      array << cols
    end
    array
  end

  def display_rows
    build_rows.each do |row|
      puts row.join
    end
  end
  
  def file_stats
    array = []
    @data_for_display.each do |detail|
      array << detail.file_stat
    end
    array
  end

  def linksize_width
    file_stats.map(&:nlink).max.to_s.bytesize
  end

  def filesize_width
    file_stats.map(&:size).max.to_s.bytesize
  end

  def convert_file_permissions(file_stat)
    file_mode = file_stat.mode.to_s(8).rjust(6, '0')
    file_mode[3, 3].chars.map { |user_type| FILE_PERMISSION[user_type] }.join
  end

  def format_updated_time(file_stat)
    updated_time = file_stat.mtime.to_date < Date.today << 6 ? '  %Y' : ' %H:%M'
    file_stat.mtime.strftime("%_m %_d#{updated_time}")
  end
end
