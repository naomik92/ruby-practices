#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'display_file_detail'
require_relative 'ls_command_option'

files = Dir.entries('.').sort
file_details = FileDetail.create_file_details(files)
options = LsCommandOption.new.options
data = DisplayFileDetail.new(file_details)
data.display_rows(options)
