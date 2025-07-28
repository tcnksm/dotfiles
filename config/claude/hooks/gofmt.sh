#!/bin/bash

file_path=$(cat - | jq -r '.tool_input.file_path | select(endswith(".go"))')

if [ -f "${file_path}" ]; then
    echo "$(date) - Executing gofmt & goimports: ${file_path}" >> ~/.claude/log/hooks_posttooluse.log
    gofmt -w "${file_path}"
    goimports -w "${file_path}"
fi
