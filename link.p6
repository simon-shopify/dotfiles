#!/usr/bin/env perl6

my @files = <
  bin shared-modules
  emacs.d spacemacs spacemacs-layers
  gitconfig gitignore
  rubocop.yml
  zshrc zpath zprofile zshenv
>;

for @files -> $file {
  my $target = $*SPEC.catdir(%*ENV<HOME>, ".$file").IO;

  given $target {
    when :l { .unlink }
    when :e { die("$_ already exists.") }
  }

  my $source = $*SPEC.catdir($*CWD, $file).IO;
  qq{Linking "$target" -> "$source".}.say;
  $source.symlink: $target;
}
