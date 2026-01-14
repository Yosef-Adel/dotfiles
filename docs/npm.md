*npm.txt*  npm Reference

==============================================================================
CONTENTS                                                         *npm-contents*

1. Initialization ........................ |npm-init|
2. Installing Packages ................... |npm-install|
   2.1 npm install ....................... |npm-install-command|
   2.2 Dependency Types .................. |npm-deps|
   2.3 Version Specifiers ................ |npm-versions|
3. Managing Dependencies ................. |npm-manage|
   3.1 npm update ........................ |npm-update|
   3.2 npm outdated ...................... |npm-outdated|
   3.3 npm audit ......................... |npm-audit|
   3.4 npm prune ......................... |npm-prune|
4. Running Scripts ....................... |npm-scripts|
   4.1 npm run ........................... |npm-run|
   4.2 package.json Scripts .............. |npm-scripts-package|
5. Publishing ............................ |npm-publish|
   5.1 npm publish ....................... |npm-publish-command|
   5.2 npm version ....................... |npm-version|
   5.3 npm unpublish ..................... |npm-unpublish|
6. Package Metadata ...................... |npm-metadata|
   6.1 npm info .......................... |npm-info|
   6.2 npm list .......................... |npm-list|
   6.3 npm search ........................ |npm-search|
7. User Management ....................... |npm-user|
   7.1 npm login ......................... |npm-login|
   7.2 npm whoami ........................ |npm-whoami|
   7.3 npm access ........................ |npm-access|
8. Registry .............................. |npm-registry|
   8.1 npm config ........................ |npm-config|
   8.2 Private Registry .................. |npm-private-registry|
9. Workspace ............................. |npm-workspace|
10. Troubleshooting ...................... |npm-troubleshooting|
    10.1 npm cache ....................... |npm-cache|
    10.2 npm rebuild ..................... |npm-rebuild|
    10.3 Common Issues ................... |npm-issues|

==============================================================================
1. INITIALIZATION                                                   *npm-init*

Create a new project or initialize npm in existing directory~
>
    npm init                           # Interactive setup
    npm init -y                        # Quick setup with defaults
    npm init -y my-project             # Create directory and init
<

Create specific package type~
>
    npm init --scope=@myorg            # Scoped package
    npm init --yes --private           # Private package
<

==============================================================================
2. INSTALLING PACKAGES                                           *npm-install*

------------------------------------------------------------------------------
2.1 NPM INSTALL                                        *npm-install-command*

Install packages from package.json or specific packages~
>
    # Install all dependencies
    npm install
    npm i

    # Install specific package
    npm install lodash
    npm i lodash

    # Install specific version
    npm install lodash@4.17.21
    npm i lodash@latest
<

Install from GitHub~                                    *npm-install-github*
>
    npm install https://github.com/user/repo
    npm install git+https://github.com/user/repo.git
<

Install globally~                                        *npm-install-global*
>
    npm install -g create-react-app
    npm install --global nodemon
<

Install multiple packages~
>
    npm install react react-dom next
<

Install with peer dependency handling~
>
    npm install --legacy-peer-deps     # Ignore peer dependency conflicts
<

------------------------------------------------------------------------------
2.2 DEPENDENCY TYPES                                              *npm-deps*

Production dependencies~                                 *npm-deps-prod*
>
    npm install lodash
    npm install lodash --save          # Explicit (default in npm 5+)
    npm i lodash -S
<

Development dependencies~                                *npm-deps-dev*
>
    npm install --save-dev eslint
    npm i --save-dev prettier
    npm i -D vitest
<

Optional dependencies~                                   *npm-deps-optional*
>
    npm install optional-pkg --save-optional
<

Peer dependencies~                                       *npm-deps-peer*
>
    npm install react --peer
<

Note: Peer dependencies are for libraries that require a certain version of
another package to be installed by the consumer.

Exact version~                                           *npm-deps-exact*
>
    npm install lodash@4.17.21 --save-exact
    npm i -E lodash@4.17.21
<

------------------------------------------------------------------------------
2.3 VERSION SPECIFIERS                                        *npm-versions*

Semver version specifiers in package.json~
>
    {
      "dependencies": {
        "lodash": "4.17.21",       // Exact version
        "react": "^18.0.0",        // Caret: compatible (18.x.x)
        "vue": "~3.0.0",           // Tilde: patch releases (3.0.x)
        "axios": "1.x",            // Major.x: latest minor/patch in 1.x
        "express": ">=4.0.0",      // Greater than
        "webpack": "4.0.0 - 5.0.0", // Range
        "babel": "*",              // Latest
        "jquery": "3.0.0 || 4.0.0" // Or
      }
    }
<

Version specifier reference:                             *npm-semver*
  ^1.2.3       Compatible with 1.2.3 (1.x.x, excluding 2.0.0)
  ~1.2.3       Approximately 1.2.3 (1.2.x)
  1.2.3        Exact version
  >=1.2.3      Greater than or equal to
  1.x          Any 1.x.x version
  *            Latest version
  latest       Latest version tag

==============================================================================
3. MANAGING DEPENDENCIES                                          *npm-manage*

------------------------------------------------------------------------------
3.1 NPM UPDATE                                                  *npm-update*

Update packages to latest compatible version~
>
    npm update                         # Update all to latest compatible
    npm update lodash                  # Update specific package
    npm update --global gulp           # Update global package
    npm update --save                  # Update and save to package.json
<

------------------------------------------------------------------------------
3.2 NPM OUTDATED                                              *npm-outdated*

Check for outdated packages~
>
    npm outdated
    npm outdated --depth=0             # Top-level only
    npm outdated --global              # Global packages
<

Output shows:                                            *npm-outdated-output*
  Package      Current version installed
  Wanted       Maximum version satisfying semver
  Latest       Latest version published
  Location     Where the package is installed

------------------------------------------------------------------------------
3.3 NPM AUDIT                                                    *npm-audit*

Check for security vulnerabilities~
>
    npm audit                          # Show vulnerabilities
    npm audit --json                   # JSON format
    npm audit fix                      # Auto-fix vulnerabilities
    npm audit fix --force              # Force fix (may break compatibility)
    npm audit fix --audit-level=moderate  # Fix only moderate+ severity
<

Note: npm audit checks installed packages against known security advisories.

------------------------------------------------------------------------------
3.4 NPM PRUNE                                                    *npm-prune*

Remove unused packages~
>
    npm prune                          # Remove packages not in package.json
    npm prune --production             # Remove dev dependencies
<

==============================================================================
4. RUNNING SCRIPTS                                               *npm-scripts*

------------------------------------------------------------------------------
4.1 NPM RUN                                                        *npm-run*

Execute scripts defined in package.json~
>
    npm run build                      # Run build script
    npm run dev                        # Run dev script
    npm run test                       # Run test script
    npm run lint                       # Run lint script
<

Common shortcuts (don't need 'run')~                     *npm-shortcuts*
>
    npm start                          # npm run start
    npm test                           # npm run test
    npm stop                           # npm run stop
<

Pass arguments~                                          *npm-run-args*
>
    npm run build -- --mode production
    npm run test -- --watch
<

List available scripts~
>
    npm run --list                     # List all available scripts
<

------------------------------------------------------------------------------
4.2 PACKAGE.JSON SCRIPTS                                *npm-scripts-package*

Define scripts in package.json~
>
    {
      "scripts": {
        "start": "node index.js",
        "dev": "nodemon src/index.js",
        "build": "webpack --mode production",
        "test": "jest",
        "lint": "eslint src/",
        "format": "prettier --write .",
        "type-check": "tsc --noEmit",
        "prebuild": "npm run lint",
        "postbuild": "echo 'Build complete'",
        "dev:all": "npm run dev & npm run build -- --watch"
      }
    }
<

Script hooks:                                            *npm-script-hooks*
  pre<script>   Runs before the script
  post<script>  Runs after the script

Example: prebuild runs before build, postbuild runs after build.

==============================================================================
5. PUBLISHING                                                   *npm-publish*

------------------------------------------------------------------------------
5.1 NPM PUBLISH                                        *npm-publish-command*

Publish package to npm registry~
>
    npm publish                        # Publish current version
    npm publish --tag beta             # Publish as beta
    npm publish --tag next             # Publish as next version
    npm publish --access=public        # Public package
    npm publish --access=restricted    # Private package (paid account)
<

Publish to custom registry~
>
    npm publish --registry https://registry.npmjs.org/
<

------------------------------------------------------------------------------
5.2 NPM VERSION                                                *npm-version*

Bump package version~
>
    npm version patch                  # 1.0.0 -> 1.0.1
    npm version minor                  # 1.0.0 -> 1.1.0
    npm version major                  # 1.0.0 -> 2.0.0
    npm version 2.1.0                  # Set specific version
    npm version --no-git-tag           # Don't create git tag
    npm version prepatch               # 1.0.0 -> 1.0.1-0
    npm version prerelease             # 1.0.0 -> 1.0.0-0
<

Version types:                                           *npm-version-types*
  patch         Bug fixes (1.0.0 -> 1.0.1)
  minor         New features (1.0.0 -> 1.1.0)
  major         Breaking changes (1.0.0 -> 2.0.0)
  prepatch      Pre-release patch (1.0.0 -> 1.0.1-0)
  preminor      Pre-release minor (1.0.0 -> 1.1.0-0)
  premajor      Pre-release major (1.0.0 -> 2.0.0-0)
  prerelease    Increment pre-release version

------------------------------------------------------------------------------
5.3 NPM UNPUBLISH                                            *npm-unpublish*

Remove package from registry~
>
    npm unpublish package-name         # Unpublish all versions
    npm unpublish package-name@1.0.0   # Unpublish specific version
<

Restrictions:                                            *npm-unpublish-rules*
- Can only unpublish within 72 hours of publishing
- Must be the package owner
- Cannot unpublish if other packages depend on it

==============================================================================
6. PACKAGE METADATA                                             *npm-metadata*

------------------------------------------------------------------------------
6.1 NPM INFO                                                      *npm-info*

Get package information~
>
    npm info lodash                    # Full info
    npm info lodash version            # Latest version
    npm info lodash versions           # All versions
    npm view lodash repository         # Repository URL
    npm view lodash homepage           # Homepage
<

Note: npm view is an alias for npm info.

------------------------------------------------------------------------------
6.2 NPM LIST                                                      *npm-list*

List installed packages~
>
    npm list                           # All dependencies (tree)
    npm list --depth=0                 # Top-level only
    npm list --global                  # Global packages
    npm list lodash                    # Specific package
    npm list --json                    # JSON format
<

------------------------------------------------------------------------------
6.3 NPM SEARCH                                                  *npm-search*

Search npm registry~
>
    npm search react                   # Search by keyword
    npm search --json                  # JSON format
    npm search --description           # Include descriptions
<

==============================================================================
7. USER MANAGEMENT                                                 *npm-user*

------------------------------------------------------------------------------
7.1 NPM LOGIN                                                    *npm-login*

Authenticate with npm registry~
>
    npm login                          # Interactive login
    npm login --scope=@myorg           # Login for scoped packages
<

Set registry~
>
    npm login --registry https://my-registry.com
<

------------------------------------------------------------------------------
7.2 NPM WHOAMI                                                  *npm-whoami*

Show logged-in user~
>
    npm whoami                         # Show username
    npm whoami --registry my-registry  # Check other registry
<

------------------------------------------------------------------------------
7.3 NPM ACCESS                                                  *npm-access*

Manage package access~
>
    npm access public [<package>]      # Make public
    npm access restricted [<package>]  # Make private
    npm access grant read-only user pkg  # Grant read-only
    npm access revoke user pkg         # Revoke access
    npm access ls-packages [user]      # List packages user has access to
    npm access ls-collaborators [pkg]  # List collaborators
<

==============================================================================
8. REGISTRY                                                     *npm-registry*

------------------------------------------------------------------------------
8.1 NPM CONFIG                                                  *npm-config*

View and set npm configuration~
>
    npm config list                    # Show all config
    npm config list --json             # JSON format
    npm config get registry            # Get registry URL
    npm config set registry https://...  # Set registry
<

User config~
>
    npm config set email user@example.com
    npm config set name "Your Name"
    npm config set author-name "Your Name"
<

Save defaults~
>
    npm config set save=true           # Save dev dependencies by default
    npm config set save-exact=true     # Save exact versions
<

View config file~
>
    cat ~/.npmrc
<

------------------------------------------------------------------------------
8.2 PRIVATE REGISTRY                                  *npm-private-registry*

Setup private npm registry (Nexus, Verdaccio, etc)~

.npmrc file:
>
    registry=https://my-private-registry.com
    @myorg:registry=https://my-private-registry.com
    //my-private-registry.com:_authToken=YOUR_TOKEN
<

Or via command:
>
    npm config set registry https://my-private-registry.com
    npm config set //my-private-registry.com:_authToken YOUR_TOKEN
<

Use in package.json:
>
    {
      "publishConfig": {
        "registry": "https://my-private-registry.com"
      }
    }
<

==============================================================================
9. WORKSPACE                                                   *npm-workspace*

Manage monorepos with workspaces~                       *npm-workspaces*

Package.json (root):
>
    {
      "workspaces": [
        "packages/*",
        "apps/*"
      ]
    }
<

Install dependencies~
>
    npm install                        # Installs all workspaces
<

Run in specific workspace~                              *npm-workspace-run*
>
    npm run build -w packages/core
    npm run test -w apps/web --
<

Run in all workspaces~
>
    npm run build -ws
    npm run test --workspaces
<

Install in workspace~                                   *npm-workspace-install*
>
    npm install lodash -w packages/core
<

Add workspace to workspace~
>
    npm install @myorg/core -w packages/utils
<

List workspaces~
>
    npm workspaces list
<

==============================================================================
10. TROUBLESHOOTING                                      *npm-troubleshooting*

------------------------------------------------------------------------------
10.1 NPM CACHE                                                  *npm-cache*

Manage npm cache~
>
    npm cache clean --force            # Clear entire cache
    npm cache verify                   # Verify cache integrity
    npm cache ls                       # List cached packages
<

Clear specific~
>
    rm -rf ~/.npm
<

Note: Clearing cache can help resolve package corruption issues.

------------------------------------------------------------------------------
10.2 NPM REBUILD                                              *npm-rebuild*

Rebuild packages with native bindings~
>
    npm rebuild                        # Rebuild all
    npm rebuild node-gyp               # Rebuild specific package
<

Common when installing on new OS~
>
    npm rebuild --verbose              # Show what's happening
<

------------------------------------------------------------------------------
10.3 COMMON ISSUES                                              *npm-issues*

Permission denied~                                      *npm-issues-permission*
>
    sudo chown -R $(whoami) ~/.npm
    npm config set prefix ~/.npm-global
    export PATH=~/.npm-global/bin:$PATH
<

Clear node_modules and reinstall~                       *npm-issues-reinstall*
>
    rm -rf node_modules package-lock.json
    npm install
<

Fix peer dependency issues~                             *npm-issues-peer*
>
    npm install --legacy-peer-deps
<

Network timeout~                                        *npm-issues-timeout*
>
    npm config set fetch-timeout 120000
    npm config set fetch-retry-mintimeout 20000
    npm config set fetch-retry-maxtimeout 120000
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
