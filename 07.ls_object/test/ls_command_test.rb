#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../ls_command'

class LsCommandTest < Minitest::Test
  def test_non_option
    options = {}
    file_names = Dir.entries('.').sort.reject
    expected_files_array = [['abc.txt', 'ghi.txt', 'ls_command_test.rb'], ['def.txt', 'jk.txt', '']]
    actual_files_array = LsCommand.new(file_names, options).main.map { |row| row.map(&:rstrip) }
    assert_equal expected_files_array, actual_files_array
  end

  def test_a_option
    options = { a: true }
    file_names = Dir.entries('.').sort.reject
    expected_files_array = [['.', 'def.txt', 'ls_command_test.rb'], ['..', 'ghi.txt', ''], ['abc.txt', 'jk.txt', '']]
    actual_files_array = LsCommand.new(file_names, options).main.map { |row| row.map(&:rstrip) }
    assert_equal expected_files_array, actual_files_array
  end

  def test_r_option
    options = { r: true }
    file_names = Dir.entries('.').sort.reject
    expected_files_array = [['ls_command_test.rb', 'ghi.txt', 'abc.txt'], ['jk.txt', 'def.txt', '']]
    actual_files_array = LsCommand.new(file_names, options).main.map { |row| row.map(&:rstrip) }
    assert_equal expected_files_array, actual_files_array
  end

  def test_l_option
    options = { l: true }
    file_names = Dir.entries('.').sort.reject
    expected_files_array = [['total 8'], ['-', 'rw-r--r--'], ['-', 'rw-r--r--'], ['-', 'rw-r--r--'], ['-', 'rw-r--r--'], ['-', 'rwxr--r--']]
    actual_files_array = LsCommand.new(file_names, options).main.map { |row| row[0, 2] }
    assert_equal expected_files_array, actual_files_array
  end

  def test_all_option
    options = { a: true, r: true, l: true }
    file_names = Dir.entries('.').sort.reject
    expected_files_array = [['total 8'], ['-', 'rwxr--r--'], ['-', 'rw-r--r--'], ['-', 'rw-r--r--'],
                            ['-', 'rw-r--r--'], ['-', 'rw-r--r--'], ['d', 'rwxr-xr-x'], ['d', 'rwxr-xr-x']]
    actual_files_array = LsCommand.new(file_names, options).main.map { |row| row[0, 2] }
    assert_equal expected_files_array, actual_files_array
  end
end
