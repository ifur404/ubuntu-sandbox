#!/bin/bash

# Gemini CLI Quick Prompt - Non-interactive mode
# Usage: ./prompt.sh "buatkan cerita pendek"
# Usage with image: ./prompt.sh "describe this" -f /path/to/image.jpg

export PATH="/root/sandbox/.npm-global/bin:$PATH"

# Check if gemini CLI is installed
if ! command -v gemini &> /dev/null; then
    echo "Error: gemini CLI not found. Install with: npm install -g @google/gemini-cli" >&2
    exit 1
fi

# Parse arguments
PROMPT=""
IMAGE=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -f|--file)
            IMAGE="$2"
            shift 2
            ;;
        *)
            # Collect all non-flag arguments as prompt
            if [ -z "$PROMPT" ]; then
                PROMPT="$1"
            else
                PROMPT="$PROMPT $1"
            fi
            shift
            ;;
    esac
done

if [ -z "$PROMPT" ]; then
    echo "Usage: $0 \"prompt text\" [-f image_path]" >&2
    exit 1
fi

# Run gemini with positional prompt, yolo mode, text output
if [ -n "$IMAGE" ]; then
    if [ ! -f "$IMAGE" ]; then
        echo "Error: Image file not found: $IMAGE" >&2
        exit 1
    fi
    gemini --yolo --output-format text "$PROMPT" -f "$IMAGE"
else
    gemini --yolo --output-format text "$PROMPT"
fi
