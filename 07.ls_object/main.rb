#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'ls_command'

files = Dir.entries('.').sort
LsCommand.new(files).display
