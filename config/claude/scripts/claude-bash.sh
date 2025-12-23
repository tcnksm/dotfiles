#!/bin/bash

# Original source: https://gist.github.com/ThariqS/45c2d4c02a854137acd5fdc0f7fd9b4c

# Check if a request was provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <request>"
    echo "Example: $0 'can you help me stash the git ignore that I'm not using'"
    exit 1
fi

# Combine all arguments into a single request string
REQUEST="$*"

# Call Claude to get a bash command suggestion
echo "🤔 Asking Claude for a command suggestion..."
echo ""

# Use Claude to get the command, asking specifically for just the command
CLAUDE_OUTPUT=$(claude -p "The user wants to: $REQUEST
Please provide ONLY the bash command that would accomplish this task. Do not include any explanation, markdown formatting, or additional text.
Just output the raw command.")

# Extract the command (remove any leading/trailing whitespace)
SUGGESTED_CMD=$(echo "$CLAUDE_OUTPUT" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

# Check if we got a command
if [ -z "$SUGGESTED_CMD" ]; then
    echo "❌ Claude didn't provide a command suggestion."
    exit 1
fi

# Display the suggested command
echo "📋 Suggested command:"
echo ""
echo "  $SUGGESTED_CMD"
echo ""

# Copy the command to the clipboard
echo -n "$SUGGESTED_CMD" | pbcopy

# Print a success message
echo "✅ Command copied to clipboard."
echo "You can paste it into your terminal now."