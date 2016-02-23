#!/bin/bash

if [[ ! -d ~/.gitcontrib ]]; then
    echo "Install git contrib/completion scripts"
    curl -L --create-dirs -o ~/.gitcontrib/git-completion.zsh "https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh"
    curl -L --create-dirs -o ~/.gitcontrib/git-prompt.sh "https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh"
fi 
