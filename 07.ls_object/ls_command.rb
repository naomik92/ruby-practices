#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'directry_file'
require_relative 'files_list'
require_relative 'files_table'

class LsCommand
  def initialize(files)
    @files = files
  end

  def display
    file_details = FileDetail.create_file_details(@files)
    directry_file = DirectryFile.new(file_details)
    sorted_files = directry_file.select_and_sort_files
    ls_options = directry_file.options
    ls_options[:l] ? FilesList.new(sorted_files).display_list : FilesTable.new(sorted_files).display_table
  end
end
