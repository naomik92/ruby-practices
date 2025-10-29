#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'file_detail'
require_relative 'files_list'
require_relative 'files_table'

class LsCommand
  def initialize(files, options = {})
    @file_details = FileDetail.create_file_details(files)
    @options = options
  end

  def sort_files
    visible_files = options[:a] ? @file_details : @file_details.reject { |file_detail| file_detail.filename.start_with?('.') }
    options[:r] ? visible_files.reverse : visible_files
  end

  def build_files
    options[:l] ? FilesList.new(sort_files).build_rows : FilesTable.new(sort_files).format_table
  end

  def display
    build_files.each do |row|
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
