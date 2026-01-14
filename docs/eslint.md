*eslint.txt*  ESLint Reference

==============================================================================
CONTENTS                                                      *eslint-contents*

1. Installation & Setup .................. |eslint-installation|
2. Configuration ......................... |eslint-configuration|
   - eslintrc Files ...................... |eslint-eslintrc|
   - Common Configurations ............... |eslint-config-common|
   - Rules ............................... |eslint-config-rules|
3. Rules ................................. |eslint-rules|
   - Possible Errors ..................... |eslint-rules-errors|
   - Best Practices ...................... |eslint-rules-practices|
   - Variables ........................... |eslint-rules-variables|
   - Style Issues ........................ |eslint-rules-style|
   - ES6 ................................. |eslint-rules-es6|
4. Commands .............................. |eslint-commands|
   - Check Files ......................... |eslint-commands-check|
   - Fix Files ........................... |eslint-commands-fix|
   - Cache ............................... |eslint-commands-cache|
5. Plugins ............................... |eslint-plugins|
   - Popular Plugins ..................... |eslint-plugins-popular|
   - Using Plugins ....................... |eslint-plugins-using|
6. Extending Configs ..................... |eslint-extending|
7. Ignoring Files ........................ |eslint-ignoring|
8. Integration ........................... |eslint-integration|

==============================================================================
1. INSTALLATION & SETUP                                   *eslint-installation*

Install ESLint and initialize configuration.~              *eslint-installation-npm*
>
    # Install
    npm install --save-dev eslint

    # Initialize config
    npm init @eslint/config

    # Or with preset
    npm install --save-dev eslint-config-airbnb
    npm install --save-dev eslint-config-standard
    npm install --save-dev eslint-config-google
<

==============================================================================
2. CONFIGURATION                                          *eslint-configuration*

eslintrc Files~                                                *eslint-eslintrc*
>
    Configuration can be in multiple formats (in order of precedence):

    .eslintrc.js        # JavaScript file
    .eslintrc.cjs       # CommonJS file
    .eslintrc.yaml      # YAML file
    .eslintrc.yml       # YAML file
    .eslintrc.json      # JSON file
    package.json        # In eslintConfig field
<

Common Configurations~                                     *eslint-config-common*
>
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
<

JSON format~                                              *eslint-config-json*
>
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
<

YAML format~                                              *eslint-config-yaml*
>
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
<

Rules~                                                    *eslint-config-rules*
>
    Rule values:
    - 'off' or 0 - Disable rule
    - 'warn' or 1 - Warn (non-blocking)
    - 'error' or 2 - Error (fails linting)

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
<

==============================================================================
3. RULES                                                         *eslint-rules*

Possible Errors~                                          *eslint-rules-errors*
>
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
<

Best Practices~                                        *eslint-rules-practices*
>
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
<

Variables~                                              *eslint-rules-variables*
>
    rules: {
      'no-undef': 'error',                     // Undefined variables
      'no-unused-vars': ['error', {            // Unused variables
        'argsIgnorePattern': '^_'
      }],
      'no-shadow': 'error',                    // Variable shadowing
      'no-use-before-define': 'error',         // Use before define
      'no-delete-var': 'error',                // No delete var
    }
<

Style Issues~                                              *eslint-rules-style*
>
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
<

ES6~                                                          *eslint-rules-es6*
>
    rules: {
      'no-var': 'error',                       // Use const/let
      'prefer-const': 'error',                 // Const when not reassigned
      'prefer-arrow-callback': 'error',        // Arrow functions
      'prefer-template': 'error',              // Template literals
      'prefer-destructuring': 'warn',          // Destructuring
      'no-duplicate-imports': 'error',         // No duplicate imports
      'sort-imports': 'warn',                  // Sort imports
    }
<

==============================================================================
4. COMMANDS                                                   *eslint-commands*

Check Files~                                             *eslint-commands-check*
>
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
<

Fix Files~                                                 *eslint-commands-fix*
>
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
<

Cache~                                                   *eslint-commands-cache*
>
    # Use cache (faster)
    eslint . --cache

    # Cache directory
    eslint . --cache-location ./node_modules/.cache/eslint

    # Cache strategy
    eslint . --cache --cache-strategy content

    # Clear cache manually
    rm -rf ./node_modules/.cache/eslint
<

==============================================================================
5. PLUGINS                                                     *eslint-plugins*

Popular Plugins~                                        *eslint-plugins-popular*
>
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
<

Using Plugins~                                           *eslint-plugins-using*
>
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
<

==============================================================================
6. EXTENDING CONFIGS                                          *eslint-extending*

Extending configurations~                             *eslint-extending-configs*
>
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
    };
<

==============================================================================
7. IGNORING FILES                                             *eslint-ignoring*

.eslintignore~                                         *eslint-ignoring-file*
>
    node_modules/
    dist/
    build/
    coverage/
    *.min.js
    !.eslintrc.js
<

In eslintrc~                                          *eslint-ignoring-config*
>
    module.exports = {
      ignorePatterns: [
        "node_modules/",
        "dist/",
        "build/",
        "*.min.js",
        "!.eslintrc.js",
      ],
    };
<

Inline Comments~                                      *eslint-ignoring-inline*
>
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
<

==============================================================================
8. INTEGRATION                                             *eslint-integration*

npm scripts~                                          *eslint-integration-npm*
>
    {
      "scripts": {
        "lint": "eslint .",
        "lint:fix": "eslint . --fix",
        "lint:check": "eslint . --max-warnings 0",
        "lint:watch": "eslint . --watch"
      }
    }
<

Git hooks (pre-commit)~                              *eslint-integration-hooks*
>
    # Install husky
    npm install --save-dev husky
    npx husky install

    # Add pre-commit hook
    npx husky add .husky/pre-commit "npm run lint:fix"
<

Editor Integration~                                 *eslint-integration-editor*
>
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
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
