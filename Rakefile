# -*- coding: utf-8 -*-

HOME = ENV["HOME"]

namespace :tmux do

  desc "Create symblic link to $HOME"
  task :link => File.join(HOME,".tmux-powerline") do
    TMUX_ROOT = File.join(File.dirname(__FILE__), "tmux")
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

