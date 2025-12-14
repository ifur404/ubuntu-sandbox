# Gemini CLI Tool

## Tool Name

gemini_prompt

## Command

```bash
./gemini-cli/prompt.sh "{prompt}"
```

## Description

Call this tool when the user mentions "gemini", "google ai", or asks for text generation, creative writing, or general AI assistance. Pass the user's request as the prompt parameter.

## Input

| Parameter | Type   | Required | Description                          |
| --------- | ------ | -------- | ------------------------------------ |
| prompt    | string | Yes      | The text prompt to send to Gemini AI |

## Examples

**User says:** "gemini, buatkan cerita pendek"
**Tool call:** `./gemini-cli/prompt.sh "buatkan cerita pendek"`

**User says:** "tanya gemini tentang cuaca"
**Tool call:** `./gemini-cli/prompt.sh "tentang cuaca"`
