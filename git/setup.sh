#!/bin/bash
#
# setup.sh by tc <nsd22843@gmail.com>
# setup git environment
# 
#

for file in `ls`
do
    if [ ! -f ~/.$file -a ! "${file}" = "setup.sh" ]; then
        ln -s $(PWD)/$file ~/.$file
    fi 
done


