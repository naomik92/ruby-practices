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

  def initialize(files)
    @files = files
  end

  def self.create_filedetails(files) #
    file_stats = []
    files.each do |file|
      array = []
      array << file
      array << File::Stat.new(file)
      file_stats << array
    end
    FileDetail.new(file_stats)
  end

  def build_filenames # 1
    @files.map do |file, file_stat|
      file
    end
  end

  def build_file_details # 2 1,2はなくてもよいのでは
    @files.map do |file, file_stat|
      file_stat
    end
  end

end
