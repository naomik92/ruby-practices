#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'files_list'
require_relative 'files_table'
require_relative 'ls_command_option'
require_relative 'directry_file'

files = Dir.entries('.').sort
file_details = FileDetail.create_file_details(files)
options = LsCommandOption.new.options
files = DirectryFile.new(file_details).select_and_sort_files(options)
# l_option = FilesList.new(files).display_list

FilesTable.new(files).display_table
