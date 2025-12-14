#!/bin/bash

# Codex CLI Quick Prompt - Non-interactive mode
# Usage: ./prompt.sh "explain this code"

export PATH="/root/sandbox/.npm-global/bin:$PATH"

# Check if codex CLI is installed
if ! command -v codex &> /dev/null; then
    echo "Error: codex CLI not found. Install with: npm install -g @openai/codex" >&2
    exit 1
fi

# Get prompt from arguments
PROMPT="$*"

if [ -z "$PROMPT" ]; then
    echo "Usage: $0 \"prompt text\"" >&2
    exit 1
fi

# Run codex exec for non-interactive one-shot mode
codex exec "$PROMPT"
