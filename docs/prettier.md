*prettier.txt*  Prettier Reference

==============================================================================
CONTENTS                                                    *prettier-contents*

1. Installation & Setup .................. |prettier-installation|
2. Configuration ......................... |prettier-configuration|
   - Config Files ........................ |prettier-config-files|
   - Options ............................. |prettier-options|
   - Ignoring Files ...................... |prettier-ignoring|
3. Commands .............................. |prettier-commands|
   - Check Files ......................... |prettier-commands-check|
   - Format Files ........................ |prettier-commands-format|
   - Range Formatting .................... |prettier-commands-range|
4. Options ............................... |prettier-options-list|
   - Print Width ......................... |prettier-print-width|
   - Tabs vs Spaces ...................... |prettier-tabs|
   - Quotes .............................. |prettier-quotes|
   - Semicolons .......................... |prettier-semicolons|
   - Trailing Commas ..................... |prettier-trailing-commas|
   - Brackets & Parentheses .............. |prettier-brackets|
   - Arrow Functions ..................... |prettier-arrow|
   - Markdown ............................ |prettier-markdown|
5. Integration ........................... |prettier-integration|
   - With ESLint ......................... |prettier-eslint|
   - Git Hooks ........................... |prettier-hooks|
   - Editor Integration .................. |prettier-editor|
6. Language Support ...................... |prettier-languages|

==============================================================================
1. INSTALLATION & SETUP                               *prettier-installation*

Install Prettier.~                                 *prettier-installation-npm*
>
    # Install
    npm install --save-dev prettier

    # Install with recommended config
    npm install --save-dev prettier eslint-config-prettier eslint-plugin-prettier
<

==============================================================================
2. CONFIGURATION                                      *prettier-configuration*

Config Files~                                          *prettier-config-files*
>
    Configuration can be in multiple formats (in order):

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
<

Options~                                                   *prettier-options*

JavaScript format~                                  *prettier-options-js*
>
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
<

JSON format~                                           *prettier-options-json*
>
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
<

YAML format~                                           *prettier-options-yaml*
>
    printWidth: 80
    tabWidth: 2
    useTabs: false
    semi: true
    singleQuote: true
    trailingComma: es5
    bracketSpacing: true
    arrowParens: always
<

Ignoring Files~                                            *prettier-ignoring*
>
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
<

==============================================================================
3. COMMANDS                                                *prettier-commands*

Check Files~                                        *prettier-commands-check*
>
    # Check files (no changes)
    prettier --check .

    # Specific file
    prettier --check src/index.js

    # Specific pattern
    prettier --check "src/**/*.{js,jsx,ts,tsx}"
<

Format Files~                                      *prettier-commands-format*
>
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
<

Range Formatting~                                  *prettier-commands-range*
>
    # Format only lines 10-20 of a file
    prettier --write src/index.js --range-start 100 --range-end 200

    # Character positions
    prettier --write src/index.js --range-start 10 --range-end 200
<

==============================================================================
4. OPTIONS                                              *prettier-options-list*

Print Width~                                            *prettier-print-width*
>
    Maximum line length before wrapping.

    {
      printWidth: 80,    // Default
      printWidth: 100,
      printWidth: 120,
    }
<

Example~                                           *prettier-print-width-example*
>
    // printWidth: 80
    const longString =
      "This is a very long string that will be wrapped to multiple lines";

    // printWidth: 120
    const longString = "This is a very long string that will be wrapped to multiple lines";
<

Tabs vs Spaces~                                                *prettier-tabs*
>
    {
      useTabs: false,    // Use spaces (default)
      useTabs: true,     // Use tabs
      tabWidth: 2,       // 2 spaces (default)
      tabWidth: 4,       // 4 spaces
    }
<

Quotes~                                                       *prettier-quotes*
>
    {
      singleQuote: false,   // "double" (default)
      singleQuote: true,    // 'single'
    }
<

Example~                                              *prettier-quotes-example*
>
    // singleQuote: false
    const name = "John";
    const message = "It's working";

    // singleQuote: true
    const name = 'John';
    const message = "It's working";
<

Semicolons~                                               *prettier-semicolons*
>
    {
      semi: true,   // Add semicolons (default)
      semi: false,  // Omit semicolons
    }
<

Example~                                         *prettier-semicolons-example*
>
    // semi: true
    const x = 1;
    const y = 2;

    // semi: false
    const x = 1
    const y = 2
<

Trailing Commas~                                     *prettier-trailing-commas*
>
    {
      trailingComma: 'es5',    // Valid in ES5 (default)
      trailingComma: 'none',   // No trailing commas
      trailingComma: 'all',    // Trailing commas everywhere
    }
<

Example~                                    *prettier-trailing-commas-example*
>
    // trailingComma: 'es5'
    const arr = ["a", "b", "c"];

    // trailingComma: 'none'
    const arr = ["a", "b", "c"];

    // trailingComma: 'all'
    const obj = {
      a: 1,
      b: 2,
    };
<

Brackets & Parentheses~                                   *prettier-brackets*
>
    {
      bracketSpacing: true,      // { x: 1 } (default)
      bracketSpacing: false,     // {x: 1}

      arrowParens: 'always',     // (x) => x (default)
      arrowParens: 'avoid',      // x => x

      bracketSameLine: false,    // Closing bracket on new line (default)
      bracketSameLine: true,     // Closing bracket on same line
    }
<

Example~                                          *prettier-brackets-example*
>
    // arrowParens: 'always'
    const add = (x) => x + 1;

    // arrowParens: 'avoid'
    const add = x => x + 1;
<

Arrow Functions~                                             *prettier-arrow*
>
    {
      arrowParens: 'always',   // Always: (x) => x
      arrowParens: 'avoid',    // Avoid: x => x
    }
<

Markdown~                                                   *prettier-markdown*
>
    {
      htmlWhitespaceSensitivity: 'css',    // Respect CSS (default)
      htmlWhitespaceSensitivity: 'strict',  // All whitespace is significant
      htmlWhitespaceSensitivity: 'ignore',  // Ignore whitespace

      embeddedLanguageFormatting: 'auto',  // Format embedded languages (default)
      embeddedLanguageFormatting: 'off',   // Don't format
    }
<

==============================================================================
5. INTEGRATION                                         *prettier-integration*

With ESLint~                                               *prettier-eslint*
>
    # Install
    npm install --save-dev prettier eslint-config-prettier

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

    // package.json
    {
      "scripts": {
        "lint": "eslint .",
        "format": "prettier --write .",
        "format:check": "prettier --check .",
        "lint:fix": "eslint . --fix && prettier --write ."
      }
    }
<

Git Hooks~                                                  *prettier-hooks*
>
    # Install husky
    npm install --save-dev husky lint-staged
    npx husky install

    # Create pre-commit hook
    npx husky add .husky/pre-commit "npx lint-staged"

    // package.json
    {
      "lint-staged": {
        "*.{js,jsx,ts,tsx}": ["eslint --fix", "prettier --write"],
        "*.{md,json,yaml}": ["prettier --write"]
      }
    }
<

Editor Integration~                                        *prettier-editor*

VS Code~                                             *prettier-editor-vscode*
>
    // .vscode/settings.json
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
<

Vim integration~                                       *prettier-editor-vim*
>
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
<

==============================================================================
6. LANGUAGE SUPPORT                                       *prettier-languages*

Supported languages~                              *prettier-languages-list*
>
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
<

Format specific types~                          *prettier-languages-commands*
>
    # Format specific types
    prettier --write . --parser babel           # JavaScript
    prettier --write . --parser typescript      # TypeScript
    prettier --write . --parser css             # CSS
    prettier --write . --parser json            # JSON
    prettier --write . --parser markdown        # Markdown
    prettier --write . --parser html            # HTML
    prettier --write . --parser yaml            # YAML
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
