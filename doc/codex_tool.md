# Codex CLI Tool

## Tool Name

codex_prompt

## Command

```bash
./codex-cli/prompt.sh "{prompt}"
```

## Description

Call this tool when the user mentions "codex", "openai", or asks for code-related tasks like explaining code, writing code, debugging, or programming assistance. Pass the user's request as the prompt parameter.

## Input

| Parameter | Type   | Required | Description                         |
| --------- | ------ | -------- | ----------------------------------- |
| prompt    | string | Yes      | The text prompt to send to Codex AI |

## Examples

**User says:** "codex, explain this function"
**Tool call:** `./codex-cli/prompt.sh "explain this function"`

**User says:** "ask codex to write a sort algorithm"
**Tool call:** `./codex-cli/prompt.sh "write a sort algorithm"`
