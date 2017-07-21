# Change directory to the repo where fetched by peco
function peco-kubectx() {
    local selected_ctx=$(kubectx | peco --query "$LBUFFER")
    if [ -n "$selected_ctx" ]; then
        BUFFER="kubectx ${selected_ctx}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-kubectx
