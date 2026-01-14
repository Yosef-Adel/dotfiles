*git.txt*  Git Reference

==============================================================================
CONTENTS                                                         *git-contents*

1. Setup ................................. |git-setup|
2. Configuration ......................... |git-config|
3. Basic Commands ........................ |git-basic|
   3.1 git init .......................... |git-init|
   3.2 git clone ......................... |git-clone|
   3.3 git status ........................ |git-status|
   3.4 git add ........................... |git-add|
   3.5 git commit ........................ |git-commit|
   3.6 git push .......................... |git-push|
   3.7 git pull .......................... |git-pull|
4. Viewing Changes ....................... |git-view|
   4.1 git log ........................... |git-log|
   4.2 git show .......................... |git-show|
   4.3 git diff .......................... |git-diff|
   4.4 git blame ......................... |git-blame|
5. Branching ............................. |git-branch|
   5.1 git branch ........................ |git-branch-command|
   5.2 git checkout ...................... |git-checkout|
   5.3 git switch ........................ |git-switch|
   5.4 git merge ......................... |git-merge|
   5.5 git rebase ........................ |git-rebase|
6. Stashing .............................. |git-stash|
   6.1 git stash ......................... |git-stash-command|
   6.2 git stash pop ..................... |git-stash-pop|
   6.3 git stash list .................... |git-stash-list|
7. Undoing Changes ....................... |git-undo|
   7.1 git restore ....................... |git-restore|
   7.2 git reset ......................... |git-reset|
   7.3 git revert ........................ |git-revert|
   7.4 git clean ......................... |git-clean|
8. Remote ................................ |git-remote|
   8.1 git remote ........................ |git-remote-command|
   8.2 git fetch ......................... |git-fetch|
   8.3 git pull .......................... |git-pull-command|
   8.4 git push .......................... |git-push-command|
9. Tags .................................. |git-tag|
10. Advanced ............................. |git-advanced|
    10.1 git cherry-pick ................. |git-cherry-pick|
    10.2 git reflog ...................... |git-reflog|
    10.3 git bisect ...................... |git-bisect|
    10.4 git worktree .................... |git-worktree|
    10.5 git hooks ....................... |git-hooks|

==============================================================================
1. SETUP                                                            *git-setup*

Initialize Git configuration globally~
>
    git config --global user.name "Your Name"
    git config --global user.email "your.email@example.com"

    # Verify configuration
    git config --global user.name
    git config --list
<

==============================================================================
2. CONFIGURATION                                                   *git-config*

Configure Git behavior~

Set default branch name~
>
    git config --global init.defaultBranch main
<

Set default editor~
>
    git config --global core.editor vim
<

Set merge tool~
>
    git config --global merge.tool vimdiff
<

View all config~
>
    git config --list
<

View global config file~
>
    cat ~/.gitconfig
<

Set local repo config~                                *git-config-local*
>
    # Omit --global for repository-specific config
    git config user.name "Local Name"
<

==============================================================================
3. BASIC COMMANDS                                                   *git-basic*

------------------------------------------------------------------------------
3.1 GIT INIT                                                        *git-init*

Create new repository~
>
    git init                    # Create .git directory
    git init my-project         # Create directory and repo
    cd my-project
<

------------------------------------------------------------------------------
3.2 GIT CLONE                                                      *git-clone*

Clone existing repository~
>
    git clone https://github.com/user/repo.git
    git clone https://github.com/user/repo.git my-folder
<

Shallow clone~                                         *git-clone-shallow*
>
    git clone --depth 1 https://github.com/user/repo.git
<

Clone specific branch~                                *git-clone-branch*
>
    git clone --single-branch --branch main https://github.com/user/repo.git
<

------------------------------------------------------------------------------
3.3 GIT STATUS                                                    *git-status*

Show working tree status~
>
    git status                  # Full status
    git status -s              # Short format
    git status --porcelain     # Porcelain format (machine-readable)
<

------------------------------------------------------------------------------
3.4 GIT ADD                                                          *git-add*

Stage changes for commit~
>
    git add file.txt           # Stage specific file
    git add .                  # Stage all changes
    git add *.js               # Stage by pattern
    git add -p                 # Interactive patch (choose hunks)
    git add -i                 # Interactive staging
<

------------------------------------------------------------------------------
3.5 GIT COMMIT                                                    *git-commit*

Record staged changes~
>
    git commit -m "message"                          # Commit with message
    git commit -am "message"                         # Stage and commit tracked
    git commit --amend                               # Modify last commit
    git commit --amend --no-edit                     # Amend without changing msg
    git commit --allow-empty -m "Empty commit"       # Create empty commit
<

Note: --amend rewrites history; only use on unpushed commits.

------------------------------------------------------------------------------
3.6 GIT PUSH                                                        *git-push*

Upload commits to remote~
>
    git push                                 # Push current branch
    git push origin main                     # Push to specific branch
    git push -u origin main                  # Push and set upstream
    git push --all                           # Push all branches
    git push --tags                          # Push all tags
<

Delete remote branch~                                  *git-push-delete*
>
    git push origin :branch-name             # Delete remote branch
    git push origin --delete branch-name     # Delete remote branch (explicit)
<

------------------------------------------------------------------------------
3.7 GIT PULL                                                        *git-pull*

Fetch and merge remote changes~
>
    git pull                           # Fetch and merge
    git pull --rebase                  # Fetch and rebase instead of merge
    git pull origin main               # Pull specific branch
    git pull --ff-only                 # Only fast-forward merges
<

==============================================================================
4. VIEWING CHANGES                                                   *git-view*

------------------------------------------------------------------------------
4.1 GIT LOG                                                          *git-log*

View commit history~
>
    git log                                      # Show all commits
    git log -n 5                                 # Last 5 commits
    git log --oneline                            # One line per commit
    git log --oneline --graph --all --decorate   # Pretty graph
    git log -p                                   # Show diffs
    git log -p file.txt                          # Commits affecting file
<

Filter commits~                                        *git-log-filter*
>
    git log --author="name"                      # Commits by author
    git log --since="2 weeks ago"                # Commits since date
    git log --grep="search"                      # Search commit messages
    git log main..branch                         # Commits in branch not in main
<

------------------------------------------------------------------------------
4.2 GIT SHOW                                                        *git-show*

Show commit details~
>
    git show                           # Show HEAD commit
    git show abc123                    # Show specific commit
    git show abc123:file.txt           # Show file at commit
    git show --stat                    # Show stats only
    git show HEAD~2                    # Show ancestor commit
<

------------------------------------------------------------------------------
4.3 GIT DIFF                                                        *git-diff*

Show differences~
>
    git diff                           # Unstaged changes
    git diff --staged                  # Staged changes
    git diff main..branch              # Branch diff
    git diff abc123..def456            # Commit diff
    git diff file.txt                  # Changes in specific file
<

Diff options~                                          *git-diff-options*
>
    git diff --name-only               # Only filenames
    git diff --stat                    # Summary of changes
    git diff HEAD~2 HEAD               # Last 2 commits
<

------------------------------------------------------------------------------
4.4 GIT BLAME                                                      *git-blame*

Show who changed each line~
>
    git blame file.txt                 # Show author per line
    git blame -L 10,20 file.txt        # Specific line range
    git blame -e file.txt              # Show email addresses
    git blame --date=short file.txt    # Show dates
<

==============================================================================
5. BRANCHING                                                       *git-branch*

------------------------------------------------------------------------------
5.1 GIT BRANCH                                          *git-branch-command*

Manage branches~
>
    git branch                         # List local branches
    git branch -a                      # List all branches
    git branch -r                      # List remote branches
    git branch new-branch              # Create branch
    git branch -d branch-name          # Delete branch
    git branch -D branch-name          # Force delete
<

Branch operations~                                     *git-branch-ops*
>
    git branch -m old-name new-name    # Rename branch
    git branch -v                      # Show last commit per branch
    git branch --merged                # Show merged branches
    git branch --no-merged             # Show unmerged branches
<

------------------------------------------------------------------------------
5.2 GIT CHECKOUT                                                *git-checkout*

Switch branches or restore files~
>
    git checkout main                  # Switch branch
    git checkout -b new-branch         # Create and switch
    git checkout abc123                # Detached HEAD at commit
    git checkout file.txt              # Restore file from HEAD
    git checkout -- file.txt           # Discard changes in file
    git checkout HEAD~2                # Go back 2 commits
<

Note: git switch and git restore are modern alternatives to checkout.

------------------------------------------------------------------------------
5.3 GIT SWITCH                                                    *git-switch*

Switch branches (modern alternative to checkout)~
>
    git switch main                    # Switch branch
    git switch -c new-branch           # Create and switch
    git switch -                       # Switch to previous branch
    git switch --detach abc123         # Detached HEAD
<

------------------------------------------------------------------------------
5.4 GIT MERGE                                                      *git-merge*

Merge branches~
>
    git merge branch-name              # Merge into current branch
    git merge --no-ff branch-name      # Create merge commit
    git merge --squash branch-name     # Squash commits before merge
    git merge --abort                  # Cancel merge in progress
    git merge --strategy ours branch   # Prefer current branch on conflicts
<

------------------------------------------------------------------------------
5.5 GIT REBASE                                                    *git-rebase*

Reapply commits on top of another branch~
>
    git rebase main                    # Rebase current on main
    git rebase -i HEAD~3               # Interactive rebase last 3 commits
    git rebase --continue              # Continue after conflict resolution
    git rebase --abort                 # Cancel rebase
    git rebase --skip                  # Skip current commit in rebase
    git rebase --edit-todo             # Edit rebase todo list
<

Interactive rebase commands:                           *git-rebase-interactive*
  pick      Use commit
  reword    Edit commit message
  edit      Stop for amending
  squash    Combine with previous
  fixup     Like squash but discard message
  drop      Remove commit

==============================================================================
6. STASHING                                                         *git-stash*

------------------------------------------------------------------------------
6.1 GIT STASH                                            *git-stash-command*

Save changes without committing~
>
    git stash                          # Stash all changes
    git stash save "description"       # Stash with message
    git stash -u                       # Include untracked files
    git stash -k                       # Keep index staged
<

------------------------------------------------------------------------------
6.2 GIT STASH POP                                              *git-stash-pop*

Restore stashed changes~
>
    git stash pop                      # Apply latest stash and remove
    git stash pop stash@{n}            # Apply specific stash
    git stash apply                    # Apply latest stash (keep it)
    git stash apply stash@{n}          # Apply specific stash (keep it)
<

------------------------------------------------------------------------------
6.3 GIT STASH LIST                                            *git-stash-list*

View stashed changes~
>
    git stash list                     # Show all stashes
    git stash show                     # Show latest stash diff
    git stash show -p                  # Show latest stash full diff
    git stash show stash@{n}           # Show specific stash
    git stash drop stash@{n}           # Delete specific stash
    git stash clear                    # Delete all stashes
<

==============================================================================
7. UNDOING CHANGES                                                  *git-undo*

------------------------------------------------------------------------------
7.1 GIT RESTORE                                                  *git-restore*

Restore files (modern alternative to checkout)~
>
    git restore file.txt               # Restore from HEAD
    git restore --staged file.txt      # Unstage file
    git restore --source=abc123 file.txt  # Restore from commit
<

------------------------------------------------------------------------------
7.2 GIT RESET                                                      *git-reset*

Move HEAD and potentially discard changes~
>
    git reset file.txt                 # Unstage file
    git reset HEAD~1                   # Undo last commit (keep changes)
    git reset --soft HEAD~1            # Undo commit, keep staged
    git reset --mixed HEAD~1           # Undo commit, unstage changes
    git reset --hard HEAD~1            # Undo commit, discard changes
    git reset --hard origin/main       # Reset to remote state
    git reset abc123                   # Reset to specific commit
<

Reset modes:                                           *git-reset-modes*
  --soft      Move HEAD only (keep staging and working)
  --mixed     Move HEAD and reset staging (default)
  --hard      Move HEAD and reset staging and working

Warning: --hard discards all changes permanently!

------------------------------------------------------------------------------
7.3 GIT REVERT                                                    *git-revert*

Create new commit that undoes changes~
>
    git revert HEAD                    # Revert last commit
    git revert abc123                  # Revert specific commit
    git revert HEAD~2..HEAD            # Revert range of commits
    git revert -n HEAD                 # Revert without auto-commit
    git revert --abort                 # Cancel revert in progress
<

Note: Revert is safe for published history; it doesn't rewrite commits.

------------------------------------------------------------------------------
7.4 GIT CLEAN                                                      *git-clean*

Remove untracked files~
>
    git clean -n                       # Dry run (show what would be deleted)
    git clean -f                       # Delete untracked files
    git clean -fd                      # Delete untracked files and directories
    git clean -fX                      # Delete untracked ignored files
    git clean -fxd                     # Delete all untracked files and dirs
<

Warning: git clean permanently deletes files. Always use -n first!

==============================================================================
8. REMOTE                                                          *git-remote*

------------------------------------------------------------------------------
8.1 GIT REMOTE                                          *git-remote-command*

Manage remote repositories~
>
    git remote                         # List remotes
    git remote -v                      # List with URLs
    git remote add origin https://...  # Add remote
    git remote remove origin           # Remove remote
    git remote set-url origin https:// # Change remote URL
    git remote show origin             # Show remote details
    git remote rename origin upstream   # Rename remote
<

------------------------------------------------------------------------------
8.2 GIT FETCH                                                      *git-fetch*

Download objects from remote~
>
    git fetch                          # Fetch from all remotes
    git fetch origin                   # Fetch from specific remote
    git fetch --all                    # Fetch all remotes
    git fetch --prune                  # Remove deleted remote branches
    git fetch origin branch-name       # Fetch specific branch
<

Note: Fetch downloads changes but doesn't merge them. Use pull to fetch and
merge in one step.

------------------------------------------------------------------------------
8.3 GIT PULL                                              *git-pull-command*

Fetch and merge/rebase~
>
    git pull                           # Fetch and merge
    git pull --rebase                  # Fetch and rebase
    git pull origin main               # Pull specific branch
    git pull --ff-only                 # Only accept fast-forward
<

------------------------------------------------------------------------------
8.4 GIT PUSH                                              *git-push-command*

Upload objects to remote~
>
    git push                           # Push to default remote/branch
    git push origin main               # Push specific branch
    git push -u origin main            # Push and track upstream
    git push --all                     # Push all branches
    git push --tags                    # Push all tags
    git push origin --delete branch    # Delete remote branch
<

Force push~                                            *git-push-force*
>
    git push --force                   # Force push (be careful!)
    git push --force-with-lease        # Safer force push
<

Warning: Force push rewrites remote history. Use with extreme caution!

==============================================================================
9. TAGS                                                               *git-tag*

Manage version tags~
>
    git tag                            # List tags
    git tag v1.0.0                     # Create lightweight tag
    git tag -a v1.0.0 -m "message"     # Create annotated tag
    git show v1.0.0                    # Show tag
    git tag -d v1.0.0                  # Delete local tag
<

Push tags~                                             *git-tag-push*
>
    git push origin v1.0.0             # Push specific tag
    git push origin --tags             # Push all tags
    git push origin :refs/tags/v1.0.0  # Delete remote tag
<

List tags by pattern~                                  *git-tag-list*
>
    git tag -l "v1.*"                  # List tags matching pattern
<

Note: Annotated tags (-a) are recommended for releases; they include tagger
info and message.

==============================================================================
10. ADVANCED                                                    *git-advanced*

------------------------------------------------------------------------------
10.1 GIT CHERRY-PICK                                          *git-cherry-pick*

Apply specific commits~
>
    git cherry-pick abc123             # Apply commit
    git cherry-pick abc123..def456     # Apply range
    git cherry-pick --continue         # Continue after conflict
    git cherry-pick --abort            # Cancel cherry-pick
    git cherry-pick -n abc123          # Apply without committing
<

------------------------------------------------------------------------------
10.2 GIT REFLOG                                                  *git-reflog*

Show reference history~
>
    git reflog                         # Show HEAD history
    git reflog show branch-name        # Show branch history
    git checkout abc123                # Recover lost commits
<

Note: Reflog is local only and expires after 90 days. Use it to recover
commits from reset or rebase operations.

------------------------------------------------------------------------------
10.3 GIT BISECT                                                  *git-bisect*

Find commit that introduced bug~
>
    git bisect start                   # Start bisect session
    git bisect bad HEAD                # Mark current as bad
    git bisect good v1.0.0             # Mark known good commit
    git bisect bad                     # Current commit is bad
    git bisect good                    # Current commit is good
    git bisect reset                   # End bisect session
<

How bisect works:                                      *git-bisect-workflow*
1. Mark a bad commit (has the bug)
2. Mark a good commit (before the bug)
3. Git checks out middle commit
4. Test and mark as good or bad
5. Repeat until bug-introducing commit is found

------------------------------------------------------------------------------
10.4 GIT WORKTREE                                              *git-worktree*

Work on multiple branches simultaneously~
>
    git worktree list                  # List worktrees
    git worktree add ../path branch    # Create worktree
    git worktree remove ../path        # Delete worktree
    git worktree lock ../path          # Lock worktree
    git worktree unlock ../path        # Unlock worktree
<

Note: Worktrees allow you to have multiple working directories for the same
repository, each checked out to a different branch.

------------------------------------------------------------------------------
10.5 GIT HOOKS                                                    *git-hooks*

Git hooks for automation~

Create pre-commit hook:
>
    cat > .git/hooks/pre-commit << 'EOF'
    #!/bin/sh
    npm test
    EOF
    chmod +x .git/hooks/pre-commit
<

Common hooks:                                          *git-hooks-list*
  .git/hooks/pre-commit      Run before commit
  .git/hooks/commit-msg      Edit commit message
  .git/hooks/post-commit     Run after commit
  .git/hooks/pre-push        Run before push
  .git/hooks/post-checkout   Run after checkout
  .git/hooks/pre-rebase      Run before rebase

Note: Hooks are local to repository. Use tools like husky for shared hooks.

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
