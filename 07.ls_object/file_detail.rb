#!/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'
require 'date'

class FileDetail
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

  attr_reader :filename, :file_stat

  def initialize(filename, file_stat)
    @filename = filename
    @file_stat = file_stat
  end

  def self.create_file_details(file_names)
    file_names.map do |file_name|
      FileDetail.new(file_name, File::Stat.new(file_name))
    end
  end

  def file_type_character
    FILE_TYPE_CHARACTER[@file_stat.ftype]
  end

  def file_permission
    file_mode = @file_stat.mode.to_s(8).rjust(6, '0')
    file_mode[3, 3].chars.map { |user_type| FILE_PERMISSION[user_type] }.join
  end

  def user_name
    Etc.getpwuid(@file_stat.uid).name
  end

  def group_name
    Etc.getgrgid(@file_stat.gid).name
  end

  def format_updated_time
    updated_time = @file_stat.mtime.to_date < Date.today << 6 ? '  %Y' : ' %H:%M'
    @file_stat.mtime.strftime("%_m %_d#{updated_time}")
  end
end
