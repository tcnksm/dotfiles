#!/bin/bash
#
# setup.sh by tcnksm <nsd22843@gmail.com>
# setup tmux environment
# 

if [ ! -d ~/.tmux-powerline ] ; then
    git clone https://github.com/erikw/tmux-powerline.git ~/.tmux-powerline
fi

ln -s `pwd`/tmux.conf ~/.tmux.conf
ln -s `pwd`/tmux-powerline-theme.sh ~/.tmux-powerline/themes/mytheme.sh
ln -s `pwd`/tmux-powerlinerc ~/.tmux-powerlinerc

