*vite.txt*  Vite Reference

==============================================================================
CONTENTS                                                        *vite-contents*

1. Setup ................................. |vite-setup|
2. Project Structure ..................... |vite-structure|
3. Configuration ......................... |vite-config|
   3.1 vite.config.js .................... |vite-config-file|
   3.2 Common Options .................... |vite-config-options|
4. Development ........................... |vite-dev|
   4.1 Dev Server ........................ |vite-dev-server|
   4.2 HMR ............................... |vite-hmr|
5. Building .............................. |vite-build|
   5.1 Production Build .................. |vite-build-prod|
   5.2 Build Options ..................... |vite-build-options|
6. Environment Variables ................. |vite-env|
   6.1 .env Files ........................ |vite-env-files|
   6.2 Using Environment Variables ....... |vite-env-usage|
7. Assets ................................ |vite-assets|
   7.1 Static Assets ..................... |vite-static|
   7.2 Importing Assets .................. |vite-import|
8. Optimizations ......................... |vite-optimize|
   8.1 Dependency Pre-bundling ........... |vite-pre-bundle|
   8.2 Code Splitting .................... |vite-code-split|
   8.3 Lazy Loading ...................... |vite-lazy-load|
9. Plugins ............................... |vite-plugins|
10. Server ............................... |vite-server|
    10.1 Proxy ........................... |vite-proxy|
    10.2 Middlewares ..................... |vite-middleware|
11. Troubleshooting ...................... |vite-troubleshooting|

==============================================================================
1. SETUP                                                           *vite-setup*

Create new Vite project~
>
    # Create with template
    npm create vite@latest my-app -- --template react
    npm create vite@latest my-app -- --template vue
    npm create vite@latest my-app -- --template svelte
    npm create vite@latest my-app -- --template vanilla
<

Available templates:                                    *vite-templates*
  react, react-ts          React with or without TypeScript
  vue, vue-ts              Vue with or without TypeScript
  svelte, svelte-ts        Svelte with or without TypeScript
  preact, preact-ts        Preact with or without TypeScript
  lit, lit-ts              Lit with or without TypeScript
  vanilla, vanilla-ts      Plain JavaScript/TypeScript

Install and run~
>
    cd my-app
    npm install
    npm run dev
<

==============================================================================
2. PROJECT STRUCTURE                                          *vite-structure*

Typical Vite project structure~
>
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
<

Note: Files in public/ are served at root path and copied as-is to dist/.

==============================================================================
3. CONFIGURATION                                                 *vite-config*

------------------------------------------------------------------------------
3.1 VITE.CONFIG.JS                                         *vite-config-file*

Basic configuration~
>
    import { defineConfig } from 'vite';
    import react from '@vitejs/plugin-react';

    export default defineConfig({
      plugins: [react()],

      // Development server config
      server: {
        port: 3000,
        strictPort: false,
        host: 'localhost',
        open: true,
      },

      // Build configuration
      build: {
        outDir: 'dist',
        sourcemap: false,
        minify: 'terser',
        target: 'esnext',
      },

      // Path resolution
      resolve: {
        alias: {
          '@': '/src',
          '@components': '/src/components',
        },
      },

      // Define global constants
      define: {
        __APP_VERSION__: JSON.stringify('1.0.0'),
      },
    });
<

------------------------------------------------------------------------------
3.2 COMMON OPTIONS                                      *vite-config-options*

Root and base~
>
    export default {
      // Root directory
      root: process.cwd(),

      // Base public path
      base: '/',
      base: '/my-app/',  // Deployed in subdirectory

      // Public directory
      publicDir: 'public',
    };
<

CSS options~                                            *vite-config-css*
>
    css: {
      preprocessorOptions: {
        scss: {
          additionalData: `$injectedColor: orange;`,
        },
      },
    }
<

Server options~                                         *vite-config-server*
>
    server: {
      port: 3000,
      host: '0.0.0.0',
      strictPort: true,
      open: '/welcome.html',
      hmr: {
        host: 'localhost',
        port: 5173,
      },
    }
<

Preview options~                                        *vite-config-preview*
>
    preview: {
      port: 4173,
    }
<

Environment prefix~                                     *vite-config-env*
>
    envPrefix: 'VITE_',  // Only expose vars starting with VITE_
<

==============================================================================
4. DEVELOPMENT                                                      *vite-dev*

------------------------------------------------------------------------------
4.1 DEV SERVER                                              *vite-dev-server*

Start development server~
>
    npm run dev                    # Start dev server (port 5173)
    npm run dev -- --port 3000    # Custom port
    npm run dev -- --host         # Listen on all addresses
    npm run dev -- --strictPort   # Error if port in use
<

------------------------------------------------------------------------------
4.2 HMR                                                            *vite-hmr*

Hot Module Replacement (automatic reload on changes)~

Configure HMR:
>
    export default {
      server: {
        hmr: {
          host: 'localhost',
          port: 5173,
          protocol: 'ws',
        },
      },
    };
<

Manual HMR API~                                         *vite-hmr-api*
>
    if (import.meta.hot) {
      import.meta.hot.accept((newModule) => {
        console.log('Module updated');
      });

      import.meta.hot.dispose(() => {
        console.log('Cleaning up...');
      });
    }
<

Note: HMR is auto-enabled by default in development mode.

==============================================================================
5. BUILDING                                                       *vite-build*

------------------------------------------------------------------------------
5.1 PRODUCTION BUILD                                       *vite-build-prod*

Build for production~
>
    npm run build                 # Build for production
    npm run build -- --mode staging  # Build with different mode
    npm run preview              # Preview production build locally
<

Note: Build outputs to dist/ by default.

------------------------------------------------------------------------------
5.2 BUILD OPTIONS                                       *vite-build-options*

Output configuration~
>
    build: {
      // Output directory
      outDir: 'dist',

      // Clean output dir before build
      emptyOutDir: true,

      // Generate source maps
      sourcemap: true,
      sourcemap: 'hidden',  // For debugging without exposing sources

      // Minification
      minify: 'terser',    // terser (default), esbuild
      minify: false,       // Disable

      // CSS code splitting
      cssCodeSplit: true,

      // CSS minify
      cssMinify: true,

      // Target
      target: 'esnext',
      target: 'es2020',
    }
<

Terser options~                                         *vite-build-terser*
>
    build: {
      terserOptions: {
        compress: {
          drop_console: true,
        },
      },
    }
<

Size limits~                                            *vite-build-limits*
>
    build: {
      // Chunk size warnings
      chunkSizeWarningLimit: 1000,  // KB

      // Asset inline threshold
      assetsInlineLimit: 4096,  // KB

      // Report compressed size
      reportCompressedSize: true,
    }
<

Rollup options~                                         *vite-build-rollup*
>
    build: {
      rollupOptions: {
        output: {
          manualChunks: {
            vendor: ['react', 'react-dom'],
          },
        },
      },
    }
<

==============================================================================
6. ENVIRONMENT VARIABLES                                            *vite-env*

------------------------------------------------------------------------------
6.1 .ENV FILES                                              *vite-env-files*

Environment file structure~
>
    # .env (loaded in all modes)
    VITE_API_URL=https://api.example.com
    VITE_APP_TITLE=My App

    # .env.development (dev only)
    VITE_API_URL=http://localhost:3000

    # .env.production (build only)
    VITE_API_URL=https://api.example.com

    # .env.local (gitignored, all modes)
    VITE_SECRET_KEY=secret123
<

Note: Only variables prefixed with VITE_ are exposed to client code.

------------------------------------------------------------------------------
6.2 USING ENVIRONMENT VARIABLES                             *vite-env-usage*

Access environment variables~
>
    // Must start with VITE_
    console.log(import.meta.env.VITE_API_URL);
    console.log(import.meta.env.VITE_APP_TITLE);
<

Built-in variables~                                     *vite-env-builtin*
>
    console.log(import.meta.env.MODE);    // 'development' or 'production'
    console.log(import.meta.env.DEV);     // true in dev
    console.log(import.meta.env.PROD);    // true in prod
    console.log(import.meta.env.SSR);     // true if SSR
<

TypeScript types~                                       *vite-env-types*
>
    interface ImportMetaEnv {
      readonly VITE_API_URL: string;
      readonly VITE_APP_TITLE: string;
    }

    interface ImportMeta {
      readonly env: ImportMetaEnv;
    }
<

==============================================================================
7. ASSETS                                                        *vite-assets*

------------------------------------------------------------------------------
7.1 STATIC ASSETS                                              *vite-static*

Public directory structure~
>
    public/
    ├── logo.png
    ├── favicon.ico
    └── fonts/
        └── roboto.woff2
<

Note: Files in public/ are served at root path / and copied as-is to dist/.

------------------------------------------------------------------------------
7.2 IMPORTING ASSETS                                            *vite-import*

Import images~                                          *vite-import-images*
>
    import logo from '/src/logo.png';
    const imagePath = new URL('/src/logo.png', import.meta.url).href;

    // URL in template
    <img src="/logo.png" />
<

Import JSON~                                            *vite-import-json*
>
    import data from './data.json';
<

Import CSS~                                             *vite-import-css*
>
    import './style.css';
<

Import with modifiers~                                  *vite-import-modifiers*
>
    // Import as string
    import svgString from './logo.svg?raw';

    // Import as URL
    import svgUrl from './logo.svg?url';

    // Import as worker
    import Worker from './worker.js?worker';
    const worker = new Worker();
<

Dynamic imports~                                        *vite-import-dynamic*
>
    const module = await import('./module.js');
<

==============================================================================
8. OPTIMIZATIONS                                              *vite-optimize*

------------------------------------------------------------------------------
8.1 DEPENDENCY PRE-BUNDLING                                *vite-pre-bundle*

Vite pre-bundles dependencies for faster dev server startup~
>
    optimizeDeps: {
      // Explicitly include dependencies
      include: ['lodash-es'],

      // Exclude from pre-bundling
      exclude: ['my-lib'],

      // Esbuild options
      esbuildOptions: {
        define: {
          global: 'globalThis',
        },
      },
    }
<

------------------------------------------------------------------------------
8.2 CODE SPLITTING                                         *vite-code-split*

Manual chunks~
>
    build: {
      rollupOptions: {
        output: {
          // Manual chunks
          manualChunks: {
            vendor: ['react', 'react-dom'],
            utils: ['lodash', 'axios'],
          },

          // Or function-based
          manualChunks(id) {
            if (id.includes('node_modules')) {
              return 'vendor';
            }
            if (id.includes('src/utils')) {
              return 'utils';
            }
          },
        },
      },
    }
<

------------------------------------------------------------------------------
8.3 LAZY LOADING                                            *vite-lazy-load*

Dynamic imports create separate chunks~
>
    // Vue
    const About = () => import('./About.vue');

    // React.lazy
    const About = React.lazy(() => import('./About'));

    // In route configs
    {
      path: '/about',
      component: () => import('./About.vue'),
    }
<

==============================================================================
9. PLUGINS                                                      *vite-plugins*

Using plugins~
>
    import vue from '@vitejs/plugin-vue';
    import react from '@vitejs/plugin-react';
    import svelte from 'vite-plugin-svelte';

    export default {
      plugins: [vue(), react(), svelte()],
    };
<

Common plugins:                                         *vite-plugins-common*

Vue~
>
    npm install -D @vitejs/plugin-vue
    import vue from '@vitejs/plugin-vue';
<

React~
>
    npm install -D @vitejs/plugin-react
    import react from '@vitejs/plugin-react';
<

Svelte~
>
    npm install -D vite-plugin-svelte
    import svelte from 'vite-plugin-svelte';
<

Compression~
>
    npm install -D vite-plugin-compression
    import compression from 'vite-plugin-compression';
<

Bundle visualizer~
>
    npm install -D rollup-plugin-visualizer
    import { visualizer } from 'rollup-plugin-visualizer';
<

==============================================================================
10. SERVER                                                      *vite-server*

------------------------------------------------------------------------------
10.1 PROXY                                                      *vite-proxy*

Configure proxy for API requests~
>
    server: {
      proxy: {
        '/api': {
          target: 'http://localhost:3001',
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/api/, ''),
        },
        '/socket.io': {
          target: 'ws://localhost:3001',
          ws: true,
        },
      },
    }
<

------------------------------------------------------------------------------
10.2 MIDDLEWARES                                           *vite-middleware*

Custom server middleware~
>
    export default function customPlugin() {
      return {
        name: 'custom',
        configureServer(server) {
          return () => {
            server.middlewares.use((req, res, next) => {
              if (req.url === '/custom') {
                res.end('custom response');
              } else {
                next();
              }
            });
          };
        },
      };
    }
<

==============================================================================
11. TROUBLESHOOTING                                      *vite-troubleshooting*

Clear cache~
>
    rm -rf node_modules/.vite
<

Clear all node_modules~
>
    rm -rf node_modules package-lock.json
    npm install
<

Port already in use~
>
    npm run dev -- --port 3001
<

Build debugging~
>
    npm run build -- --debug
    npm run build -- --sourcemap
<

Common issues:                                          *vite-issues*
- Module not found: Check import paths and file extensions
- HMR issues: Check vite.config.js hmr configuration
- Slow startup: Check optimizeDeps configuration

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
