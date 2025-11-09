#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file_detail'
require 'etc'
require 'date'

class LongFormat
  def initialize(file_details)
    @file_details = file_details
  end

  def build_rows
    rows = []
    rows << ["total #{file_stats.sum(&:blocks)}"]
    @file_details.each do |detail|
      cols = []
      cols << detail.file_type_character
      cols << detail.file_permission
      cols << "  #{detail.file_stat.nlink.to_s.rjust(linksize_width)}"
      cols << " #{Etc.getpwuid(detail.file_stat.uid).name.rjust(username_width)}"
      cols << "  #{Etc.getgrgid(detail.file_stat.gid).name.rjust(groupname_width)}"
      cols << "  #{detail.file_stat.size.to_s.rjust(filesize_width)}"
      cols << " #{format_updated_time(detail.file_stat)}"
      cols << " #{detail.filename}"
      rows << cols
    end
    rows
  end

  private

  def file_stats
    @file_details.map(&:file_stat)
  end

  def linksize_width
    file_stats.map(&:nlink).max.to_s.bytesize
  end

  def username_width
    file_stats.map { |file_stat| Etc.getpwuid(file_stat.uid).name }.max.to_s.bytesize
  end

  def groupname_width
    file_stats.map { |file_stat| Etc.getgrgid(file_stat.gid).name }.max.to_s.bytesize
  end

  def filesize_width
    file_stats.map(&:size).max.to_s.bytesize
  end

  def format_updated_time(file_stat)
    updated_time = file_stat.mtime.to_date < Date.today << 6 ? '  %Y' : ' %H:%M'
    file_stat.mtime.strftime("%_m %_d#{updated_time}")
  end
end
