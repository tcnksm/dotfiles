#!/bin/bash

cd "$(dirname "$0")"

set -e

info() {
    echo -e "\033[34m$@\033[m" # blue
}

warn() {
    echo -e "\033[33m$@\033[m" # yellow
}

error() {
    echo -e "\033[31m$@\033[m" # red
}

info "---> Install Homebrew Packages"
./homebrew/install.sh

info "---> Install Emacs cask"
pushd emacs.d && cask install && popd

info "---> Setup directory for peco"
mkdir -p $HOME/.config/peco/

info "---> Install git contrib/completion scripts"
if [[ ! -d ~/.gitcontrib ]]; then    
    curl -L --create-dirs -o ~/.gitcontrib/git-completion.zsh \
         "https://raw.github.com/git/git/master/contrib/completion/git-completion.zsh"
    curl -L --create-dirs -o ~/.gitcontrib/git-prompt.sh \
         "https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh"
fi

info "---> Enable dotfile, make symbolic link to '${HOME}' directory"
rake setup

# Tmux plugins
if [[ ! -d  ~/.tmux/plugins/tpm ]]; then
    info "Install tmux-plugin manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# go tools
info "Install go tools"
./go/gets.sh
