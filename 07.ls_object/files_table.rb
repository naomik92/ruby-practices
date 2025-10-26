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
      array = []
      row.each do |col|
        array << col.filename
      end
      p array
    end
  end
end
