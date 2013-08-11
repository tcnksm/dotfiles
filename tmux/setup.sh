#!/bin/bash
#
# setup.sh by tcnksm <nsd22843@gmail.com>
# setup tmux environment
# 

if [ ! -d ~/.tmux-powerline ] ; then
    git clone git://github.com/erikw/tmux-powerline.git ~/.tmux-powerline
fi

ln -s $(PWD)/tmux.conf ~/.tmux.conf
ln -s $(PWD)/tmux-powerline-theme.sh ~/.tmux-powerline/themes/mytheme.sh
ln -s $(PWD)/tmux-powerlinerc ~/.tmux-powerlinerc

