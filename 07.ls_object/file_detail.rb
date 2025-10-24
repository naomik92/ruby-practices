#!/usr/bin/env ruby
# frozen_string_literal: true

class FileDetail
  attr_reader :filename, :file_stat
  def initialize(filename, file_stat)
    @filename = filename
    @file_stat = file_stat
  end

  def self.create_filedetails(files) #
    file_stats = []
    files.each do |file|
      array = []
      array << file
      array << File::Stat.new(file)
      file_stats << FileDetail.new(array[0], array[1])
    end
    file_stats
  end
end
