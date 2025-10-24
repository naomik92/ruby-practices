#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'display_file_detail'

files = Dir.entries('.').sort
file_details = FileDetail.create_filedetails(files)
data = DisplayFileDetail.new(file_details)
data.display_rows
