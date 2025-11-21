#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'file_detail'
require_relative 'long_format'
require_relative 'short_format'

class LsCommand
  def initialize(file_names, options = {})
    @file_details = FileDetail.create_file_details(file_names)
    @options = options
  end

  def sort_files
    visible_files = options[:a] ? @file_details : @file_details.reject { |file_detail| file_detail.file_name.start_with?('.') }
    options[:r] ? visible_files.reverse : visible_files
  end

  def format
    format_klass = options[:l] ? LongFormat : ShortFormat
    format_klass.new(sort_files).build_format
  end

  def display
    format.each do |row|
      puts row.join
    end
  end

  private

  def options
    opt = OptionParser.new

    options = {}
    opt.on('-a') { |v| options[:a] = v }
    opt.on('-r') { |v| options[:r] = v }
    opt.on('-l') { |v| options[:l] = v }
    opt.parse(ARGV)
    options = @options if @options != {}
    options
  end
end
