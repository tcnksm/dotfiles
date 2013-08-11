#!/bin/bash
#
# setup oh-my-zsh environment by creating simbolic links.
# 

# if [ ! -d ~/.oh-my-zsh ] ; then
#     git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
# fi
# ln -s $(PWD)/theme/tc.zsh-theme $OH_MY_ZSH_HOME/themes/tc.zsh-theme

[ ! -d ~/.zsh ] && mkdir ~/.zsh
[ ! -f ~/.zshrc ] && ln -s $(PWD)/zshrc ~/.zshrc

for file in `ls`
do
    if [ ! -f ~/.zsh/$file -a ! "${file}" = "setup.sh" -a ! "${file}" = "zshrc" ]; then
	echo "ln -s $(PWD)/$file ~/.zsh/.$file"
        ln -s $(PWD)/$file ~/.zsh/$file
    fi 
done



