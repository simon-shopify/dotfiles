#!/usr/bin/env ruby

require "pathname"

home = Pathname.new(File.expand_path("~"))
src_root = Pathname.new(File.dirname(__FILE__))

files = {
  ".tmux.conf" => "tmux.conf",
  ".emacs.d" => "emacs.d",
  ".spacemacs" => "spacemacs",
  ".spacemacs-layers" => "spacemacs-layers",
  ".gitconfig" => "gitconfig",
  ".gitignore" => "gitignore",
  ".zshrc" => "zshrc",
  ".zpath" => "zpath",
  ".zprofile" => "zprofile",
  ".zshenv" => "zshenv",
  ".config/bin" => "bin",
  ".lein" => "lein",
  ".gdbinit" => "gdbinit",
  ".irbrc" => "irbrc",
  ".rubocop.yml" => "rubocop.yml",
}

files.each do |target, source|
  target_path = home + target

  target_path.unlink if target_path.symlink?

  if target_path.exist?
    puts "#{target_path} already exists."
    next
  end

  source_path = src_root + source
  puts "Linking '#{target_path}' -> '#{source_path}'."
  File.symlink(source_path.realpath, target_path)
end
