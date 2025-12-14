#!/bin/bash

# Gemini CLI Quick Prompt - Non-interactive mode
# Usage: ./prompt.sh "buatkan cerita pendek"

export PATH="/root/sandbox/.npm-global/bin:$PATH"

# Check if gemini CLI is installed
if ! command -v gemini &> /dev/null; then
    echo "Error: gemini CLI not found. Install with: npm install -g @google/gemini-cli" >&2
    exit 1
fi

# Get prompt from arguments
PROMPT="$*"

if [ -z "$PROMPT" ]; then
    echo "Usage: $0 \"prompt text\"" >&2
    exit 1
fi

# Run gemini with yolo mode and text output
gemini --yolo --output-format text "$PROMPT"
