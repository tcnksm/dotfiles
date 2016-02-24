#!/bin/bash

set -e

PKGS=(
    # General usage
    github.com/motemen/ghq

    # Go cmd
    golang.org/x/tools/cmd/godoc
    golang.org/x/tools/cmd/vet
    golang.org/x/tools/cmd/goimports
    golang.org/x/tools/cmd/benchcmp
    golang.org/x/tools/cmd/present

    # Golang dev
    github.com/k0kubun/pp
    github.com/tools/godep
    github.com/motemen/gore
    github.com/tcnksm/ghr
    github.com/tcnksm/gotests
)

for pkg in ${PKGS[@]}
do
    go get -v $pkg
done
