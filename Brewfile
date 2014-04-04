# Make sure using latest Homebrew
update || true

# Update already-installed formula
upgrade || true

# Add Repository
tap homebrew/versions    || true
tap phinze/homebrew-cask || true
tap homebrew/binary      || true
tap thoughtbot/formulae  || true

# Packages

## Shell
install zsh   || true

## Editor
install emacs || true

## Git
install git   || true
install hub   || true
install gitsh || true
install gist  || true
install tig   || true
install gibo  || true

## Utils
install rmtrash   || true
install coreutils || true
install rmtrash   || true
install wget      || true
install curl      || true
install proctools || true
install tree      || true
install openssl   || true
install readline  || true
install tmux      || true
install markdown  || true
install nkf       || true
install ag        || true

## Languages
install rbenv            || true
install ruby-build       || true
install go               || true
install python3          || true
install haskell-platform || true
install scala            || true

## DevOps
install docker      || true
install boot2docker || true
install packer      || true

## Heroku
install heroku-toolbelt || true

## Image
install imagemagick || true

# Casks
install brew-cask
cask install google-chrome || true
cask install iterm2        || true
cask install dropbox       || true
cask install hipchat       || true
cask install yorufukurou   || true
cask install alfred        || true
cask install sourcetree    || true
cask install evernote      || true
cask install kobito        || true
cask install sublime-text  || true
cask install virtualbox    || true
cask install vagrant       || true
cask install slate         || true
cask install dash          || true
cask install Cyberduck     || true

# Remove outdated versions
cleanup
