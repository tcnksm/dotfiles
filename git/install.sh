DIR=$(cd $(dirname ${0}) && pwd)

if [ ! -f ${HOME}/.gitconfig ]; then
  echo "[INFO] Place gitconfig"
  ln -s ${DIR}/gitconfig ${HOME}/.gitconfig
fi

if [ ! -f ${HOME}/.gitignore_global ]; then
  echo "[INFO] Place global gitignore"
  ln -s ${DIR}/gitignore_global ${HOME}/.gitignore_global
fi