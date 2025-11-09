#!/usr/bin/env ruby
# frozen_string_literal: true

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

  def self.create_file_details(files)
    file_stats = []
    files.each do |file|
      array = []
      array << file
      array << File::Stat.new(file)
      file_stats << FileDetail.new(array[0], array[1])
    end
    file_stats
  end

  def file_type_character
    FILE_TYPE_CHARACTER[@file_stat.ftype]
  end

  def file_permission
    file_mode = @file_stat.mode.to_s(8).rjust(6, '0')
    file_mode[3, 3].chars.map { |user_type| FILE_PERMISSION[user_type] }.join
  end
end
