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

is_empty() {
    local var=$1

    [[ -z $var ]]
}

is_not_empty() {
    local var=$1

    [[ -n $var ]]
}

is_file() {
    local file=$1

    [[ -f $file ]]
}

is_not_file() {
    local file=$1

    [[ ! -f $file ]]
}


is_dir() {
    local dir=$1

    [[ -d $dir ]]
}

is_not_dir() {
    local dir=$1

    [[ ! -d $dir ]]
}

info "Install Homebrew Packages"
./homebrew/install.sh

info "Install Emacs cask"
pushd emacs.d
cask install
popd

info "Enable dotfile, make symbolic link to '${HOME}' directory"
rake setup


# ZSH plugins
is_not_dir ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
       && info "Install zsh-syntax-highlighting" \
       && pushd ~/.oh-my-zsh/custom/plugins \
       && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
       && popd

# oh-my-zsh-theme
is_not_file  ~/.oh-my-zsh/themes/beer.zsh-theme \
    && curl -fsSL https://raw.github.com/tcnksm/oh-my-zsh-beer-theme/master/beer.zsh-theme >> ~/.oh-my-zsh/themes/beer.zsh-theme

# Tmux plugins
is_not_dir ~/.tmux/plugins/tpm \
    && info "Install tmux-plugin manager" \
    && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
