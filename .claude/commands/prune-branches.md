Clean up stale git branches that have been deleted on remote.

## Instructions

1. Run `git fetch --prune` to update remote tracking branches
2. Run `git branch -v` to list branches and identify `[gone]` status
3. Run `git worktree list` to check for associated worktrees

## Rules

- Only delete branches marked as `[gone]` (deleted on remote)
- Branches with a `+` prefix have associated worktrees that must be removed first
- Never delete the main worktree (the original repo directory)
- Always show which branches will be deleted before proceeding

## Process

1. Fetch and prune remote tracking branches:
   ```bash
   git fetch --prune
   ```

2. List branches to identify stale ones:
   ```bash
   git branch -v
   ```

3. If there are `[gone]` branches, remove them and their worktrees:
   ```bash
   git branch -v | grep '\[gone\]' | sed 's/^[+* ]//' | awk '{print $1}' | while read branch; do
     echo "Processing branch: $branch"
     # Find and remove worktree if it exists
     worktree=$(git worktree list | grep "\\[$branch\\]" | awk '{print $1}')
     if [ ! -z "$worktree" ] && [ "$worktree" != "$(git rev-parse --show-toplevel)" ]; then
       echo "  Removing worktree: $worktree"
       git worktree remove --force "$worktree"
     fi
     # Delete the branch
     git branch -D "$branch"
   done
   ```

4. Report results:
   - List branches and worktrees that were removed
   - If no `[gone]` branches found, report that no cleanup was needed
