# -*- coding: utf-8 -*-

HOME = ENV["HOME"]


namespace :git do
  GIT_ROOT = File.join(File.dirname(__FILE__), "git")
  
  desc "Create symbolic link to HOME"
  task :link => File.join(HOME,".gitconfig.local") do
    symlink_ File.join(GIT_ROOT,"gitconfig"), File.join(HOME, ".gitconfig")
    symlink_ File.join(GIT_ROOT,"gitignore.global"), File.join(HOME, ".gitignore.global")
  end

  desc "Create copy of gitconfig.local"
  file File.join(HOME, ".gitconfig.local") do
    cp File.join(GIT_ROOT,"gitconfig.local"), File.join(HOME,".gitconfig.local")
  end
end

namespace :tmux do
  TMUX_ROOT = File.join(File.dirname(__FILE__), "tmux")
  
  desc "Create symblic link to $HOME"
  task :link => File.join(HOME,".tmux-powerline") do
    symlink_ File.join(TMUX_ROOT,"tmux.conf"), File.join(HOME, ".tmux.conf")    
    symlink_ File.join(TMUX_ROOT,"tmux-powerline-theme.sh"), File.join(HOME, ".tmux-powerline/themes/mytheme.sh")
    symlink_ File.join(TMUX_ROOT,"tmux-powerlinerc"), File.join(HOME, ".tmux-powerlinerc")
  end
  
  desc "Download tmux-powerline"
  file File.join(HOME,".tmux-powerline") do |f|
    sh "git clone https://github.com/erikw/tmux-powerline.git #{f.name}"
  end
end

def symlink_ file, dest
  symlink file, dest if not File.exist?(dest)
end

