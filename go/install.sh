#!/bin/bash

GOVERSION=${1}
if [ -z "${GOVERSION}" ]; then
    GOVERSION=1.6
fi

if [ -d ${HOME}/.go/${GOVERSION} ]; then
    echo "${GOVERSION} is already installed"
    exit 1
fi

rm -fr ${GOHOME}/pkg

mkdir -p ${HOME}/.go/${GOVERSION}
curl https://storage.googleapis.com/golang/go${GOVERSION}.darwin-amd64.tar.gz \
    | tar xvzf - -C ${HOME}/.go/${GOVERSION}/ --strip-components=1


