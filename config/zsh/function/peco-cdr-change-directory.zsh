autoload -U chpwd_recent_dirs cdr
function _peco-cdr-change-directory () {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | peco)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-cdr-change-directory _peco-cdr-change-directory
