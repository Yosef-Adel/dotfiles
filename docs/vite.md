# Vite Reference

Quick reference for Vite (modern frontend bundler). Use `/` to search in vim.

## Table of Contents

- [Vite Reference](#vite-reference)
  - [Table of Contents](#table-of-contents)
  - [Setup](#setup)
  - [Project Structure](#project-structure)
  - [Configuration](#configuration)
    - [vite.config.js](#viteconfigjs)
    - [Common Options](#common-options)
  - [Development](#development)
    - [Dev Server](#dev-server)
    - [HMR](#hmr)
  - [Building](#building)
    - [Production Build](#production-build)
    - [Build Options](#build-options)
  - [Environment Variables](#environment-variables)
    - [.env Files](#env-files)
    - [Using Environment Variables](#using-environment-variables)
  - [Assets](#assets)
    - [Static Assets](#static-assets)
    - [Importing Assets](#importing-assets)
  - [Optimizations](#optimizations)
    - [Dependency Pre-bundling](#dependency-pre-bundling)
    - [Code Splitting](#code-splitting)
    - [Lazy Loading](#lazy-loading)
  - [Plugins](#plugins)
    - [Using Plugins](#using-plugins)
    - [Common Plugins](#common-plugins)
  - [Server](#server)
    - [Proxy](#proxy)
    - [Middlewares](#middlewares)
  - [Troubleshooting](#troubleshooting)

## Setup

Create new Vite project.

```bash
# Create with template
npm create vite@latest my-app -- --template react
npm create vite@latest my-app -- --template vue
npm create vite@latest my-app -- --template svelte
npm create vite@latest my-app -- --template vanilla

# Available templates
# react, react-ts, vue, vue-ts, svelte, svelte-ts,
# preact, preact-ts, lit, lit-ts, vanilla, vanilla-ts

# Install and run
cd my-app
npm install
npm run dev
```

## Project Structure

```
my-app/
├── src/
│   ├── main.js              # Entry point
│   ├── index.html           # HTML template
│   └── components/
├── public/                  # Static assets (copied as-is)
├── vite.config.js          # Vite configuration
├── package.json
├── .env                    # Environment variables
└── dist/                   # Build output (generated)
```

## Configuration

### vite.config.js

```javascript
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import vue from "@vitejs/plugin-vue";

export default defineConfig({
  plugins: [react()],

  // Development server config
  server: {
    port: 3000,
    strictPort: false,
    host: "localhost",
    open: true,
  },

  // Build configuration
  build: {
    outDir: "dist",
    sourcemap: false,
    minify: "terser",
    target: "esnext",
  },

  // Path resolution
  resolve: {
    alias: {
      "@": "/src",
      "@components": "/src/components",
    },
  },

  // Define global constants
  define: {
    __APP_VERSION__: JSON.stringify("1.0.0"),
  },
});
```

### Common Options

```javascript
export default {
  // Root directory
  root: process.cwd(),

  // Base public path
  base: "/",
  base: "/my-app/", // Deployed in subdirectory

  // Public directory
  publicDir: "public",

  // CSS options
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: `$injectedColor: orange;`,
      },
    },
  },

  // Server
  server: {
    port: 3000,
    host: "0.0.0.0",
    strictPort: true,
    open: "/welcome.html",
    hmr: {
      host: "localhost",
      port: 5173,
    },
  },

  // Preview (after build)
  preview: {
    port: 4173,
  },

  // Logging
  logLevel: "info",

  // Environment
  envPrefix: "VITE_",
};
```

## Development

### Dev Server

```bash
npm run dev                    # Start dev server (port 5173)
npm run dev -- --port 3000    # Custom port
npm run dev -- --host         # Listen on all addresses
npm run dev -- --strictPort   # Error if port in use
```

### HMR

Hot Module Replacement (automatic reload on changes).

```javascript
// Auto-enabled by default
// Configure if needed
export default {
  server: {
    hmr: {
      host: "localhost",
      port: 5173,
      protocol: "ws",
    },
  },
};

// Manual HMR
if (import.meta.hot) {
  import.meta.hot.accept((newModule) => {
    console.log("Module updated");
  });

  import.meta.hot.dispose(() => {
    console.log("Cleaning up...");
  });
}
```

## Building

### Production Build

```bash
npm run build                 # Build for production
npm run build -- --mode staging  # Build with different mode
npm run preview              # Preview production build locally

# Build outputs to dist/
```

### Build Options

```javascript
export default {
  build: {
    // Output directory
    outDir: "dist",

    // Clean output dir before build
    emptyOutDir: true,

    // Generate source maps
    sourcemap: true,
    sourcemap: "hidden", // For debugging without exposing sources

    // Minification
    minify: "terser", // terser (default), esbuild
    minify: false, // Disable

    // CSS code splitting
    cssCodeSplit: true,

    // Terser options
    terserOptions: {
      compress: {
        drop_console: true,
      },
    },

    // Chunk size warnings
    chunkSizeWarningLimit: 1000, // KB

    // Asset inline threshold
    assetsInlineLimit: 4096, // KB

    // Report compressed size
    reportCompressedSize: true,

    // Rollup options
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ["react", "react-dom"],
        },
      },
    },

    // CSS minify
    cssMinify: true,

    // Target
    target: "esnext",
    target: "es2020",
  },
};
```

## Environment Variables

### .env Files

```bash
# .env (loaded in all modes)
VITE_API_URL=https://api.example.com
VITE_APP_TITLE=My App

# .env.development (dev only)
VITE_API_URL=http://localhost:3000

# .env.production (build only)
VITE_API_URL=https://api.example.com

# .env.local (gitignored, all modes)
VITE_SECRET_KEY=secret123
```

### Using Environment Variables

```javascript
// Must start with VITE_
console.log(import.meta.env.VITE_API_URL)
console.log(import.meta.env.VITE_APP_TITLE)

// Built-in variables
console.log(import.meta.env.MODE)           // 'development' or 'production'
console.log(import.meta.env.DEV)            // true in dev
console.log(import.meta.env.PROD)           // true in prod
console.log(import.meta.env.SSR)            // true if SSR

// Type checking
interface ImportMetaEnv {
  readonly VITE_API_URL: string
  readonly VITE_APP_TITLE: string
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
```

## Assets

### Static Assets

```
public/
├── logo.png
├── favicon.ico
└── fonts/
    └── roboto.woff2
```

Files in `public/` are served at root path `/` and copied as-is to `dist/`.

### Importing Assets

```javascript
// Import images
import logo from '/src/logo.png'
const imagePath = new URL('/src/logo.png', import.meta.url).href

// URL in template
<img src="/logo.png" />

// Import JSON
import data from './data.json'

// Import CSS
import './style.css'

// Import as string
import svgString from './logo.svg?raw'

// Import as URL
import svgUrl from './logo.svg?url'

// Import as worker
import Worker from './worker.js?worker'
const worker = new Worker()

// Dynamic import
const module = await import('./module.js')
```

## Optimizations

### Dependency Pre-bundling

Vite pre-bundles dependencies for faster dev server startup.

```javascript
export default {
  optimizeDeps: {
    // Explicitly include dependencies
    include: ["lodash-es"],

    // Exclude from pre-bundling
    exclude: ["my-lib"],

    // Esbuild options
    esbuildOptions: {
      define: {
        global: "globalThis",
      },
    },
  },
};
```

### Code Splitting

```javascript
export default {
  build: {
    rollupOptions: {
      output: {
        // Manual chunks
        manualChunks: {
          vendor: ["react", "react-dom"],
          utils: ["lodash", "axios"],
        },

        // Or function-based
        manualChunks(id) {
          if (id.includes("node_modules")) {
            return "vendor";
          }
          if (id.includes("src/utils")) {
            return "utils";
          }
        },
      },
    },
  },
};
```

### Lazy Loading

```javascript
// Dynamic imports create separate chunks
const About = () => import('./About.vue')

// React.lazy
const About = React.lazy(() => import('./About'))

// In route configs
{
  path: '/about',
  component: () => import('./About.vue'),
}
```

## Plugins

### Using Plugins

```javascript
import vue from "@vitejs/plugin-vue";
import react from "@vitejs/plugin-react";
import svelte from "vite-plugin-svelte";

export default {
  plugins: [vue(), react(), svelte()],
};
```

### Common Plugins

```javascript
// Vue
npm install -D @vitejs/plugin-vue
import vue from '@vitejs/plugin-vue'

// React
npm install -D @vitejs/plugin-react
import react from '@vitejs/plugin-react'

// Svelte
npm install -D vite-plugin-svelte
import svelte from 'vite-plugin-svelte'

// Vue JSX
npm install -D @vitejs/plugin-vue-jsx
import vueJsx from '@vitejs/plugin-vue-jsx'

// Compression
npm install -D vite-plugin-compression
import compression from 'vite-plugin-compression'

// Visualizer
npm install -D rollup-plugin-visualizer
import { visualizer } from 'rollup-plugin-visualizer'

// Mock data
npm install -D vite-plugin-mock
import { createMockServer } from 'vite-plugin-mock'
```

## Server

### Proxy

```javascript
export default {
  server: {
    proxy: {
      "/api": {
        target: "http://localhost:3001",
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, ""),
      },
      "/socket.io": {
        target: "ws://localhost:3001",
        ws: true,
      },
    },
  },
};
```

### Middlewares

```javascript
export default {
  server: {
    middlewares: [
      // Custom middleware
      {
        // Middleware here
      },
    ],
  },
}

// Or in plugin
export default function customPlugin() {
  return {
    name: 'custom',
    configureServer(server) {
      return () => {
        server.middlewares.use((req, res, next) => {
          if (req.url === '/custom') {
            res.end('custom response')
          } else {
            next()
          }
        })
      }
    },
  }
}
```

## Troubleshooting

```bash
# Clear cache
rm -rf node_modules/.vite

# Clear all node_modules
rm -rf node_modules package-lock.json
npm install

# Port already in use
npm run dev -- --port 3001

# Module not found
# Check import paths and file extensions

# HMR issues
# Check vite.config.js hmr configuration

# Build issues
npm run build -- --debug
npm run build -- --sourcemap

# Slow startup
# Check optimizeDeps configuration in vite.config.js
```
