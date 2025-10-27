#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

class DirectryFile
  def initialize(file_details)
    @file_details = file_details
  end

  def select_and_sort_files
    visible_files = options[:a] ? @file_details : @file_details.reject { |file_detail| file_detail.filename.start_with?('.') }
    options[:r] ? visible_files.reverse : visible_files
  end

  def options
    opt = OptionParser.new

    options = {}
    opt.on('-a') { |v| options[:a] = v }
    opt.on('-r') { |v| options[:r] = v }
    opt.on('-l') { |v| options[:l] = v }
    opt.parse(ARGV)
    options
  end
end
