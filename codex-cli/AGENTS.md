# Agent Guidelines

## Directory Structure

```
/root/sandbox/
├── memory/           # Long-term memory storage
├── context/          # Current session context
├── output/           # Generated outputs (reports, files)
├── temp/             # Temporary files (auto-cleaned)
├── logs/             # Agent logs
└── data/             # Persistent data storage
```

## Memory Storage

### Long-term Memory

Save important facts, user preferences, and learned information:

```bash
/root/sandbox/memory/
├── facts.json        # Important facts
├── preferences.json  # User preferences
├── history.json      # Conversation summaries
└── knowledge/        # Topic-specific knowledge files
```

### Session Context

Current session temporary context:

```bash
/root/sandbox/context/
├── current.json      # Current task context
└── variables.json    # Session variables
```

## Output Files

Save generated content:

```bash
/root/sandbox/output/
├── reports/          # Generated reports
├── code/             # Generated code files
├── exports/          # Exported data
└── [timestamp]_[name].ext  # Use timestamp prefix
```

## File Naming

- Use lowercase with underscores: `my_file.txt`
- Include timestamps for outputs: `20241214_report.md`
- Use descriptive names: `user_preferences.json`

## Commands

| Action       | Location                 |
| ------------ | ------------------------ |
| Save memory  | `/root/sandbox/memory/`  |
| Save context | `/root/sandbox/context/` |
| Save output  | `/root/sandbox/output/`  |
| Temp files   | `/root/sandbox/temp/`    |
| Logs         | `/root/sandbox/logs/`    |

## Best Practices

1. Always check if directory exists before writing
2. Use JSON for structured data
3. Append to logs, don't overwrite
4. Clean temp files after use
5. Use descriptive filenames
