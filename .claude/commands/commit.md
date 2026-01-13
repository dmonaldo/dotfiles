Create a git commit using conventional commit format.

## Instructions

1. Run `git status` to see staged and unstaged changes
2. Run `git diff --cached` to see what's staged (if anything is staged)
3. Run `git diff` to see unstaged changes (if nothing is staged)
4. Run `git log --oneline -5` to see recent commit style

## Commit Message Format

Use concise conventional commit format:
- `feat(TICKET): description` - new feature
- `fix(TICKET): description` - bug fix
- `chore: description` - maintenance tasks
- `refactor: description` - code restructuring
- `docs: description` - documentation only
- `test: description` - adding/updating tests
- `style: description` - formatting, no code change
- `perf: description` - performance improvement

## Rules

- Include ticket reference (e.g., SLA-1234) in scope when available from branch name or context
- Keep subject line under 72 characters
- Use imperative mood ("add" not "added")
- Do NOT include "Generated with Claude Code" or similar footers
- Do NOT include Co-Authored-By lines
- If nothing is staged, ask the user what to stage or stage all relevant changes

## Process

1. Analyze the changes to understand what was modified
2. Determine the appropriate commit type
3. Extract ticket number from branch name if present
4. Write a clear, concise commit message
5. Execute the commit
