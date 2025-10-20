#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'filedetail'

files = Dir.entries('.').sort
file_details = FileDetail.create_filedetails(files)
p file_details.build_file_details
