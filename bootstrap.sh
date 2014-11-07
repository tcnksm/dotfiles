#!/bin/bash

cd "$(dirname "$0")"

set -e

# Install homebrew packages
./homebrew/install.sh

# Install emacs cask
pushd emacs.d
cask install
popd

# Enable dotfile, make symbolic link to `$HOME` directory
rake setup

# Install tmux-plugin manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


