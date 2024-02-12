#!/bin/bash

set -e

PKGS=(
    # General
    github.com/x-motemen/ghq@latest

    # Go development
    # github.com/davidrjenni/reftools/cmd/fillstruct
    # github.com/mdempsky/gocode
    # golang.org/x/tools/gopls
    # golang.org/x/tools/cmd/goimports
    # golang.org/x/tools/cmd/gorename
    # golang.org/x/tools/cmd/benchcmp
    # golang.org/x/tools/cmd/present
    # golang.org/x/tools/cmd/guru
)

for pkg in ${PKGS[@]}
do
    go install -v $pkg
done
