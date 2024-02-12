# Check for Homebrew installation and if not exist install 
if test ! $(which brew); then
    echo "[INFO] Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
    rmtrash       
    ag
    jq
    direnv
    peco   
    hugo
    terraform
    kubectx
    kube-ps1
    stern
    github/gh/gh
)
brew install ${formula[@]} && brew cleanup

# https://github.com/Homebrew/homebrew-cask
echo "[INFO] Installing casks"
casks=(
     google-cloud-sdk
     visual-studio-code
     raycast
)
brew cask install ${casks[@]} && brew cleanup

