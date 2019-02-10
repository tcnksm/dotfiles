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
echo "[IFO] Installing fomula"
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
)
brew install ${formula[@]} && brew cleanup

# https://github.com/Homebrew/homebrew-cask
echo "[Install] Installing casks"
casks=(
     google-cloud-sdk
     visual-studio-code
)
brew cask install ${casks[@]} && brew cleanup
