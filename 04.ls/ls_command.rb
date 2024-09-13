#!/usr/bin/env ruby
# frozen_string_literal: true

contain_files = Dir.entries('.').sort
contain_files.delete_if do |file|
  file.match(/^\.$|^\..+/)
end
p contain_files
