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

info "Install Homebrew Packages"
./homebrew/install.sh

info "Install Emacs cask"
pushd emacs.d && cask install && popd

info "Enable dotfile, make symbolic link to '${HOME}' directory"
rake setup

# zsh tools
info "Install zsh tools"
./zsh/install-tools.sh

# Tmux plugins
if [[ ! -d  ~/.tmux/plugins/tpm ]]; then
    info "Install tmux-plugin manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# go tools
./go/get.sh
