DIR=$(cd $(dirname ${0})/.. && pwd)/config/

HOME_CONFIGS=(
  zshrc
  gitconfig
  gitignore
  tmux.conf
)

for CONFIG in ${HOME_CONFIGS[@]}
do
  if [ ! -f ${HOME}/.${CONFIG} ]; then
    echo "[INFO] Place ${HOME}/.${CONFIG}"
    ln -sf ${DIR}/home/${CONFIG} ${HOME}/.${CONFIG}
  fi  
done

if [ ! -f ${HOME}/.config/peco/config.json ]; then
  echo "[INFO] Place ${HOME}/.config/peco/config.json"
  mkdir -p $HOME/.config/peco
  ln -sf ${DIR}/peco/config.json ${HOME}/.config/peco/config.json
fi

if [ ! -f ${HOME}/.config/ghostty/config ]; then
  echo "[INFO] Place ${HOME}/.config/ghostty/config"
  mkdir -p $HOME/.config/ghostty
  ln -sf ${DIR}/ghostty/config ${HOME}/.config/ghostty/config
fi


if [ ! -d ${HOME}/.emacs.d ]; then
  echo "[INFO] Place ${HOME}/.emacs.d"
  ln -sf ${DIR}/emacs.d ${HOME}/.emacs.d
fi

if [ ! -f ${HOME}/Library/Application\ Support/Cursor/User/settings.json ]; then
  echo "[INFO] Place settings on ${HOME}/Library/Application\ Support/Cursor/User"
  ln -sf ${DIR}/cursor/settings.json ${HOME}/Library/Application\ Support/Cursor/User/settings.json
  ln -sf ${DIR}/cursor/keybindings.json ${HOME}/Library/Application\ Support/Cursor/User/keybindings.json
fi

if [ ! -f ${HOME}/.gnupg/gpg-agent.conf ]; then  
  echo "[INFO] Place ${HOME}/.gnupg/gpg-agent.conf"
  echo "[INFO] Run 'gpgconf --kill gpg-agent' to reload the config"
  mkdir -p $HOME/.gnupg
  ln -sf ${DIR}/gnupg/gpg-agent.conf ${HOME}/.gnupg/gpg-agent.conf
fi

