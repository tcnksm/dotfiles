#!/bin/bash

set -e

PKGS=(
    # General
    github.com/motemen/ghq

    # Go development
    github.com/davidrjenni/reftools/cmd/fillstruct
    github.com/mdempsky/gocode
    golang.org/x/tools/gopls
    golang.org/x/tools/cmd/goimports
    golang.org/x/tools/cmd/gorename
    golang.org/x/tools/cmd/benchcmp
    golang.org/x/tools/cmd/present
    golang.org/x/tools/cmd/guru
)

for pkg in ${PKGS[@]}
do
    go get -u -v $pkg
done
