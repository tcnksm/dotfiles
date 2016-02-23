#!/bin/bash

set -e

go get -u -v github.com/tcnksm/gotests

go get -u -v github.com/motemen/ghq
go get -u -v github.com/motemen/gore
go get -u -v github.com/k0kubun/pp

go get -u -v golang.org/x/tools/cmd/godoc
go get -u -v golang.org/x/tools/cmd/vet
go get -u -v golang.org/x/tools/cmd/goimports
go get -u -v golang.org/x/tools/cmd/benchcmp
go get -u -v golang.org/x/tools/cmd/present

