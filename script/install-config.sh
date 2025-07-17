DIR=$(cd $(dirname ${0})/.. && pwd)/config/

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
    ln -sf ${DIR}/${CONFIG} ${HOME}/.${CONFIG}
  fi  
done

if [ ! -f ${HOME}/.config/peco/config.json ]; then
  echo "[INFO] Place ${HOME}/.config/peco/config.json"
  mkdir -p $HOME/.config/peco
  ln -sf ${DIR}/peco-config.json ${HOME}/.config/peco/config.json
fi

if [ ! -f ${HOME}/.claude/settings.json ]; then
  echo "[INFO] Place ${HOME}/.claude/settings.json"
  mkdir -p $HOME/.claude
  ln -sf ${DIR}/settings.json ${HOME}/.claude/settings.json
fi

