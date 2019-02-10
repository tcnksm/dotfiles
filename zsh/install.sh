DIR=$(cd $(dirname ${0}) && pwd)

if [ ! -f ${HOME}/.zshrc ]; then
  echo "[INFO] Place zshrc"
  ln -s ${DIR}/zshrc ${HOME}/.zshrc
fi

if [ ! -f ${HOME}/.config/peco/config.json ]; then
  echo "[INFO] Place peco configuration"
  mkdir -p $HOME/.config/peco
  ln -s ${DIR}/peco-config.json ${HOME}/.config/peco/config.json
fi