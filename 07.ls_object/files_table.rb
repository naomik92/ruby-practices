#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file_detail'

class FilesTable
  COL_COUNT = 3

  def initialize(file_details)
    @file_details = file_details
  end

  def build_table
    files =
      if @file_details.size > COL_COUNT
        @file_details.each_slice((@file_details.size + COL_COUNT - 1) / COL_COUNT).to_a
      else
        @file_details
      end
    files.last << '' while files.last.length < files.first.length
    files.transpose
  end

  def display_table
    build_table.each do |row|
      cols = []
      row.each do |col|
        cols << col.filename
      end
      cols.each do |col|
        print col.ljust(col_width + 5)
      end
      print "\n"
    end
  end

  private

  def file_name
    @file_details.map(&:filename)
  end

  def col_width
    file_name.flatten.map(&:bytesize).max
  end
end
