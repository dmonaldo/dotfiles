Create a GitHub pull request for the current branch.

## Instructions

1. Run `git status` to check current branch and uncommitted changes
2. Run `git log main..HEAD --oneline` to see commits to include in PR
3. Run `git diff main...HEAD --stat` to see files changed
4. Check if branch is pushed to remote

## PR Title Format

Use conventional commit format for the PR title:
- `feat(TICKET): description` - new feature
- `fix(TICKET): description` - bug fix
- `chore: description` - maintenance tasks
- `refactor: description` - code restructuring

Extract ticket number from branch name if present (e.g., `SLA-1234`).

## PR Description Format

Follow the repository's PR template if available. Otherwise use:

```markdown
## Summary
- Brief description of changes
- Key points about the implementation

## Test plan
- [ ] How to test the changes
- [ ] What to verify
```

## Rules

- Always push to remote before creating PR if not already pushed
- Use `gh pr create` command with `--title` and `--body` flags
- Target the `main` branch by default
- If there are uncommitted changes, ask user if they want to commit first
- Include ticket reference in title when available from branch name

## Process

1. Verify branch is ready (no uncommitted changes, pushed to remote)
2. Analyze commits to understand scope of changes
3. Craft descriptive title with ticket reference
4. Write summary covering what and why
5. Create PR using `gh pr create`
6. Return the PR URL to the user
