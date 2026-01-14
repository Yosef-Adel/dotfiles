*git-hooks.txt*  Git Hooks Reference

==============================================================================
CONTENTS                                                  *git-hooks-contents*

1. Overview .............................. |git-hooks-overview|
2. Client-Side Hooks ..................... |git-hooks-client|
3. Server-Side Hooks ..................... |git-hooks-server|
4. pre-commit ............................ |git-hooks-pre-commit|
5. commit-msg ............................ |git-hooks-commit-msg|
6. pre-push .............................. |git-hooks-pre-push|
7. prepare-commit-msg .................... |git-hooks-prepare-commit-msg|
8. post-commit ........................... |git-hooks-post-commit|
9. post-checkout ......................... |git-hooks-post-checkout|
10. post-merge ........................... |git-hooks-post-merge|
11. Using Husky .......................... |git-hooks-husky|
12. Using lint-staged .................... |git-hooks-lint-staged|
13. Bypassing Hooks ...................... |git-hooks-bypass|
14. Sharing Hooks ........................ |git-hooks-sharing|
15. Common Patterns ...................... |git-hooks-patterns|
16. Examples by Language ................. |git-hooks-languages|

==============================================================================
1. OVERVIEW                                             *git-hooks-overview*

Git hooks are scripts that run automatically at specific points~
>
    Git hooks live in .git/hooks/ directory

    To enable a hook:
    1. Create file in .git/hooks/ (no extension)
    2. Make it executable: chmod +x .git/hooks/pre-commit
    3. Write your script (bash, python, node, etc.)

    Exit code 0 = success (continue)
    Exit code non-zero = failure (abort)
<

==============================================================================
2. CLIENT-SIDE HOOKS                                      *git-hooks-client*

Common client-side hooks~                           *git-hooks-client-list*
>
    pre-commit          Before commit is created
    prepare-commit-msg  Before commit message editor opens
    commit-msg          After commit message is entered
    post-commit         After commit is completed
    pre-rebase          Before rebase
    post-rewrite        After commands that rewrite commits
    post-checkout       After checkout
    post-merge          After merge
    pre-push            Before push
    pre-auto-gc         Before git gc runs
<

==============================================================================
3. SERVER-SIDE HOOKS                                      *git-hooks-server*

Common server-side hooks~                           *git-hooks-server-list*
>
    pre-receive         Before any refs are updated
    update              Once per branch being updated
    post-receive        After all refs are updated
    post-update         After all refs are updated (legacy)
<

==============================================================================
4. PRE-COMMIT                                         *git-hooks-pre-commit*

Runs before commit is created~                    *git-hooks-pre-commit-example*
>
    #!/bin/bash
    # .git/hooks/pre-commit

    # Prevent commits to main/master
    branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
    if [ "$branch" = "main" ] || [ "$branch" = "master" ]; then
      echo "Direct commits to main/master are not allowed"
      exit 1
    fi

    # Run linter
    echo "Running ESLint..."
    npm run lint
    if [ $? -ne 0 ]; then
      echo "Linting failed. Commit aborted."
      exit 1
    fi

    # Run tests
    echo "Running tests..."
    npm test
    if [ $? -ne 0 ]; then
      echo "Tests failed. Commit aborted."
      exit 1
    fi

    # Check for console.log
    if git diff --cached | grep -q "console.log"; then
      echo "Error: console.log found in staged files"
      echo "Please remove console.log statements before committing"
      exit 1
    fi

    # Check for TODO comments
    if git diff --cached | grep -q "TODO"; then
      echo "Warning: TODO found in staged files"
      read -p "Continue with commit? (y/n) " -n 1 -r
      echo
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
      fi
    fi

    # Prevent large files
    max_size=5242880  # 5MB
    for file in $(git diff --cached --name-only); do
      if [ -f "$file" ]; then
        size=$(wc -c < "$file")
        if [ $size -gt $max_size ]; then
          echo "Error: $file is larger than 5MB"
          exit 1
        fi
      fi
    done

    # Format code
    echo "Formatting code..."
    npm run format

    # Add formatted files back to staging
    git add -u

    exit 0
<

==============================================================================
5. COMMIT-MSG                                         *git-hooks-commit-msg*

Validates commit message~                       *git-hooks-commit-msg-example*
>
    #!/bin/bash
    # .git/hooks/commit-msg

    commit_msg_file=$1
    commit_msg=$(cat "$commit_msg_file")

    # Enforce conventional commits format
    # type(scope): subject
    # Example: feat(auth): add login endpoint
    pattern="^(feat|fix|docs|style|refactor|test|chore)(\([a-z]+\))?: .{10,}"

    if ! echo "$commit_msg" | grep -qE "$pattern"; then
      echo "Error: Commit message doesn't follow conventional commits format"
      echo "Format: type(scope): subject"
      echo "Types: feat, fix, docs, style, refactor, test, chore"
      echo "Example: feat(auth): add login endpoint"
      exit 1
    fi

    # Check message length
    first_line=$(echo "$commit_msg" | head -n 1)
    if [ ${#first_line} -gt 72 ]; then
      echo "Error: First line must be 72 characters or less"
      exit 1
    fi

    # Check for issue reference
    if ! echo "$commit_msg" | grep -qE "#[0-9]+"; then
      echo "Warning: No issue reference found (e.g., #123)"
      read -p "Continue without issue reference? (y/n) " -n 1 -r
      echo
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
      fi
    fi

    exit 0
<

==============================================================================
6. PRE-PUSH                                             *git-hooks-pre-push*

Runs before push~                                *git-hooks-pre-push-example*
>
    #!/bin/bash
    # .git/hooks/pre-push

    # Run tests before push
    echo "Running tests before push..."
    npm test
    if [ $? -ne 0 ]; then
      echo "Tests failed. Push aborted."
      exit 1
    fi

    # Check for WIP commits
    if git log @{u}.. --pretty=%s | grep -qi "wip\|work in progress\|tmp"; then
      echo "Error: WIP commits detected"
      echo "Please squash or remove WIP commits before pushing"
      exit 1
    fi

    # Prevent push to protected branches
    protected_branches="main master production"
    current_branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

    for branch in $protected_branches; do
      if [ "$current_branch" = "$branch" ]; then
        echo "Error: Direct push to $branch is not allowed"
        echo "Please create a pull request instead"
        exit 1
      fi
    done

    exit 0
<

==============================================================================
7. PREPARE-COMMIT-MSG                           *git-hooks-prepare-commit-msg*

Modifies commit message before editor opens~
                                           *git-hooks-prepare-commit-msg-example*
>
    #!/bin/bash
    # .git/hooks/prepare-commit-msg

    commit_msg_file=$1
    commit_source=$2

    # Auto-add branch name to commit message
    branch_name=$(git symbolic-ref --short HEAD)

    # Extract ticket number from branch name
    # Example: feature/ABC-123-add-login -> ABC-123
    ticket=$(echo "$branch_name" | grep -oE '[A-Z]+-[0-9]+')

    if [ -n "$ticket" ]; then
      # Prepend ticket number if not already present
      if ! grep -q "$ticket" "$commit_msg_file"; then
        echo "[$ticket] $(cat $commit_msg_file)" > "$commit_msg_file"
      fi
    fi

    # Add co-author if pair programming
    if [ "$commit_source" = "message" ]; then
      echo "" >> "$commit_msg_file"
      echo "Co-authored-by: Pair Programmer <pair@example.com>" >> "$commit_msg_file"
    fi
<

==============================================================================
8. POST-COMMIT                                       *git-hooks-post-commit*

Runs after commit is completed~                *git-hooks-post-commit-example*
>
    #!/bin/bash
    # .git/hooks/post-commit

    # Notify team
    commit_msg=$(git log -1 --pretty=%B)
    curl -X POST https://hooks.slack.com/services/YOUR/WEBHOOK/URL \
      -H 'Content-Type: application/json' \
      -d "{\"text\": \"New commit: $commit_msg\"}"

    # Update documentation
    npm run docs:build

    # Tag version if needed
    if echo "$commit_msg" | grep -q "RELEASE"; then
      git tag -a "v$(date +%Y%m%d-%H%M%S)" -m "Release: $commit_msg"
    fi
<

==============================================================================
9. POST-CHECKOUT                                   *git-hooks-post-checkout*

Runs after checkout~                          *git-hooks-post-checkout-example*
>
    #!/bin/bash
    # .git/hooks/post-checkout

    prev_head=$1
    new_head=$2
    branch_checkout=$3

    # Reinstall dependencies if package.json changed
    if [ "$branch_checkout" = "1" ]; then
      if git diff --name-only $prev_head $new_head | grep -q "package.json"; then
        echo "package.json changed. Running npm install..."
        npm install
      fi
    fi

    # Clear cache on branch switch
    if [ "$branch_checkout" = "1" ]; then
      rm -rf .cache
      echo "Cache cleared"
    fi
<

==============================================================================
10. POST-MERGE                                       *git-hooks-post-merge*

Runs after merge~                              *git-hooks-post-merge-example*
>
    #!/bin/bash
    # .git/hooks/post-merge

    # Update dependencies after merge
    if git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD | grep -q "package.json"; then
      echo "package.json changed. Running npm install..."
      npm install
    fi

    # Run database migrations
    if git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD | grep -q "migrations/"; then
      echo "Migrations detected. Running migrations..."
      npm run migrate
    fi
<

==============================================================================
11. USING HUSKY                                           *git-hooks-husky*

Husky simplifies git hooks management~               *git-hooks-husky-setup*
>
    # Install husky
    npm install --save-dev husky
    npx husky-init && npm install

    # Add pre-commit hook
    npx husky add .husky/pre-commit "npm test"

    # Add commit-msg hook
    npx husky add .husky/commit-msg 'npx --no -- commitlint --edit "$1"'

    # Add pre-push hook
    npx husky add .husky/pre-push "npm run build"
<

Package.json configuration~                       *git-hooks-husky-package*
>
    // package.json
    {
      "scripts": {
        "prepare": "husky install"
      },
      "devDependencies": {
        "husky": "^8.0.0"
      }
    }
<

==============================================================================
12. USING LINT-STAGED                               *git-hooks-lint-staged*

Run linters on staged files only~              *git-hooks-lint-staged-setup*
>
    # Install
    npm install --save-dev lint-staged
<

Package.json configuration~                   *git-hooks-lint-staged-config*
>
    // Add to package.json
    {
      "lint-staged": {
        "*.js": ["eslint --fix", "prettier --write"],
        "*.{json,md}": ["prettier --write"]
      }
    }
<

Husky hook~                                    *git-hooks-lint-staged-husky*
>
    # .husky/pre-commit
    #!/bin/sh
    npx lint-staged
<

==============================================================================
13. BYPASSING HOOKS                                     *git-hooks-bypass*

Skip hooks when needed~                             *git-hooks-bypass-commands*
>
    # Skip pre-commit hook
    git commit --no-verify
    git commit -n

    # Skip pre-push hook
    git push --no-verify
<

==============================================================================
14. SHARING HOOKS                                       *git-hooks-sharing*

Share hooks with your team~                         *git-hooks-sharing-setup*
>
    # Create hooks directory in repo
    mkdir -p .githooks

    # Add hooks there
    .githooks/pre-commit
    .githooks/commit-msg

    # Make them executable
    chmod +x .githooks/*

    # Configure git to use custom hooks directory
    git config core.hooksPath .githooks

    # Add to README or setup script
    echo "Run: git config core.hooksPath .githooks"
<

==============================================================================
15. COMMON PATTERNS                                     *git-hooks-patterns*

Common hook patterns~                            *git-hooks-patterns-common*
>
    # Run linter
    eslint .
    npm run lint

    # Run tests
    npm test
    npm run test:unit

    # Format code
    prettier --write .
    npm run format

    # Type check
    tsc --noEmit
    npm run type-check

    # Build
    npm run build

    # Check for secrets
    git diff --cached | grep -i "api_key\|secret\|password"

    # Spell check commit message
    aspell -a <<< "$commit_msg"

    # Validate JSON
    for file in $(git diff --cached --name-only | grep ".json$"); do
      jq empty "$file"
    done
<

==============================================================================
16. EXAMPLES BY LANGUAGE                             *git-hooks-languages*

Node.js~                                            *git-hooks-languages-node*
>
    #!/bin/bash
    npm run lint && npm test
<

Python~                                           *git-hooks-languages-python*
>
    #!/bin/bash
    flake8 . && pytest
<

Go~                                                   *git-hooks-languages-go*
>
    #!/bin/bash
    go fmt ./... && go test ./...
<

Rust~                                               *git-hooks-languages-rust*
>
    #!/bin/bash
    cargo fmt && cargo test
<

Ruby~                                               *git-hooks-languages-ruby*
>
    #!/bin/bash
    rubocop && rspec
<

PHP~                                                 *git-hooks-languages-php*
>
    #!/bin/bash
    ./vendor/bin/phpcs && ./vendor/bin/phpunit
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
