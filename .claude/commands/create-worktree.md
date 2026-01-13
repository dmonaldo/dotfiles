Create a git worktree for parallel development.

## Instructions

1. Run `git branch --show-current` to get the current branch
2. Run `git worktree list` to see existing worktrees
3. Run `basename $(git rev-parse --show-toplevel)` to get the repo name
4. Check if `.env` or `.env.local` exists in the main worktree

## Rules

- Create worktrees in a sibling directory named `<repo>-worktrees/<branch-name>`
- Always create a new branch for the worktree (never use existing branches that are checked out elsewhere)
- Copy all `.env*` files from the main worktree to the new worktree
- Handle port conflicts by suggesting the user modify PORT in the copied `.env` or `.env.local`
- Suggest incrementing port by 1 for each worktree

## Process

1. Determine the worktree location:
   - Main repo: `/path/to/<repo>`
   - Worktree: `/path/to/<repo>-worktrees/<branch-name>`

2. Create the worktree:
   ```bash
   # Get repo name
   REPO=$(basename $(git rev-parse --show-toplevel))

   # Create parent directory if needed
   mkdir -p ../${REPO}-worktrees

   # Create worktree with new branch
   git worktree add ../${REPO}-worktrees/<branch-name> -b <branch-name>
   ```

3. Copy environment files:
   ```bash
   cp .env* ../${REPO}-worktrees/<branch-name>/ 2>/dev/null || true
   ```

4. Handle port conflicts:
   - Check how many worktrees exist
   - Suggest updating PORT in the new worktree's `.env.local`:
     ```bash
     echo "PORT=XXXX" >> ../${REPO}-worktrees/<branch-name>/.env.local
     ```

5. Install dependencies (if needed):
   ```bash
   cd ../${REPO}-worktrees/<branch-name> && npm install
   ```

6. Return:
   - Path to the new worktree
   - Suggested port number
   - Command to start dev server: `cd <worktree-path> && npm run dev`

## Cleanup

To remove a worktree when done:
```bash
git worktree remove ../${REPO}-worktrees/<branch-name>
```

To list all worktrees:
```bash
git worktree list
```
