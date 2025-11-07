#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file_detail'

class ShortFormat
  COL_COUNT = 3

  def initialize(file_details)
    @file_details = file_details
  end

  def build_table
    files =
      if file_names.size > COL_COUNT
        file_names.each_slice((file_names.size + COL_COUNT - 1) / COL_COUNT).to_a
      else
        file_names
      end
    files.last << '' while files.last.length < files.first.length
    files.transpose
  end

  def format_table
    build_table.map do |columns|
      columns.map do |col|
        col.ljust(col_width + 5)
      end
    end
  end

  private

  def file_names
    @file_details.map(&:filename)
  end

  def col_width
    file_names.flatten.map(&:bytesize).max
  end
end
