# Git Reference

Quick reference for Git. Use `/` to search in vim.

## Table of Contents

- [Setup](#setup)
- [Configuration](#configuration)
- [Basic Commands](#basic-commands)
  - [init](#init)
  - [clone](#clone)
  - [status](#status)
  - [add](#add)
  - [commit](#commit)
  - [push](#push)
  - [pull](#pull)
- [Viewing Changes](#viewing-changes)
  - [log](#log)
  - [show](#show)
  - [diff](#diff)
  - [blame](#blame)
- [Branching](#branching)
  - [branch](#branch)
  - [checkout](#checkout)
  - [switch](#switch)
  - [merge](#merge)
  - [rebase](#rebase)
- [Stashing](#stashing)
  - [stash](#stash)
  - [stash pop](#stash-pop)
  - [stash list](#stash-list)
- [Undoing Changes](#undoing-changes)
  - [restore](#restore)
  - [reset](#reset)
  - [revert](#revert)
  - [clean](#clean)
- [Remote](#remote)
  - [remote](#remote-1)
  - [fetch](#fetch)
  - [pull](#pull-1)
  - [push](#push-1)
- [Tags](#tags)
  - [tag](#tag)
- [Advanced](#advanced)
  - [cherry-pick](#cherry-pick)
  - [reflog](#reflog)
  - [bisect](#bisect)
  - [worktree](#worktree)
  - [hooks](#hooks)

## Setup

Initialize Git configuration globally.

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify configuration
git config --global user.name
git config --list
```

## Configuration

Configure Git behavior.

```bash
# Set default branch name
git config --global init.defaultBranch main

# Set default editor
git config --global core.editor vim

# Set merge tool
git config --global merge.tool vimdiff

# View all config
git config --list

# View global config file
cat ~/.gitconfig

# Set local repo config (omit --global)
git config user.name "Local Name"
```

## Basic Commands

### init

Create new repository.

```bash
git init                    # Create .git directory
git init my-project         # Create directory and repo
cd my-project
```

### clone

Clone existing repository.

```bash
git clone https://github.com/user/repo.git
git clone https://github.com/user/repo.git my-folder
git clone --depth 1 https://github.com/user/repo.git  # Shallow clone
git clone --single-branch --branch main https://github.com/user/repo.git
```

### status

Show working tree status.

```bash
git status                  # Full status
git status -s              # Short format
git status --porcelain     # Porcelain format (machine-readable)
```

### add

Stage changes for commit.

```bash
git add file.txt           # Stage specific file
git add .                  # Stage all changes
git add *.js               # Stage by pattern
git add -p                 # Interactive patch (choose hunks)
git add -i                 # Interactive staging
```

### commit

Record staged changes.

```bash
git commit -m "message"                          # Commit with message
git commit -am "message"                         # Stage and commit tracked files
git commit --amend                               # Modify last commit
git commit --amend --no-edit                     # Amend without changing message
git commit --allow-empty -m "Empty commit"       # Create empty commit
```

### push

Upload commits to remote.

```bash
git push                                 # Push current branch
git push origin main                     # Push to specific branch
git push -u origin main                  # Push and set upstream
git push --all                           # Push all branches
git push --tags                          # Push all tags
git push origin :branch-name             # Delete remote branch
git push origin --delete branch-name     # Delete remote branch (explicit)
```

### pull

Fetch and merge remote changes.

```bash
git pull                           # Fetch and merge
git pull --rebase                  # Fetch and rebase instead of merge
git pull origin main               # Pull specific branch
git pull --ff-only                 # Only fast-forward merges
```

## Viewing Changes

### log

View commit history.

```bash
git log                                      # Show all commits
git log -n 5                                 # Last 5 commits
git log --oneline                            # One line per commit
git log --oneline --graph --all --decorate   # Pretty graph
git log -p                                   # Show diffs
git log -p file.txt                          # Commits affecting file
git log --author="name"                      # Commits by author
git log --since="2 weeks ago"                # Commits since date
git log --grep="search"                      # Search commit messages
git log main..branch                         # Commits in branch not in main
```

### show

Show commit details.

```bash
git show                           # Show HEAD commit
git show abc123                    # Show specific commit
git show abc123:file.txt           # Show file at commit
git show --stat                    # Show stats only
git show HEAD~2                    # Show ancestor commit
```

### diff

Show differences.

```bash
git diff                           # Unstaged changes
git diff --staged                  # Staged changes
git diff main..branch              # Branch diff
git diff abc123..def456            # Commit diff
git diff file.txt                  # Changes in specific file
git diff --name-only               # Only filenames
git diff --stat                    # Summary of changes
git diff HEAD~2 HEAD               # Last 2 commits
```

### blame

Show who changed each line.

```bash
git blame file.txt                 # Show author per line
git blame -L 10,20 file.txt        # Specific line range
git blame -e file.txt              # Show email addresses
git blame --date=short file.txt    # Show dates
```

## Branching

### branch

Manage branches.

```bash
git branch                         # List local branches
git branch -a                      # List all branches
git branch -r                      # List remote branches
git branch new-branch              # Create branch
git branch -d branch-name          # Delete branch
git branch -D branch-name          # Force delete
git branch -m old-name new-name    # Rename branch
git branch -v                      # Show last commit per branch
git branch --merged                # Show merged branches
git branch --no-merged             # Show unmerged branches
```

### checkout

Switch branches or restore files.

```bash
git checkout main                  # Switch branch
git checkout -b new-branch         # Create and switch
git checkout abc123                # Detached HEAD at commit
git checkout file.txt              # Restore file from HEAD
git checkout -- file.txt           # Discard changes in file
git checkout HEAD~2                # Go back 2 commits
```

### switch

Switch branches (modern alternative to checkout).

```bash
git switch main                    # Switch branch
git switch -c new-branch           # Create and switch
git switch -                       # Switch to previous branch
git switch --detach abc123         # Detached HEAD
```

### merge

Merge branches.

```bash
git merge branch-name              # Merge into current branch
git merge --no-ff branch-name      # Create merge commit
git merge --squash branch-name     # Squash commits before merge
git merge --abort                  # Cancel merge in progress
git merge --strategy ours branch   # Prefer current branch on conflicts
```

### rebase

Reapply commits on top of another branch.

```bash
git rebase main                    # Rebase current on main
git rebase -i HEAD~3               # Interactive rebase last 3 commits
git rebase --continue              # Continue after conflict resolution
git rebase --abort                 # Cancel rebase
git rebase --skip                  # Skip current commit in rebase
git rebase --edit-todo             # Edit rebase todo list
```

## Stashing

### stash

Save changes without committing.

```bash
git stash                          # Stash all changes
git stash save "description"       # Stash with message
git stash -u                       # Include untracked files
git stash -k                       # Keep index staged
```

### stash pop

Restore stashed changes.

```bash
git stash pop                      # Apply latest stash and remove
git stash pop stash@{n}            # Apply specific stash
git stash apply                    # Apply latest stash (keep it)
git stash apply stash@{n}          # Apply specific stash (keep it)
```

### stash list

View stashed changes.

```bash
git stash list                     # Show all stashes
git stash show                     # Show latest stash diff
git stash show -p                  # Show latest stash full diff
git stash show stash@{n}           # Show specific stash
git stash drop stash@{n}           # Delete specific stash
git stash clear                    # Delete all stashes
```

## Undoing Changes

### restore

Restore files (modern alternative to checkout).

```bash
git restore file.txt               # Restore from HEAD
git restore --staged file.txt      # Unstage file
git restore --source=abc123 file.txt  # Restore from commit
```

### reset

Move HEAD and potentially discard changes.

```bash
git reset file.txt                 # Unstage file
git reset HEAD~1                   # Undo last commit (keep changes)
git reset --soft HEAD~1            # Undo commit, keep staged
git reset --mixed HEAD~1           # Undo commit, unstage changes
git reset --hard HEAD~1            # Undo commit, discard changes
git reset --hard origin/main       # Reset to remote state
git reset abc123                   # Reset to specific commit
```

### revert

Create new commit that undoes changes.

```bash
git revert HEAD                    # Revert last commit
git revert abc123                  # Revert specific commit
git revert HEAD~2..HEAD            # Revert range of commits
git revert -n HEAD                 # Revert without auto-commit
git revert --abort                 # Cancel revert in progress
```

### clean

Remove untracked files.

```bash
git clean -n                       # Dry run (show what would be deleted)
git clean -f                       # Delete untracked files
git clean -fd                      # Delete untracked files and directories
git clean -fX                      # Delete untracked ignored files
git clean -fxd                     # Delete all untracked files and dirs
```

## Remote

### remote

Manage remote repositories.

```bash
git remote                         # List remotes
git remote -v                      # List with URLs
git remote add origin https://...  # Add remote
git remote remove origin           # Remove remote
git remote set-url origin https:// # Change remote URL
git remote show origin             # Show remote details
git remote rename origin upstream   # Rename remote
```

### fetch

Download objects from remote.

```bash
git fetch                          # Fetch from all remotes
git fetch origin                   # Fetch from specific remote
git fetch --all                    # Fetch all remotes
git fetch --prune                  # Remove deleted remote branches
git fetch origin branch-name       # Fetch specific branch
```

### pull

Fetch and merge/rebase.

```bash
git pull                           # Fetch and merge
git pull --rebase                  # Fetch and rebase
git pull origin main               # Pull specific branch
git pull --ff-only                 # Only accept fast-forward
```

### push

Upload objects to remote.

```bash
git push                           # Push to default remote/branch
git push origin main               # Push specific branch
git push -u origin main            # Push and track upstream
git push --all                     # Push all branches
git push --tags                    # Push all tags
git push origin --delete branch    # Delete remote branch
git push --force                   # Force push (be careful!)
git push --force-with-lease        # Safer force push
```

## Tags

### tag

Manage version tags.

```bash
git tag                            # List tags
git tag v1.0.0                     # Create lightweight tag
git tag -a v1.0.0 -m "message"     # Create annotated tag
git show v1.0.0                    # Show tag
git tag -d v1.0.0                  # Delete local tag
git push origin v1.0.0             # Push specific tag
git push origin --tags             # Push all tags
git push origin :refs/tags/v1.0.0  # Delete remote tag
git tag -l "v1.*"                  # List tags matching pattern
```

## Advanced

### cherry-pick

Apply specific commits.

```bash
git cherry-pick abc123             # Apply commit
git cherry-pick abc123..def456     # Apply range
git cherry-pick --continue         # Continue after conflict
git cherry-pick --abort            # Cancel cherry-pick
git cherry-pick -n abc123          # Apply without committing
```

### reflog

Show reference history.

```bash
git reflog                         # Show HEAD history
git reflog show branch-name        # Show branch history
git checkout abc123                # Recover lost commits
```

### bisect

Find commit that introduced bug.

```bash
git bisect start                   # Start bisect session
git bisect bad HEAD                # Mark current as bad
git bisect good v1.0.0             # Mark known good commit
git bisect bad                     # Current commit is bad
git bisect good                    # Current commit is good
git bisect reset                   # End bisect session
```

### worktree

Work on multiple branches simultaneously.

```bash
git worktree list                  # List worktrees
git worktree add ../path branch    # Create worktree
git worktree remove ../path        # Delete worktree
git worktree lock ../path          # Lock worktree
git worktree unlock ../path        # Unlock worktree
```

### hooks

Git hooks for automation.

```bash
# Create pre-commit hook
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/sh
npm test
EOF
chmod +x .git/hooks/pre-commit

# Common hooks:
# .git/hooks/pre-commit      - before commit
# .git/hooks/commit-msg      - edit commit message
# .git/hooks/post-commit     - after commit
# .git/hooks/pre-push        - before push
# .git/hooks/post-checkout   - after checkout
```
