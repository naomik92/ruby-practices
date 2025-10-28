#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'file_detail'
require_relative 'files_list'
require_relative 'files_table'

class LsCommand
  def initialize(files)
    @file_details = FileDetail.create_file_details(files)
  end

  def sort_files
    visible_files = options[:a] ? @file_details : @file_details.reject { |file_detail| file_detail.filename.start_with?('.') }
    options[:r] ? visible_files.reverse : visible_files
  end

  def build_files
    options[:l] ? FilesList.new(sort_files).build_list : FilesTable.new(sort_files).build_table
  end

  def display
    options[:l] ? FilesList.new(sort_files).display_list : FilesTable.new(sort_files).display_table
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
