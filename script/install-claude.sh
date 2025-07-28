#!/bin/bash

DIR=$(cd $(dirname ${0})/.. && pwd)/config/

if [ ! -f ${HOME}/.claude/settings.json ]; then
  echo "[INFO] Place ${HOME}/.claude/settings.json"
  mkdir -p $HOME/.claude
  ln -sf ${DIR}/claude/settings.json ${HOME}/.claude/settings.json
fi

if [ ! -d ${HOME}/.claude/commands ]; then
  echo "[INFO] Place ${HOME}/.claude/commands"
  ln -sfn ${DIR}/claude/commands ${HOME}/.claude/commands
fi

if [ ! -d ${HOME}/.claude/hooks ]; then
  echo "[INFO] Place ${HOME}/.claude/hooks"
  ln -sfn ${DIR}/claude/hooks ${HOME}/.claude/hooks
fi