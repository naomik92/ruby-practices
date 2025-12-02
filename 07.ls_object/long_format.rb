#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'file_detail'

class LongFormat
  def initialize(file_details)
    @file_details = file_details
  end

  def build_format
    rows = []
    rows << ["total #{@file_details.sum(&:file_blocks)}"]
    @file_details.each do |detail|
      cols = []
      cols << detail.file_type_character
      cols << detail.file_permission
      cols << "  #{detail.hardlink_size.to_s.rjust(linksize_width)}"
      cols << " #{detail.user_name.ljust(username_width)}"
      cols << "  #{detail.group_name.ljust(groupname_width)}"
      cols << "  #{detail.file_size.to_s.rjust(filesize_width)}"
      cols << " #{detail.updated_time}"
      cols << " #{detail.file_name}"
      rows << cols
    end
    rows
  end

  private

  def linksize_width
    @file_details.map(&:hardlink_size).max.to_s.bytesize
  end

  def username_width
    @file_details.map(&:user_name).max.to_s.bytesize
  end

  def groupname_width
    @file_details.map(&:group_name).max.to_s.bytesize
  end

  def filesize_width
    @file_details.map(&:file_size).max.to_s.bytesize
  end
end
