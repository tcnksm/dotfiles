#!/bin/bash

# Install rbenv and plugins
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
git clone https://github.com/ianheggie/rbenv-binstubs.git ~/.rbenv/plugins/rbenv-binstubs

source ~/.zshrc

# Install ruby
ruby_versions="2.0.0-p353 2.1.0"
export CONFIGURE_OPTS="--with-readline-dir=/usr/local --with-openssl-dir=/usr/local"

for v in ${ruby_versions}
do
    rbenv install $v
done


