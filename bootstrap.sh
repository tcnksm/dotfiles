#!/bin/bash

set -e

info() { 
    echo -e "\033[34m$@\033[m" 
} 

warn() { 
    echo -e "\033[33m$@\033[m"
} 

error() { 
    echo -e "\033[31m$@\033[m"
} 

DIR=$(pwd)


if [[ ! -L $HOME/.dotfiles ]]; then
    info "---> Link dotfiles into HOME directory"
    ln -s $DIR $HOME/.dotfiles
fi

info "---> Install Homebrew Packages"
./homebrew/install.sh

info "---> Enable dotfile, make symbolic link to '${HOME}' directory"
rake clean && rake setup

info "---> Install git contrib/completion scripts"
if [[ ! -d ~/.gitcontrib ]]; then    
    curl -L --create-dirs -o ~/.gitcontrib/git-completion.zsh \
         "https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh"
    curl -L --create-dirs -o ~/.gitcontrib/git-prompt.sh \
         "https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh"
fi

info "---> Install Emacs cask"
pushd emacs.d && cask install && popd