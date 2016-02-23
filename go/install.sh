#!/bin/bash

GOVERSION=${1}
if [ -z "${GOVERSION}" ]; then
    GOVERSION=1.6
fi

if [ -d ${GOVERSION} ]; then
    echo "${GOVERSION} is already installed"
    exit 1
fi

mkdir ${GOVERSION}
curl https://storage.googleapis.com/golang/go${GOVERSION}.darwin-amd64.tar.gz \
    | tar xvzf - -C ${HOME}/.go/${GOVERSION}/ --strip-components=1


