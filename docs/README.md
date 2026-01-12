# Personal Dev Docs

Self-hosted, offline documentation system for web development. Like Vim's `:help` but for every tool you use.

## Philosophy

No external dependencies. No API calls that return wrong things. Complete control over accuracy and content. Everything you need is local, always available, and exactly how you want it documented.

## Usage

### Via Fuzzyfinder Script

```bash
tmux-cht.sh
# Search for tool → opens in vim → use `/` to search within doc
```

### Direct Access

```bash
# Open specific doc
vim ~/dotfiles/docs/typescript.md

# Search all docs
grep -r "useState" ~/dotfiles/docs/

# Use telescope in nvim
:Telescope find_files cwd=~/dotfiles/docs
```

## Available Docs (24+)

### Frontend Development

- `typescript.md` - Types, generics, interfaces, advanced patterns
- `javascript.md` - Array methods, promises, async/await, modern JS
- `react.md` - Hooks, patterns, performance, component design
- `html.md` - Semantic HTML, forms, accessibility
- `css.md` - Flexbox, Grid, animations, responsive design
- `npm.md` - Package management, scripts, publishing, dependencies
- `vite.md` - Bundler config, dev server, optimization, plugins

### Styling & Linting

- `eslint.md` - Linting rules, configuration, plugins
- `prettier.md` - Code formatting, integration with ESLint

### Testing & Quality

- `jest.md` - Testing framework, assertions, mocking, async patterns

### Backend & Databases

- `golang.md` - Functions, goroutines, channels, packages, http
- `postgres.md` - SQL queries, tables, transactions, optimization
- `redis.md` - Data structures, operations, pub/sub, caching
- `bash.md` - Shell scripting, functions, arrays, error handling

### DevOps & Tools

- `docker.md` - Images, containers, compose, networking
- `git.md` - Branching, rebasing, workflows, advanced commands
- `tmux.md` - Sessions, windows, panes, keybindings, config

### Query & API

- `jq.md` - JSON querying, transformations, filtering
- `graphql.md` - Queries, mutations, subscriptions, schemas
- `rxjs.md` - Observables, operators, subjects, patterns

## Features

✓ **Offline-first** - Zero network dependency
✓ **Always accurate** - You maintain and control it
✓ **Vim-native search** - Use `/` to find what you need
✓ **Synced everywhere** - Lives in dotfiles repo
✓ **Fast** - Opens instantly, no loading
✓ **Copy-paste ready** - Complete working examples
✓ **Discoverable** - Fuzzyfinder integration for quick access

## How It Works

1. **Search**: Use fuzzyfinder to search tool names
2. **Open**: File opens in vim with full documentation
3. **Navigate**: Use vim's `/` command to search within file
4. **Jump**: Table of Contents anchors let you jump to sections
5. **Copy**: Code examples ready to use

## Adding New Docs

```bash
# 1. Create new markdown file
vim ~/dotfiles/docs/newtool.md

# 2. Follow the format:
#    - Table of Contents at top
#    - Organized sections with examples
#    - Copy-paste ready code snippets

# 3. Update tmux-cht.sh to include it
# 4. Add to dotfiles repo
```

## Tips & Tricks

```vim
" Search within document
/useState        " Jump to useState section

" Vim marks - set and return
ma               " Set mark 'a' at current position
'a               " Return to mark 'a'

" Open multiple docs side-by-side
:vs ~/dotfiles/docs/javascript.md

" Search across all docs from terminal
grep -r "async" ~/dotfiles/docs/

" Show only file names that contain search term
grep -l "Promise" ~/dotfiles/docs/*.md
```

## Integration with Workflow

These docs are integrated with:

- **tmux-cht.sh** - Fuzzyfinder for quick access
- **vim/nvim** - Native search and navigation
- **dotfiles** - Version controlled and synced

The goal: Make knowledge lookup as fast as muscle memory. If you need to know something, it's one search away, always available, always right.
