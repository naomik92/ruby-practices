#!/usr/bin/env ruby
# frozen_string_literal: true

class DirectryFile
  def initialize(file_details)
    @file_details = file_details
  end

  def select_and_sort_files(options)
    visible_files = options[:a] ? @file_details : @file_details.reject { |file_detail| file_detail.filename.start_with?('.') }
    options[:r] ? visible_files.reverse : visible_files
  end
end
