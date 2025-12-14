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
        -p|--prompt)
            PROMPT="$2"
            shift 2
            ;;
        *)
            # First non-flag argument is prompt
            if [ -z "$PROMPT" ]; then
                PROMPT="$1"
            fi
            shift
            ;;
    esac
done

if [ -z "$PROMPT" ]; then
    echo "Usage: $0 \"prompt text\" [-f image_path]" >&2
    echo "       $0 -p \"prompt text\" [-f image_path]" >&2
    exit 1
fi

# Build gemini command
CMD="gemini -p \"$PROMPT\""

# Add image if provided
if [ -n "$IMAGE" ]; then
    if [ ! -f "$IMAGE" ]; then
        echo "Error: Image file not found: $IMAGE" >&2
        exit 1
    fi
    CMD="$CMD -f \"$IMAGE\""
fi

# Run with auto-accept for dangerous actions (--yolo flag)
eval "$CMD --yolo --sandbox off"
