# Prettier Reference

Quick reference for Prettier (code formatter). Use `/` to search in vim.

## Table of Contents

- [Prettier Reference](#prettier-reference)
  - [Table of Contents](#table-of-contents)
  - [Installation \& Setup](#installation--setup)
  - [Configuration](#configuration)
    - [Config Files](#config-files)
    - [Options](#options)
    - [Ignoring Files](#ignoring-files)
  - [Commands](#commands)
    - [Check Files](#check-files)
    - [Format Files](#format-files)
    - [Range Formatting](#range-formatting)
  - [Options](#options-1)
    - [Print Width](#print-width)
    - [Tabs vs Spaces](#tabs-vs-spaces)
    - [Quotes](#quotes)
    - [Semicolons](#semicolons)
    - [Trailing Commas](#trailing-commas)
    - [Brackets \& Parentheses](#brackets--parentheses)
    - [Arrow Functions](#arrow-functions)
    - [Markdown](#markdown)
  - [Integration](#integration)
    - [With ESLint](#with-eslint)
    - [Git Hooks](#git-hooks)
    - [Editor Integration](#editor-integration)
  - [Language Support](#language-support)

## Installation & Setup

Install Prettier.

```bash
# Install
npm install --save-dev prettier

# Install with recommended config
npm install --save-dev prettier eslint-config-prettier eslint-plugin-prettier
```

## Configuration

### Config Files

Configuration can be in multiple formats (in order):

```bash
.prettierrc            # JSON
.prettierrc.json       # JSON
.prettierrc.yaml       # YAML
.prettierrc.yml        # YAML
.prettierrc.js         # JavaScript
.prettierrc.cjs        # CommonJS
.prettierrc.mjs        # ES modules
prettier.config.js     # Alternative name
prettier.config.cjs    # Alternative CommonJS
.editorconfig          # EditorConfig (partial support)
package.json           # In prettier field
```

### Options

JavaScript format:

```javascript
// .prettierrc.js
module.exports = {
  printWidth: 80,
  tabWidth: 2,
  useTabs: false,
  semi: true,
  singleQuote: true,
  quoteProps: "as-needed",
  trailingComma: "es5",
  bracketSpacing: true,
  bracketSameLine: false,
  arrowParens: "always",
  endOfLine: "lf",
  htmlWhitespaceSensitivity: "css",
  embeddedLanguageFormatting: "auto",
};
```

JSON format:

```json
{
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "semi": true,
  "singleQuote": true,
  "trailingComma": "es5",
  "bracketSpacing": true,
  "arrowParens": "always"
}
```

YAML format:

```yaml
printWidth: 80
tabWidth: 2
useTabs: false
semi: true
singleQuote: true
trailingComma: es5
bracketSpacing: true
arrowParens: always
```

### Ignoring Files

```
# .prettierignore
node_modules/
dist/
build/
.next/
out/
coverage/
*.min.js
*.min.css
.git
.svn
.hg
.DS_Store
```

## Commands

### Check Files

```bash
# Check files (no changes)
prettier --check .

# Specific file
prettier --check src/index.js

# Specific pattern
prettier --check "src/**/*.{js,jsx,ts,tsx}"

# Show which files would be formatted
prettier --check . --write --no-semi
```

### Format Files

```bash
# Format current directory
prettier --write .

# Specific file
prettier --write src/index.js

# Specific pattern
prettier --write "src/**/*.{js,jsx,ts,tsx}"

# Format with options
prettier --write . --single-quote --trailing-comma none

# Dry run (preview changes)
prettier --check .
```

### Range Formatting

```bash
# Format only lines 10-20 of a file
prettier --write src/index.js --range-start 100 --range-end 200

# Character positions
prettier --write src/index.js --range-start 10 --range-end 200
```

## Options

### Print Width

Maximum line length before wrapping.

```javascript
{
  printWidth: 80,    // Default
  printWidth: 100,
  printWidth: 120,
}
```

Example:

```javascript
// printWidth: 80
const longString =
  "This is a very long string that will be wrapped to multiple lines";

// printWidth: 120
const longString =
  "This is a very long string that will be wrapped to multiple lines";
```

### Tabs vs Spaces

```javascript
{
  useTabs: false,    // Use spaces (default)
  useTabs: true,     // Use tabs
  tabWidth: 2,       // 2 spaces (default)
  tabWidth: 4,       // 4 spaces
}
```

### Quotes

```javascript
{
  singleQuote: false,   // "double" (default)
  singleQuote: true,    // 'single'
}
```

Example:

```javascript
// singleQuote: false
const name = "John";
const message = "It's working";

// singleQuote: true
const name = "John";
const message = "It's working";
```

### Semicolons

```javascript
{
  semi: true,   // Add semicolons (default)
  semi: false,  // Omit semicolons
}
```

Example:

```javascript
// semi: true
const x = 1;
const y = 2;

// semi: false
const x = 1;
const y = 2;
```

### Trailing Commas

```javascript
{
  trailingComma: 'es5',    // Valid in ES5 (default)
  trailingComma: 'none',   // No trailing commas
  trailingComma: 'all',    // Trailing commas everywhere
}
```

Example:

```javascript
// trailingComma: 'es5'
const arr = ["a", "b", "c"];

// trailingComma: 'none'
const arr = ["a", "b", "c"];

// trailingComma: 'all'
const obj = {
  a: 1,
  b: 2,
};
```

### Brackets & Parentheses

```javascript
{
  bracketSpacing: true,      // { x: 1 } (default)
  bracketSpacing: false,     // {x: 1}

  arrowParens: 'always',     // (x) => x (default)
  arrowParens: 'avoid',      // x => x

  bracketSameLine: false,    // Closing bracket on new line (default)
  bracketSameLine: true,     // Closing bracket on same line
}
```

Example:

```javascript
// arrowParens: 'always'
const add = (x) => x + 1;

// arrowParens: 'avoid'
const add = (x) => x + 1;
```

### Arrow Functions

```javascript
{
  arrowParens: 'always',   // Always: (x) => x
  arrowParens: 'avoid',    // Avoid: x => x
}
```

### Markdown

```javascript
{
  htmlWhitespaceSensitivity: 'css',    // Respect CSS (default)
  htmlWhitespaceSensitivity: 'strict',  // All whitespace is significant
  htmlWhitespaceSensitivity: 'ignore',  // Ignore whitespace

  embeddedLanguageFormatting: 'auto',  // Format embedded languages (default)
  embeddedLanguageFormatting: 'off',   // Don't format
}
```

## Integration

### With ESLint

```bash
# Install
npm install --save-dev prettier eslint-config-prettier
```

```javascript
// .eslintrc.js
module.exports = {
  extends: [
    "eslint:recommended",
    "prettier", // Disable conflicting ESLint rules
  ],

  rules: {
    // Other rules...
  },
};
```

```json
// package.json
{
  "scripts": {
    "lint": "eslint .",
    "format": "prettier --write .",
    "format:check": "prettier --check .",
    "lint:fix": "eslint . --fix && prettier --write ."
  }
}
```

### Git Hooks

```bash
# Install husky
npm install --save-dev husky lint-staged
npx husky install

# Create pre-commit hook
npx husky add .husky/pre-commit "npx lint-staged"
```

```json
// package.json
{
  "lint-staged": {
    "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write"],
    "*.{md,json,yaml}": ["prettier --write"]
  }
}
```

### Editor Integration

```json
// VS Code .vscode/settings.json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true,
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode",
    "editor.formatOnSave": true
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

Vim integration:

```vim
" vim-prettier
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html']
  \ }

" Format on save
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" Or manual formatting
:Prettier
```

## Language Support

Prettier supports:

```
JavaScript
TypeScript
JSX
CSS
SCSS
Less
HTML
JSON
YAML
GraphQL
Markdown
Vue
```

```bash
# Format specific types
prettier --write . --parser babel           # JavaScript
prettier --write . --parser typescript      # TypeScript
prettier --write . --parser css             # CSS
prettier --write . --parser json            # JSON
prettier --write . --parser markdown        # Markdown
prettier --write . --parser html            # HTML
prettier --write . --parser yaml            # YAML
```
