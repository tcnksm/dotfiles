function _peco-k8s-stern {
  local selected=$(kubectl get deployments,daemonsets,statefulset --no-headers | cut -d ' ' -f 1 | peco --query "$LBUFFER" | cut -d '/' -f 2)
  if [ -n "$selected" ]; then
    print -s "stern ${selected}" # resiter history
    stern ${selected}
  fi
}