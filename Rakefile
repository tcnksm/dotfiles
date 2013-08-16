# -*- coding: utf-8 -*-

HOME = ENV["HOME"]
OS = `uname`

task :default => :all
task :all => ["emacs:link", "git:link","tmux:link","zsh:link", "font:link"]

namespace :emacs do
  desc "Create symbolic link to HOME"
  task :link do
    symlink_ File.join(File.dirname(__FILE__), "emacs.d"), File.join(HOME,".emacs.d")
  end
end

namespace :git do
  GIT_ROOT = File.join(File.dirname(__FILE__), "git")
  
  desc "Create symbolic link to HOME"
  task :link => File.join(HOME,".gitconfig.local") do    
    same_name_symlinks GIT_ROOT, "gitconfig", "gitignore.global"
  end

  desc "Create copy of gitconfig.local"
  file File.join(HOME, ".gitconfig.local") do
    cp File.join(GIT_ROOT,"gitconfig.local"), File.join(HOME,".gitconfig.local")
  end
end

namespace :tmux do
  TMUX_ROOT = File.join(File.dirname(__FILE__), "tmux")
  
  desc "Create symblic link to HOME"
  task :link => File.join(HOME,".tmux-powerline") do
    same_name_symlinks TMUX_ROOT, "tmux.conf", "tmux-powerlinerc"
    symlink_ File.join(TMUX_ROOT,"tmux-powerline-theme.sh"), File.join(HOME, ".tmux-powerline/themes/mytheme.sh")
  end
  
  desc "Download tmux-powerline"
  file File.join(HOME,".tmux-powerline") do |f|
    sh "git clone https://github.com/erikw/tmux-powerline.git #{f.name}"
  end
end

namespace :zsh do
  ZSH_ROOT = File.join(File.dirname(__FILE__), "zsh")
  DOT_FILES = %w{ zshrc.global zshrc.function zshrc.alias zshrc.osx zshrc.linux }
  
  desc "Create symblic link to HOME/.zsh"
  task :link => [File.join(HOME,".oh-my-zsh"), File.join(HOME,".zsh")] do
    DOT_FILES.each do |f|
      symlink_ File.join(ZSH_ROOT,f), File.join(HOME, ".zsh", f)
    end
    symlink_ File.join(ZSH_ROOT, "zshrc"), File.join(HOME, ".zshrc")
    symlink_ File.join(ZSH_ROOT, "oh-my-zsh-theme","tc.zsh-theme"), File.join(HOME,".oh-my-zsh","themes","tc.zsh-theme")
  end
  
  desc "Download oh-my-zsh"
  file File.join(HOME,".oh-my-zsh") do |f|
    sh "git clone https://github.com/robbyrussell/oh-my-zsh.git #{f.name}"
  end

  file File.join(HOME, ".zsh") do |f|
    mkdir f.name
  end
end

namespace :font do
  FONT_ROOT  = File.join(File.dirname(__FILE__), "stuff", "fonts")
  task :link do
    case OS
    when /^Darwin/
      cp Dir.glob(FONT_ROOT + "/*\.*"), File.join(HOME, "Library","Fonts")
    when /^Linux/
      symlink_ FONT_ROOT, File.join(HOME, ".fonts")
    end
  end
end

def symlink_ file, dest
  symlink file, dest if not File.exist?(dest)
end

def same_name_symlinks root, *files
  files.each do |file|
    symlink_ File.join(root, file), File.join(HOME, "." + file)
  end
end
