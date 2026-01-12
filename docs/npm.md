# npm Reference

Quick reference for npm (Node Package Manager). Use `/` to search in vim.

## Table of Contents

- [npm Reference](#npm-reference)
  - [Table of Contents](#table-of-contents)
  - [Initialization](#initialization)
  - [Installing Packages](#installing-packages)
    - [npm install](#npm-install)
    - [Dependency Types](#dependency-types)
    - [Version Specifiers](#version-specifiers)
  - [Managing Dependencies](#managing-dependencies)
    - [npm update](#npm-update)
    - [npm outdated](#npm-outdated)
    - [npm audit](#npm-audit)
    - [npm prune](#npm-prune)
  - [Running Scripts](#running-scripts)
    - [npm run](#npm-run)
    - [package.json Scripts](#packagejson-scripts)
  - [Publishing](#publishing)
    - [npm publish](#npm-publish)
    - [npm version](#npm-version)
    - [npm unpublish](#npm-unpublish)
  - [Package Metadata](#package-metadata)
    - [npm info](#npm-info)
    - [npm list](#npm-list)
    - [npm search](#npm-search)
  - [User Management](#user-management)
    - [npm login](#npm-login)
    - [npm whoami](#npm-whoami)
    - [npm access](#npm-access)
  - [Registry](#registry)
    - [npm config](#npm-config)
    - [Private Registry](#private-registry)
  - [Workspace](#workspace)
    - [npm workspaces](#npm-workspaces)
  - [Troubleshooting](#troubleshooting)
    - [npm cache](#npm-cache)
    - [npm rebuild](#npm-rebuild)
    - [Common Issues](#common-issues)

## Initialization

Create a new project or initialize npm in existing directory.

```bash
npm init                           # Interactive setup
npm init -y                        # Quick setup with defaults
npm init -y my-project             # Create directory and init

# Create specific package type
npm init --scope=@myorg            # Scoped package
npm init --yes --private           # Private package
```

## Installing Packages

### npm install

Install packages from package.json or specific packages.

```bash
# Install all dependencies
npm install
npm i

# Install specific package
npm install lodash
npm i lodash

# Install specific version
npm install lodash@4.17.21
npm i lodash@latest

# Install from GitHub
npm install https://github.com/user/repo
npm install git+https://github.com/user/repo.git

# Install globally
npm install -g create-react-app
npm install --global nodemon

# Install multiple
npm install react react-dom next

# Install all (including dev)
npm install --legacy-peer-deps    # Ignore peer dependency conflicts
```

### Dependency Types

```bash
# Save as dependency (production)
npm install lodash
npm install lodash --save          # Explicit (default in npm 5+)
npm i lodash -S

# Save as dev dependency (development only)
npm install --save-dev eslint
npm i --save-dev prettier
npm i -D vitest

# Save as optional dependency
npm install optional-pkg --save-optional

# Save as peer dependency (for libraries)
npm install react --peer

# Install exact version
npm install lodash@4.17.21 --save-exact
npm i -E lodash@4.17.21
```

### Version Specifiers

```json
{
  "dependencies": {
    "lodash": "4.17.21", // Exact version
    "react": "^18.0.0", // Caret: compatible (18.x.x)
    "vue": "~3.0.0", // Tilde: patch releases (3.0.x)
    "axios": "1.x", // Major.x: latest minor/patch in 1.x
    "express": ">=4.0.0", // Greater than
    "webpack": "4.0.0 - 5.0.0", // Range
    "babel": "*", // Latest
    "jquery": "3.0.0 || 4.0.0" // Or
  }
}
```

## Managing Dependencies

### npm update

Update packages.

```bash
npm update                         # Update all to latest compatible
npm update lodash                  # Update specific package
npm update --global gulp           # Update global package
npm update --save                  # Update and save to package.json
npm outdated                       # See which packages are outdated
```

### npm outdated

Check for outdated packages.

```bash
npm outdated
npm outdated --depth=0             # Top-level only
npm outdated --global              # Global packages
```

### npm audit

Check for security vulnerabilities.

```bash
npm audit                          # Show vulnerabilities
npm audit --json                   # JSON format
npm audit fix                      # Auto-fix vulnerabilities
npm audit fix --force              # Force fix (may break compatibility)
npm audit fix --audit-level=moderate  # Fix only moderate+ severity
```

### npm prune

Remove unused packages.

```bash
npm prune                          # Remove packages not in package.json
npm prune --production             # Remove dev dependencies
```

## Running Scripts

### npm run

Execute scripts defined in package.json.

```bash
npm run build                      # Run build script
npm run dev                        # Run dev script
npm run test                       # Run test script
npm run lint                       # Run lint script

# Common shortcuts (don't need 'run')
npm start                          # npm run start
npm test                           # npm run test
npm stop                           # npm run stop

# Pass arguments
npm run build -- --mode production
npm run test -- --watch

# Run all scripts matching pattern
npm run --list                     # List all available scripts
```

### package.json Scripts

```json
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
```

## Publishing

### npm publish

Publish package to npm registry.

```bash
npm publish                        # Publish current version
npm publish --tag beta             # Publish as beta
npm publish --tag next             # Publish as next version
npm publish --access=public        # Public package
npm publish --access=restricted    # Private package (paid account)

# Publish to custom registry
npm publish --registry https://registry.npmjs.org/
```

### npm version

Bump package version.

```bash
npm version patch                  # 1.0.0 -> 1.0.1
npm version minor                  # 1.0.0 -> 1.1.0
npm version major                  # 1.0.0 -> 2.0.0
npm version 2.1.0                  # Set specific version
npm version --no-git-tag           # Don't create git tag
npm version prepatch               # 1.0.0 -> 1.0.1-0
npm version prerelease             # 1.0.0 -> 1.0.0-0
```

### npm unpublish

Remove package from registry.

```bash
npm unpublish package-name         # Unpublish all versions
npm unpublish package-name@1.0.0   # Unpublish specific version

# Can only unpublish if:
# - Published within 72 hours (not all versions)
# - You're the owner
```

## Package Metadata

### npm info

Get package information.

```bash
npm info lodash                    # Full info
npm info lodash version            # Latest version
npm info lodash versions           # All versions
npm view lodash repository         # Repository URL
npm view lodash homepage           # Homepage
```

### npm list

List installed packages.

```bash
npm list                           # All dependencies (tree)
npm list --depth=0                 # Top-level only
npm list --global                  # Global packages
npm list lodash                    # Specific package
npm list --json                    # JSON format
```

### npm search

Search npm registry.

```bash
npm search react                   # Search by keyword
npm search --json                  # JSON format
npm search --description           # Include descriptions
```

## User Management

### npm login

Authenticate with npm registry.

```bash
npm login                          # Interactive login
npm login --scope=@myorg           # Login for scoped packages

# Set registry
npm login --registry https://my-registry.com
```

### npm whoami

Show logged-in user.

```bash
npm whoami                         # Show username
npm whoami --registry my-registry  # Check other registry
```

### npm access

Manage package access.

```bash
npm access public [<package>]      # Make public
npm access restricted [<package>]  # Make private
npm access grant read-only user pkg  # Grant read-only
npm access revoke user pkg         # Revoke access
npm access ls-packages [user]      # List packages user has access to
npm access ls-collaborators [pkg]  # List collaborators
```

## Registry

### npm config

View and set npm configuration.

```bash
npm config list                    # Show all config
npm config list --json             # JSON format
npm config get registry            # Get registry URL
npm config set registry https://...  # Set registry

# User config
npm config set email user@example.com
npm config set name "Your Name"
npm config set author-name "Your Name"

# Save as defaults
npm config set save=true           # Save dev dependencies by default
npm config set save-exact=true     # Save exact versions

# View config file
cat ~/.npmrc
```

### Private Registry

Setup private npm registry (Nexus, Verdaccio, etc).

```bash
# .npmrc file
registry=https://my-private-registry.com
@myorg:registry=https://my-private-registry.com
//my-private-registry.com:_authToken=YOUR_TOKEN

# Or via command
npm config set registry https://my-private-registry.com
npm config set //my-private-registry.com:_authToken YOUR_TOKEN

# Use in package.json
{
  "publishConfig": {
    "registry": "https://my-private-registry.com"
  }
}
```

## Workspace

### npm workspaces

Manage monorepos with workspaces.

```bash
# package.json (root)
{
  "workspaces": [
    "packages/*",
    "apps/*"
  ]
}

# Install dependencies
npm install                        # Installs all workspaces

# Run in specific workspace
npm run build -w packages/core
npm run test -w apps/web --

# Run in all workspaces
npm run build -ws
npm run test --workspaces

# Install in workspace
npm install lodash -w packages/core

# Add workspace to workspace
npm install @myorg/core -w packages/utils

# List workspaces
npm workspaces list
```

## Troubleshooting

### npm cache

Manage npm cache.

```bash
npm cache clean --force            # Clear entire cache
npm cache verify                   # Verify cache integrity
npm cache ls                       # List cached packages

# Clear specific
rm -rf ~/.npm
```

### npm rebuild

Rebuild packages with native bindings.

```bash
npm rebuild                        # Rebuild all
npm rebuild node-gyp               # Rebuild specific package

# Common when installing on new OS
npm rebuild --verbose              # Show what's happening
```

### Common Issues

```bash
# Permission denied
sudo chown -R $(whoami) ~/.npm
npm config set prefix ~/.npm-global
export PATH=~/.npm-global/bin:$PATH

# Clear node_modules and reinstall
rm -rf node_modules package-lock.json
npm install

# Fix peer dependency issues
npm install --legacy-peer-deps

# Check disk space
npm config set fetch-timeout 120000
npm config set fetch-retry-mintimeout 20000
npm config set fetch-retry-maxtimeout 120000
```
