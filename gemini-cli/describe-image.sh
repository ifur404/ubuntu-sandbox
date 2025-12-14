#!/bin/bash

# Gemini CLI Image Description
# Uses @google/gemini-cli
# Usage: 
#   ./describe-image.sh /path/to/image.jpg
#   ./describe-image.sh /path/to/image.jpg "Custom prompt here"
#   echo "BASE64_DATA" | ./describe-image.sh - "Describe this image"

set -e

# Check if gemini CLI is installed
if ! command -v gemini &> /dev/null; then
    echo "Error: gemini CLI not found. Install with: npm install -g @google/gemini-cli" >&2
    exit 1
fi

# Get image path (required)
IMAGE_PATH="$1"
PROMPT="${2:-Describe this image in detail. What do you see?}"

if [ -z "$IMAGE_PATH" ]; then
    echo "Error: Image path required" >&2
    echo "Usage: $0 <image_path> [prompt]" >&2
    echo "       echo 'base64' | $0 - [prompt]" >&2
    exit 1
fi

# Handle base64 input from stdin
if [ "$IMAGE_PATH" = "-" ]; then
    TEMP_IMAGE="/tmp/gemini_image_$$.jpg"
    base64 -d > "$TEMP_IMAGE"
    IMAGE_PATH="$TEMP_IMAGE"
    trap "rm -f $TEMP_IMAGE" EXIT
fi

# Check if file exists
if [ ! -f "$IMAGE_PATH" ]; then
    echo "Error: Image file not found: $IMAGE_PATH" >&2
    exit 1
fi

# Run gemini CLI with image
gemini -p "$PROMPT" -f "$IMAGE_PATH"
