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
)
brew install ${formula[@]} && brew cleanup

# https://github.com/Homebrew/homebrew-cask
echo "[INFO] Installing casks"
casks=(
     google-cloud-sdk
     visual-studio-code
     raycast
     warp
     notion
     grammarly-desktop
     cleanshot
     slack
     tailscale
     sunsama
)
brew install --cask ${casks[@]} && brew cleanup

