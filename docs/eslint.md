# ESLint Reference

Quick reference for ESLint (JavaScript linter). Use `/` to search in vim.

## Table of Contents

- [Installation & Setup](#installation--setup)
- [Configuration](#configuration)
  - [eslintrc Files](#eslintrc-files)
  - [Common Configurations](#common-configurations)
  - [Rules](#rules)
- [Rules](#rules-1)
  - [Possible Errors](#possible-errors)
  - [Best Practices](#best-practices)
  - [Variables](#variables)
  - [Style Issues](#style-issues)
  - [ES6](#es6)
- [Commands](#commands)
  - [Check Files](#check-files)
  - [Fix Files](#fix-files)
  - [Cache](#cache)
- [Plugins](#plugins)
  - [Popular Plugins](#popular-plugins)
  - [Using Plugins](#using-plugins)
- [Extending Configs](#extending-configs)
- [Ignoring Files](#ignoring-files)
- [Integration](#integration)

## Installation & Setup

Install ESLint and initialize configuration.

```bash
# Install
npm install --save-dev eslint

# Initialize config
npm init @eslint/config

# Or with preset
npm install --save-dev eslint-config-airbnb
npm install --save-dev eslint-config-standard
npm install --save-dev eslint-config-google
```

## Configuration

### eslintrc Files

Configuration can be in multiple formats (in order of precedence):

```bash
.eslintrc.js        # JavaScript file
.eslintrc.cjs       # CommonJS file
.eslintrc.yaml      # YAML file
.eslintrc.yml       # YAML file
.eslintrc.json      # JSON file
package.json        # In eslintConfig field
```

### Common Configurations

```javascript
// .eslintrc.js (JavaScript)
module.exports = {
  // Environment
  env: {
    browser: true,
    node: true,
    es2021: true,
    jest: true,
  },

  // Extends
  extends: ["eslint:recommended"],

  // Parser
  parser: "@babel/eslint-parser",
  parserOptions: {
    ecmaVersion: 2021,
    sourceType: "module",
    ecmaFeatures: {
      jsx: true,
    },
  },

  // Plugins
  plugins: ["react", "import"],

  // Rules
  rules: {
    "no-console": "warn",
    "no-unused-vars": "error",
  },

  // Override for specific files
  overrides: [
    {
      files: ["*.test.js"],
      rules: {
        "no-unused-expressions": "off",
      },
    },
  ],
};
```

```json
// .eslintrc.json
{
  "env": {
    "browser": true,
    "node": true,
    "es2021": true
  },
  "extends": ["eslint:recommended"],
  "parserOptions": {
    "ecmaVersion": "latest",
    "sourceType": "module"
  },
  "rules": {
    "no-console": "warn"
  }
}
```

```yaml
# .eslintrc.yaml
env:
  browser: true
  node: true
  es2021: true

extends:
  - eslint:recommended

parserOptions:
  ecmaVersion: latest
  sourceType: module

rules:
  no-console: warn
  no-unused-vars: error
```

### Rules

Rule values:

- `'off'` or `0` - Disable rule
- `'warn'` or `1` - Warn (non-blocking)
- `'error'` or `2` - Error (fails linting)

```javascript
{
  rules: {
    'no-console': 'warn',
    'no-unused-vars': 'error',
    'semi': ['error', 'always'],              // With options
    'quotes': ['warn', 'single', {            // Multiple options
      'avoidEscape': true,
      'allowTemplateLiterals': true
    }],
  }
}
```

## Rules

### Possible Errors

```javascript
rules: {
  'no-console': 'warn',                    // Disallow console
  'no-debugger': 'error',                  // Disallow debugger
  'no-dupe-keys': 'error',                 // Disallow duplicate keys
  'no-unreachable': 'error',               // Disallow unreachable code
  'no-unsafe-finally': 'error',            // Disallow unsafe finally
  'valid-typeof': 'error',                 // Valid typeof comparisons
  'no-compare-neg-zero': 'error',          // No -0 comparisons
  'no-const-assign': 'error',              // No reassigning const
  'no-constant-condition': 'error',        // No constant conditions
}
```

### Best Practices

```javascript
rules: {
  'curly': 'error',                        // Require braces
  'eqeqeq': 'error',                       // Require === or !==
  'no-eval': 'error',                      // Disallow eval()
  'no-with': 'error',                      // Disallow with statement
  'no-implied-eval': 'error',              // No implied eval
  'no-new-func': 'error',                  // No Function constructor
  'no-script-url': 'error',                // No javascript: URLs
  'no-unused-expressions': 'error',        // No unused expressions
  'no-multi-spaces': 'error',              // No multiple spaces
  'no-multi-str': 'error',                 // No multiline strings
  'yoda': ['error', 'never'],              // Literal on right side
}
```

### Variables

```javascript
rules: {
  'no-undef': 'error',                     // Undefined variables
  'no-unused-vars': ['error', {            // Unused variables
    'argsIgnorePattern': '^_'
  }],
  'no-shadow': 'error',                    // Variable shadowing
  'no-use-before-define': 'error',         // Use before define
  'no-delete-var': 'error',                // No delete var
}
```

### Style Issues

```javascript
rules: {
  'indent': ['error', 2],                  // Indentation
  'quotes': ['error', 'single'],           // Single quotes
  'semi': ['error', 'always'],             // Semicolons
  'comma-dangle': ['error', 'never'],      // No trailing commas
  'comma-spacing': 'error',                // Space after comma
  'object-curly-spacing': ['error', true], // { obj } not {obj}
  'array-bracket-spacing': ['error', false], // [arr] not [ arr ]
  'space-infix-ops': 'error',              // Spaces around operators
  'space-before-function-paren': ['error', {  // Space before (
    'anonymous': 'always',
    'named': 'never'
  }],
  'no-trailing-spaces': 'error',           // No trailing whitespace
  'eol-last': ['error', 'always'],         // Newline at EOF
}
```

### ES6

```javascript
rules: {
  'no-var': 'error',                       // Use const/let
  'prefer-const': 'error',                 // Const when not reassigned
  'prefer-arrow-callback': 'error',        // Arrow functions
  'prefer-template': 'error',              // Template literals
  'prefer-destructuring': 'warn',          // Destructuring
  'no-duplicate-imports': 'error',         // No duplicate imports
  'sort-imports': 'warn',                  // Sort imports
}
```

## Commands

### Check Files

```bash
# Lint current directory
eslint .

# Lint specific file
eslint src/index.js

# Lint specific pattern
eslint "src/**/*.js"
eslint "src/**/*.{js,jsx}"

# Show only errors (not warnings)
eslint . --quiet

# Show only files with issues
eslint . --format compact

# Max warnings before error
eslint . --max-warnings 5

# Output to file
eslint . --output-file report.json --format json

# Format
eslint . --format stylish    # Default
eslint . --format json       # JSON
eslint . --format compact    # Compact
eslint . --format table      # Table
```

### Fix Files

```bash
# Fix fixable issues
eslint . --fix

# Specific file
eslint src/index.js --fix

# Preview fixes without applying
eslint . --fix-dry-run

# Show what would be fixed
eslint . --fix-type problem   # Only problems
eslint . --fix-type suggestion # Only suggestions
eslint . --fix-type layout    # Formatting only
```

### Cache

```bash
# Use cache (faster)
eslint . --cache

# Cache directory
eslint . --cache-location ./node_modules/.cache/eslint

# Clear cache
eslint . --cache --cache-location ./node_modules/.cache/eslint --cache-strategy content

# Or manually
rm -rf ./node_modules/.cache/eslint
```

## Plugins

### Popular Plugins

```bash
# React
npm install --save-dev eslint-plugin-react
npm install --save-dev eslint-plugin-react-hooks

# Import statements
npm install --save-dev eslint-plugin-import

# Node.js
npm install --save-dev eslint-plugin-node

# Async/await
npm install --save-dev eslint-plugin-async-await

# Security
npm install --save-dev eslint-plugin-security

# Unicorn
npm install --save-dev eslint-plugin-unicorn

# TypeScript
npm install --save-dev @typescript-eslint/parser @typescript-eslint/eslint-plugin

# Vue
npm install --save-dev eslint-plugin-vue

# Jest
npm install --save-dev eslint-plugin-jest
```

### Using Plugins

```javascript
// .eslintrc.js
module.exports = {
  extends: [
    "eslint:recommended",
    "plugin:react/recommended",
    "plugin:react-hooks/recommended",
  ],

  plugins: ["react", "react-hooks", "import"],

  rules: {
    "react/prop-types": "off",
    "react/react-in-jsx-scope": "off",
    "react-hooks/rules-of-hooks": "error",
    "react-hooks/exhaustive-deps": "warn",
    "import/order": [
      "error",
      {
        groups: ["builtin", "external", "internal", "parent", "sibling"],
        pathGroups: [
          {
            pattern: "react",
            group: "external",
            position: "before",
          },
        ],
        pathGroupsExcludedImportTypes: ["react"],
        alphabetize: {
          order: "asc",
          caseInsensitive: true,
        },
      },
    ],
  },
};
```

## Extending Configs

```javascript
module.exports = {
  // Built-in configs
  extends: [
    "eslint:recommended", // Official recommended
    "eslint:all", // All rules (not recommended)
  ],

  // Popular configs
  extends: [
    "airbnb", // Airbnb style guide
    "airbnb/hooks", // React hooks rules
    "google", // Google style guide
    "standard", // JavaScript Standard Style
    "prettier", // Disable conflicting rules
  ],

  // Multiple configs
  extends: [
    "eslint:recommended",
    "plugin:react/recommended",
    "plugin:import/errors",
    "plugin:import/warnings",
    "prettier", // Disable formatting rules (use Prettier)
  ],

  // Config with options
  extends: [["plugin:react/recommended", { version: "detect" }]],
};
```

## Ignoring Files

### .eslintignore

```
node_modules/
dist/
build/
coverage/
*.min.js
!.eslintrc.js
```

### In eslintrc

```javascript
module.exports = {
  ignorePatterns: [
    "node_modules/",
    "dist/",
    "build/",
    "*.min.js",
    "!.eslintrc.js",
  ],
};
```

### Inline Comments

```javascript
// Disable for entire file
/* eslint-disable */
const x = 1;
/* eslint-enable */

// Disable for next line
// eslint-disable-next-line no-console
console.log("debug");

// Disable specific rule
// eslint-disable-next-line
const x = 1; // Allow unused variable

// Disable for block
/* eslint-disable no-console */
console.log("debug");
console.log("more debug");
/* eslint-enable no-console */
```

## Integration

### npm scripts

```json
{
  "scripts": {
    "lint": "eslint .",
    "lint:fix": "eslint . --fix",
    "lint:check": "eslint . --max-warnings 0",
    "lint:watch": "eslint . --watch"
  }
}
```

### Git hooks (pre-commit)

```bash
# Install husky
npm install --save-dev husky
npx husky install

# Add pre-commit hook
npx husky add .husky/pre-commit "npm run lint:fix"
```

### Editor Integration

```javascript
// VS Code .vscode/settings.json
{
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  ],
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  }
}
```
