function _peco-k8s-change-namespace() {
    local selected_ctx=$(kubens | peco --query "$LBUFFER")
    if [ -n "$selected_ctx" ]; then
        BUFFER="kubens ${selected_ctx}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-k8s-change-namespace _peco-k8s-change-namespace
