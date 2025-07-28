#!/bin/bash

message=$(cat - | jq -r '.message')

if [ ! -z "$message" ]; then
    echo "$(date) - Send notification: ${message}" >> ~/.claude/log/hooks_notification.log
    terminal-notifier -title "🤖 Claude Code" -subtitle "Awaiting your input" -message "${message}"
fi