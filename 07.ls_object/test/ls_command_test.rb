#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../ls_command'
require_relative '../files_table'
require_relative '../files_list'

class LsCommandTest < Minitest::Test
  def test_non_option
    files = Dir.entries('../').sort
    LsCommand.new(files).build_files
  end
end
