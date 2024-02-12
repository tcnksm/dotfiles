# ------------------------------------
# General
# ------------------------------------
fpath=(/usr/local/share/zsh/functions ${fpath})
for f (~/gopath/src/github.com/tcnksm/dotfiles/zsh/function/*.zsh) source "${f}"

# ------------------------------------
# Bind key
# ------------------------------------
bindkey -e

bindkey '^r' peco-select-command-history
bindkey '^j' peco-ghq-change-directory
bindkey '^h' peco-cdr-change-directory
bindkey '^b' peco-git-checkout-branch
bindkey '^x' peco-k8s-change-context
bindkey '^]' peco-k8s-change-namespace
bindkey '^m' enter-list-files

# ------------------------------------
# Completion
# ------------------------------------
autoload -U compinit && compinit

setopt AUTO_LIST
setopt LIST_PACKED

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:default' menu select=1

# ------------------------------------
# History
# ------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# Historical backward/forward search
# with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# ------------------------------------
# Hooks
# ------------------------------------
chpwd() {
    _ls-abbrev
    _show-git-status
}

# ------------------------------------
# Prompt
# ------------------------------------
# setopt PROMPT_SUBST
# setopt PROMPT_PERCENT
# setopt TRANSIENT_RPROMPT

# autoload -Uz vcs_info
# zstyle ':vcs_info:*' formats '[%b]'
# zstyle ':vcs_info:*' actionformats '[%b|%a]'
# precmd () { vcs_info }

# https://github.com/jonmosco/kube-ps1
# source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"

RPROMPT=''
# PROMPT='%~ %F{yello}${vcs_info_msg_0_}%f `kube_ps1`
PROMPT='> '

# ------------------------------------
# Options
# ------------------------------------

# Changing Directories
setopt AUTO_CD
setopt AUTO_PUSHD

# Input/Output
setopt CORRECT
setopt INTERACTIVE_COMMENTS

# ------------------------------------
# Environmental variables
# ------------------------------------
export PATH=$HOME/gopath/bin:$PATH
export PATH=~/.cask/bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export EDITOR='/usr/local/bin/emacs -nw'
export GOPATH=${HOME}/gopath
export PATH=$PATH:/usr/local/kubebuilder/bin

source $HOME/.cargo/env

# ------------------------------------
# Alias
# ------------------------------------
alias ls="ls -G"
alias rm='rmtrash'

alias git=hub
alias gs='git status'
alias gm='git checkout master'
alias gmm='git checkout main'
alias au='git add -u; git status'
alias o='git-open'
alias tt='tig'

alias kg="kubectl get"
alias kd="kubectl describe"
alias kdp=_peco-k8s-describe-pod
alias kl=_peco-k8s-view-pod-logs
alias kst=_peco-k8s-stern

alias gpc="gh pr create"

alias emacs='/usr/local/bin/emacs -nw'
alias e='/usr/local/bin/emacsclient -n'
alias v='/usr/local/bin/code -r'

alias tmux='tmux -2 -f ~/.tmux.conf'

alias sss='source ~/.zshrc'

# ------------------------------------
# Settings
# ------------------------------------
export GPG_TTY=$(tty)
eval "$(direnv hook zsh)"
source <(stern --completion=zsh)

