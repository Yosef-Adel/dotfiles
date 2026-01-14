*env.txt*  Environment Variables Reference

==============================================================================
CONTENTS                                                         *env-contents*

1. Overview .............................. |env-overview|
2. .env File ............................. |env-file|
3. Node.js ............................... |env-nodejs|
4. Python ................................ |env-python|
5. Go .................................... |env-go|
6. Bash .................................. |env-bash|
7. Docker ................................ |env-docker|
8. Common Environment Variables .......... |env-common|
9. Security Best Practices ............... |env-security|

==============================================================================
1. OVERVIEW                                                     *env-overview*

Environment variables provide configuration outside of code~
>
    - Configuration outside of code
    - Different settings for dev/staging/prod
    - Keep secrets out of version control
    - Platform-agnostic configuration
<

==============================================================================
2. .ENV FILE                                                        *env-file*

File format~                                                  *env-file-format*
>
    # .env file format
    KEY=value
    API_KEY=abc123
    DATABASE_URL=postgresql://localhost/mydb
    PORT=3000

    # Comments start with #
    # No spaces around =
    # No quotes needed (usually)
    # One variable per line

    # Common pattern: UPPERCASE_WITH_UNDERSCORES
    NODE_ENV=development
    DATABASE_HOST=localhost
    DATABASE_PORT=5432
    DATABASE_NAME=myapp_dev
    DATABASE_USER=postgres
    DATABASE_PASSWORD=secret
<

Common variables~                                          *env-file-common*
>
    # URLs
    API_URL=https://api.example.com
    FRONTEND_URL=http://localhost:3000

    # Feature flags
    ENABLE_FEATURE_X=true
    DEBUG_MODE=false

    # Secrets
    JWT_SECRET=your-secret-key
    ENCRYPTION_KEY=another-secret

    # Third-party services
    STRIPE_SECRET_KEY=sk_test_...
    SENDGRID_API_KEY=SG....
    AWS_ACCESS_KEY_ID=AKIA...
    AWS_SECRET_ACCESS_KEY=...
<

Gitignore~                                              *env-file-gitignore*
>
    # .gitignore - ALWAYS ignore .env files
    .env
    .env.local
    .env.*.local
<

Example template~                                        *env-file-example*
>
    # .env.example - commit this template
    NODE_ENV=development
    DATABASE_URL=postgresql://localhost/mydb
    API_KEY=your_api_key_here
    JWT_SECRET=your_secret_here
<

==============================================================================
3. NODE.JS                                                       *env-nodejs*

Using dotenv~                                              *env-nodejs-dotenv*
>
    // Using dotenv
    require('dotenv').config();
    // or ES6
    import 'dotenv/config';

    // Access variables
    const port = process.env.PORT || 3000;
    const dbUrl = process.env.DATABASE_URL;
    const apiKey = process.env.API_KEY;

    // Check if variable exists
    if (!process.env.JWT_SECRET) {
      throw new Error('JWT_SECRET is not defined');
    }

    // Type conversion
    const port = parseInt(process.env.PORT) || 3000;
    const debugMode = process.env.DEBUG === 'true';
    const maxRetries = Number(process.env.MAX_RETRIES) || 3;
<

Multiple env files~                                  *env-nodejs-multiple*
>
    // Multiple .env files
    require('dotenv').config({ path: '.env.local' });
    require('dotenv').config({ path: '.env.production' });

    // With different environments
    // .env.development
    // .env.production
    // .env.test
    const envFile = `.env.${process.env.NODE_ENV || 'development'}`;
    require('dotenv').config({ path: envFile });
<

Validation~                                          *env-nodejs-validation*
>
    // Validation
    const requiredEnvVars = ['DATABASE_URL', 'API_KEY', 'JWT_SECRET'];
    const missing = requiredEnvVars.filter(key => !process.env[key]);
    if (missing.length > 0) {
      throw new Error(`Missing env variables: ${missing.join(', ')}`);
    }
<

Config module pattern~                                 *env-nodejs-config*
>
    // config.js
    module.exports = {
      port: process.env.PORT || 3000,
      nodeEnv: process.env.NODE_ENV || 'development',
      database: {
        host: process.env.DB_HOST || 'localhost',
        port: parseInt(process.env.DB_PORT) || 5432,
        name: process.env.DB_NAME,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD
      },
      jwt: {
        secret: process.env.JWT_SECRET,
        expiresIn: process.env.JWT_EXPIRES_IN || '24h'
      },
      isDevelopment: process.env.NODE_ENV === 'development',
      isProduction: process.env.NODE_ENV === 'production',
      isTest: process.env.NODE_ENV === 'test'
    };

    // Usage
    const config = require('./config');
    console.log(config.port);
    console.log(config.database.host);
<

Package.json scripts~                                 *env-nodejs-scripts*
>
    // package.json
    {
      "scripts": {
        "start": "NODE_ENV=production node server.js",
        "dev": "NODE_ENV=development nodemon server.js",
        "test": "NODE_ENV=test jest"
      }
    }
<

==============================================================================
4. PYTHON                                                        *env-python*

Using python-dotenv~                                    *env-python-dotenv*
>
    # Using python-dotenv
    from dotenv import load_dotenv
    import os

    # Load .env file
    load_dotenv()

    # Access variables
    api_key = os.getenv('API_KEY')
    database_url = os.getenv('DATABASE_URL')
    port = int(os.getenv('PORT', 3000))

    # With default value
    debug = os.getenv('DEBUG', 'false').lower() == 'true'

    # Check if exists
    jwt_secret = os.environ['JWT_SECRET']  # Raises error if missing
    # or
    jwt_secret = os.getenv('JWT_SECRET')
    if not jwt_secret:
        raise ValueError('JWT_SECRET is not set')

    # Load specific file
    load_dotenv('.env.production')
<

Config class pattern~                                   *env-python-config*
>
    # config.py
    import os
    from dotenv import load_dotenv

    load_dotenv()

    class Config:
        PORT = int(os.getenv('PORT', 5000))
        DEBUG = os.getenv('DEBUG', 'False').lower() == 'true'
        DATABASE_URI = os.getenv('DATABASE_URL')
        SECRET_KEY = os.getenv('SECRET_KEY')

        @staticmethod
        def init_app(app):
            pass

    class DevelopmentConfig(Config):
        DEBUG = True
        DATABASE_URI = os.getenv('DEV_DATABASE_URL')

    class ProductionConfig(Config):
        DEBUG = False
        DATABASE_URI = os.getenv('PROD_DATABASE_URL')

    config = {
        'development': DevelopmentConfig,
        'production': ProductionConfig,
        'default': DevelopmentConfig
    }

    # Usage
    from config import config
    app_config = config[os.getenv('FLASK_ENV', 'development')]
<

==============================================================================
5. GO                                                                *env-go*

Using godotenv~                                              *env-go-godotenv*
>
    // Using godotenv
    package main

    import (
        "os"
        "log"
        "strconv"
        "github.com/joho/godotenv"
    )

    func main() {
        // Load .env file
        err := godotenv.Load()
        if err != nil {
            log.Fatal("Error loading .env file")
        }

        // Access variables
        port := os.Getenv("PORT")
        dbURL := os.Getenv("DATABASE_URL")
        apiKey := os.Getenv("API_KEY")

        // With default
        if port == "" {
            port = "8080"
        }

        // Type conversion
        maxRetries, err := strconv.Atoi(os.Getenv("MAX_RETRIES"))
        if err != nil {
            maxRetries = 3
        }

        // Boolean
        debug := os.Getenv("DEBUG") == "true"
    }
<

Config struct pattern~                                     *env-go-config*
>
    type Config struct {
        Port         string
        DatabaseURL  string
        JWTSecret    string
        Environment  string
    }

    func LoadConfig() (*Config, error) {
        if err := godotenv.Load(); err != nil {
            return nil, err
        }

        config := &Config{
            Port:         getEnv("PORT", "8080"),
            DatabaseURL:  getEnv("DATABASE_URL", ""),
            JWTSecret:    os.Getenv("JWT_SECRET"),
            Environment:  getEnv("GO_ENV", "development"),
        }

        // Validation
        if config.JWTSecret == "" {
            return nil, errors.New("JWT_SECRET is required")
        }

        return config, nil
    }

    func getEnv(key, fallback string) string {
        if value := os.Getenv(key); value != "" {
            return value
        }
        return fallback
    }
<

==============================================================================
6. BASH                                                            *env-bash*

Load from .env file~                                        *env-bash-load*
>
    # Load from .env file
    export $(cat .env | xargs)

    # Or
    set -a
    source .env
    set +a

    # Access variables
    echo $API_KEY
    echo $DATABASE_URL

    # With default
    PORT=${PORT:-3000}
    NODE_ENV=${NODE_ENV:-development}

    # Check if set
    if [ -z "$API_KEY" ]; then
      echo "API_KEY is not set"
      exit 1
    fi

    # Export for child processes
    export DATABASE_URL=postgresql://localhost/mydb

    # Multiple files
    set -a
    source .env
    source .env.local
    set +a
<

==============================================================================
7. DOCKER                                                        *env-docker*

Dockerfile~                                              *env-docker-dockerfile*
>
    # Dockerfile
    FROM node:18

    # Set environment variables
    ENV NODE_ENV=production
    ENV PORT=3000

    # Copy .env file (not recommended for secrets)
    COPY .env .env

    # Use ARG for build-time variables
    ARG NODE_VERSION=18
    ENV NODE_VERSION=$NODE_VERSION

    CMD ["node", "server.js"]
<

Docker Compose~                                          *env-docker-compose*
>
    # docker-compose.yml
    version: '3.8'

    services:
      app:
        build: .
        environment:
          - NODE_ENV=development
          - PORT=3000
          - DATABASE_URL=postgresql://db:5432/myapp
        env_file:
          - .env
          - .env.local
        # Individual variables
        environment:
          NODE_ENV: ${NODE_ENV:-development}
          DATABASE_URL: ${DATABASE_URL}

      db:
        image: postgres:14
        environment:
          POSTGRES_DB: myapp
          POSTGRES_USER: ${DB_USER}
          POSTGRES_PASSWORD: ${DB_PASSWORD}
<

Docker run~                                                  *env-docker-run*
>
    # Pass env vars to docker run
    docker run -e NODE_ENV=production -e PORT=3000 myapp

    # From file
    docker run --env-file .env myapp

    # From host
    docker run -e API_KEY=$API_KEY myapp
<

==============================================================================
8. COMMON ENVIRONMENT VARIABLES                                  *env-common*

Node.js~                                                  *env-common-nodejs*
>
    NODE_ENV=development|production|test
    PORT=3000
    DEBUG=true
<

Database~                                                *env-common-database*
>
    DATABASE_URL=postgresql://user:pass@host:port/dbname
    DB_HOST=localhost
    DB_PORT=5432
    DB_NAME=myapp
    DB_USER=postgres
    DB_PASSWORD=secret
    MONGODB_URI=mongodb://localhost:27017/myapp
    REDIS_URL=redis://localhost:6379
<

Authentication~                                            *env-common-auth*
>
    JWT_SECRET=your-secret-key
    JWT_EXPIRES_IN=24h
    SESSION_SECRET=session-secret
    COOKIE_SECRET=cookie-secret
<

AWS~                                                        *env-common-aws*
>
    AWS_ACCESS_KEY_ID=AKIA...
    AWS_SECRET_ACCESS_KEY=...
    AWS_REGION=us-east-1
    S3_BUCKET=my-bucket
<

Email~                                                    *env-common-email*
>
    SMTP_HOST=smtp.gmail.com
    SMTP_PORT=587
    SMTP_USER=user@gmail.com
    SMTP_PASSWORD=app-password
    SENDGRID_API_KEY=SG...
    MAILGUN_API_KEY=key-...
<

Payment~                                                *env-common-payment*
>
    STRIPE_SECRET_KEY=sk_test_...
    STRIPE_PUBLISHABLE_KEY=pk_test_...
    PAYPAL_CLIENT_ID=...
    PAYPAL_SECRET=...
<

OAuth~                                                    *env-common-oauth*
>
    GOOGLE_CLIENT_ID=...
    GOOGLE_CLIENT_SECRET=...
    GITHUB_CLIENT_ID=...
    GITHUB_CLIENT_SECRET=...
    FACEBOOK_APP_ID=...
    FACEBOOK_APP_SECRET=...
<

URLs~                                                      *env-common-urls*
>
    API_URL=https://api.example.com
    FRONTEND_URL=http://localhost:3000
    BACKEND_URL=http://localhost:8080
    REDIRECT_URI=http://localhost:3000/auth/callback
<

Logging~                                                *env-common-logging*
>
    LOG_LEVEL=debug|info|warn|error
    LOG_FILE=/var/log/app.log
<

Features~                                              *env-common-features*
>
    ENABLE_ANALYTICS=true
    ENABLE_FEATURE_X=false
    MAINTENANCE_MODE=false
<

Security~                                              *env-common-security*
>
    ALLOWED_ORIGINS=http://localhost:3000,https://example.com
    RATE_LIMIT=100
    CORS_ENABLED=true
<

CI/CD~                                                      *env-common-cicd*
>
    CI=true
    GITHUB_ACTIONS=true
    VERCEL=1
<

==============================================================================
9. SECURITY BEST PRACTICES                                    *env-security*

Never commit .env files~                                *env-security-never*
>
    # Add to .gitignore
    .env
    .env.local
    .env.*.local
<

Use template~                                          *env-security-template*
>
    # .env.example (commit this)
    API_KEY=your_api_key_here
    DATABASE_URL=your_database_url
    JWT_SECRET=your_jwt_secret
<

Rotate secrets~                                         *env-security-rotate*
>
    # Change JWT_SECRET, API keys periodically
<

Different secrets per environment~                *env-security-environments*
>
    # .env.development
    # .env.production
<

Validate at startup~                              *env-security-validation*
>
    const required = ['DATABASE_URL', 'JWT_SECRET'];
    required.forEach(key => {
      if (!process.env[key]) {
        throw new Error(`${key} is required`);
      }
    });
<

Don't log secrets~                                      *env-security-logging*
>
    console.log('DB URL:', process.env.DATABASE_URL); // Bad!
    console.log('DB Host:', process.env.DB_HOST);     // OK
<

Use secrets management~                              *env-security-management*
>
    # Use in production:
    # - AWS Secrets Manager
    # - Azure Key Vault
    # - HashiCorp Vault
    # - Doppler
    # - 1Password Secrets Automation
<

Set permissions~                                    *env-security-permissions*
>
    chmod 600 .env  # Only owner can read/write
<

Validate formats~                                       *env-security-formats*
>
    const url = new URL(process.env.DATABASE_URL); // Throws if invalid
<

Example validation~                                  *env-security-example*
>
    class EnvValidator {
      static validate() {
        const required = {
          PORT: (val) => !isNaN(val) && val > 0,
          DATABASE_URL: (val) => val.startsWith('postgresql://'),
          JWT_SECRET: (val) => val.length >= 32,
          NODE_ENV: (val) => ['development', 'production', 'test'].includes(val)
        };

        const errors = [];

        for (const [key, validator] of Object.entries(required)) {
          const value = process.env[key];

          if (!value) {
            errors.push(`${key} is required`);
          } else if (!validator(value)) {
            errors.push(`${key} has invalid format`);
          }
        }

        if (errors.length > 0) {
          throw new Error(`Environment validation failed:\n${errors.join('\n')}`);
        }
      }
    }

    EnvValidator.validate();
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
