DIR=$(cd $(dirname ${0})/.. && pwd)


CONFIGS=(
  zshrc
  gitconfig
  gitignore_global
  tmux.conf
)

for CONFIG in ${CONFIGS[@]}
do
  if [ ! -f ${HOME}/.${CONFIG} ]; then
    echo "[INFO] Place ${HOME}/.${CONFIG}"
    ln -s ${DIR}/${CONFIG} ${HOME}/.${CONFIG}
  fi  
done

if [ ! -f ${HOME}/.config/peco/config.json ]; then
  echo "[INFO] Place ${HOME}/.config/peco/config.json"
  mkdir -p $HOME/.config/peco
  ln -s ${DIR}/peco-config.json ${HOME}/.config/peco/config.json
fi