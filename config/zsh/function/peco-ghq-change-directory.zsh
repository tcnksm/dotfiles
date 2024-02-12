# Change directory to the repo where fetched by peco
function _peco-ghq-change-directory() {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-ghq-change-directory _peco-ghq-change-directory

