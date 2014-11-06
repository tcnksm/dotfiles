# -*- coding: utf-8 -*-
require 'rake/clean'

HOME = ENV["HOME"]
OS = `uname`

GIT_ROOT    =  File.join(File.dirname(__FILE__), "git")
ZSH_ROOT    =  File.join(File.dirname(__FILE__), "zsh")
ATOM_ROOT   =  File.join(File.dirname(__FILE__), "atom")
ETC_ROOT    =  File.join(File.dirname(__FILE__), "etc")
TMUX_ROOT   =  File.join(File.dirname(__FILE__), "tmux")
SLATE_ROOT  =  File.join(File.dirname(__FILE__), "slate")
PERCOL_ROOT =  File.join(File.dirname(__FILE__), "percol")

ETC_DOT_FILES  =  Dir.glob("etc" +  "/*").map{|path| File.basename(path)}

cleans = [
          ".emacs.d",
          ".zshrc",
          ".oh-my-zsh",
          ".tmux.conf",
          ".gitconfig",
          ".gitignore.global",
          ".gemrc",
          ".slate",
          ".slate.js",
          ".percol.d"
         ]

CLEAN.concat(cleans.map{|c| File.join(HOME,c)})

task :default => :all
task :all => ["emacs:link", "atom:link", "git:link","tmux:link","zsh:link", "font:link", "slate:link","etc:link"]

namespace :emacs do
  desc "Create symbolic link to HOME"
  task :link do
    
    # If .emacs.d is already exist, backup it
    if File.exist?(File.join(HOME, ".emacs.d")) && !File.symlink?(File.join(HOME, ".emacs.d")) 
      mv File.join(HOME, ".emacs.d"), File.join(HOME, ".emacs.d.org")
    end
    
    symlink_ File.join(File.dirname(__FILE__), "emacs.d"), File.join(HOME,".emacs.d")
  end
end

namespace :zsh do
  desc "Create symbolic link to HOME/.zshrc"
  task :link do

    # If `.zshrc` is already exist, backup it
    if File.exist?(File.join(HOME, ".zshrc")) && !File.symlink?(File.join(HOME, ".zshrc"))
      mv File.join(HOME, ".zshrc"), File.join(HOME, ".zshrc.org")
    end

    symlink_ File.join(ZSH_ROOT, "zshrc"), File.join(HOME, ".zshrc")      
  end
end

namespace :percol do
  desc "Create symbolic link"
  task :link do
    symlink_ PERCOL_ROOT, File.join(HOME, ".percol.d")
  end
end

namespace :git do
  desc "Create symbolic link to HOME"
  task :link => File.join(HOME,".gitconfig.local") do    
    same_name_symlinks GIT_ROOT, ["gitconfig", "gitignore.global"]
  end

  desc "Create copy of gitconfig.local"
  file File.join(HOME, ".gitconfig.local") do
    cp File.join(GIT_ROOT,"gitconfig.local"), File.join(HOME,".gitconfig.local")
  end
end

namespace :tmux do  
  desc "Create symblic link to HOME"
  task :link do
    same_name_symlinks TMUX_ROOT, ["tmux.conf"]
  end
end

namespace :slate do
  desc "Create symbolic link"
  task :link do
    same_name_symlinks SLATE_ROOT, ["slate", "slate.js"] if OS =~ /^Darwin/
  end
end

namespace :etc do
  task :link do
    same_name_symlinks ETC_ROOT, ETC_DOT_FILES
  end
end

def symlink_ file, dest
  symlink file, dest if not File.exist?(dest)
end

def same_name_symlinks root, files
  files.each do |file|
    symlink_ File.join(root, file), File.join(HOME, "." + file)
  end
end
