#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'ls_command'

file_names = Dir.entries('.').sort
LsCommand.new(file_names).display
