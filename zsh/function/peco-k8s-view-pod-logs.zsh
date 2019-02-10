function _peco-k8s-view-pod-logs {
    local selected=$(kubectl get pods | peco --query "$LBUFFER" | cut -d ' ' -f 1)
    if [ -n "$selected" ]; then
        print -s "kubectl logs -f ${selected}"
        kubectl logs -f ${selected}
    fi
}