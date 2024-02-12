function _peco-k8s-describe-pod {
    local selected=$(kubectl get pods | peco --query "$LBUFFER" | cut -d ' ' -f 1)
    if [ -n "$selected" ]; then
        print -s "kubectl describe pod ${selected}"
        kubectl describe pod ${selected}
    fi
}