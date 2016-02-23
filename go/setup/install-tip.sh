#!/bin/bash

# rm -fr latest
# git clone --depth=1 https://go.googlesource.com/go latest
export GOROOT_BOOTSTRAP=$HOME/.go/1.5.1
cd latest/src && ./make.bash
