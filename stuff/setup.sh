#!/bin/sh

if [ `uname` = "Linux" ]; then
    echo "ln -s `pwd`/fonts ~/.fonts"
    ln -s `pwd`/fonts ~/.fonts
fi
