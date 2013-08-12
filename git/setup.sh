#!/bin/bash
#
# setup.sh by tc <nsd22843@gmail.com>
# setup git environment
# 
#

for file in `ls`
do
    if [ ! -f ~/.$file -a ! "${file}" = "setup.sh" ]; then
        echo "ln -s `pwd`/$file ~/.$file"
        ln -s `pwd`/$file ~/.$file
    fi 
done

[ ! -f ~/.gitconfig.local ] && touch ~/.gitconfig.local

