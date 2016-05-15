#!/bin/bash

export GOROOT_BOOTSTRAP=$HOME/.go/${GOVERSION}
cd $HOME/.go/go && git pull && cd src && ./all.bash
