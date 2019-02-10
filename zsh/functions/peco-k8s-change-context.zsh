function _peco-k8s-change-context() {
    local selected_ctx=$(kubectx | peco --query "$LBUFFER")
    if [ -n "$selected_ctx" ]; then
        BUFFER="kubectx ${selected_ctx}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-k8s-change-context _peco-k8s-change-context
