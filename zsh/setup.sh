#!/bin/bash
#
# setup oh-my-zsh environment by creating simbolic links.
# 


readonly DOT_FILES=( zshrc.global zshrc.alias zshrc.osx zshrc.linux )

mv ~/.zshrc ~/.zshrc.org
ln -s $(PWD)/zshrc ~/.zshrc

[ ! -d ~/.zsh ] && mkdir ~/.zsh

for file in ${DOT_FILES[@]}
do
    if [ ! -f ~/.zsh/$file ]; then
        echo "ln -s $(PWD)/$file ~/.zsh/$file"
        ln -s $(PWD)/$file ~/.zsh/$file
    fi 
done

if [ ! -d ~/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

if [ ! -f ~/.oh-my-zsh/themes/tc.zsh-theme ]; then
    ln -s $(PWD)/oh-my-zsh-theme/tc.zsh-theme ~/.oh-my-zsh/themes/tc.zsh-theme
fi




