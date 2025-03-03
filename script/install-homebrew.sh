#!/bin/bash

# Parse command line arguments
INSTALL_FORMULAS=true
INSTALL_CASKS=true

# If --cask is specified, only install casks
if [[ "$1" == "--cask" ]]; then
    INSTALL_FORMULAS=false
    INSTALL_CASKS=true
fi

# Check for Homebrew installation and if not exist install 
if test ! $(which brew); then
    echo "[INFO] Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

printf "Update recipes? [Y/n]: " && read ANS
if [ "${ANS}" = "Y" ]; then
    brew update
fi

printf "Upgrade? [Y/n]: " && read ANS
if [ "${ANS}" = "Y" ]; then
    brew upgrade
fi

if [ "$INSTALL_FORMULAS" = true ]; then
    # https://formulae.brew.sh/formula/
    echo "[INFO] Installing fomulas"
    formula=(
        coreutils
        findutils  
        proctools
        gnupg
        grep
        curl
        wget
        tree
        zsh
        bash
        tmux
        git   
        hub 
        tig
        emacs
        cask
        go
        imagemagick
        trash       
        ag
        jq
        direnv
        peco
        terraform
        kubectx
        kube-ps1
        stern
        gh
        aquaproj/aqua/aqua
        llm
    )
    brew install ${formula[@]} && brew cleanup
fi

if [ "$INSTALL_CASKS" = true ]; then
    # https://github.com/Homebrew/homebrew-cask
    echo "[INFO] Installing casks"
    casks=(
         google-cloud-sdk
         docker

         # Login with GitHub
         visual-studio-code
         visual-studio-code@insiders
         
         # Login with GitHub
         raycast
         iterm2
         # Login with GitHub
         warp
         # Login with Google
         notion
         # Login with Google
         grammarly-desktop
         # Login with API Token (in mail)
         cleanshot
         # Login with Google and mail
         slack
         # Login with Google
         tailscale
         # Login with Google
         sunsama     
    )

    brew install --cask ${casks[@]} && brew cleanup
fi
