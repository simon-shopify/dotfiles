#!/usr/bin/env ruby

require 'pathname'
require 'yaml'

home = Pathname.new(File.expand_path("~"))
src_root = Pathname.new(File.dirname(__FILE__))

link_spec_path = src_root + 'link.yaml'
YAML.load_file(link_spec_path.realpath).each_pair do |target, source|
  target_path = home + target

  if target_path.symlink?
    target_path.unlink
  end

  if target_path.exist?
    puts "#{target_path} already exists."
    next
  end

  source_path = src_root + source
  puts "Linking '#{target_path}' -> '#{source_path}'."
  File.symlink(source_path.realpath, target_path)
end
