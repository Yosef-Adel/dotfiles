*auth.txt*  Authentication & Authorization Reference

==============================================================================
CONTENTS                                                         *auth-contents*

1. Authentication vs Authorization ....... |auth-overview|
2. JWT (JSON Web Tokens) ................. |auth-jwt|
3. Session-Based Auth .................... |auth-session|
4. OAuth 2.0 ............................. |auth-oauth|
5. API Keys .............................. |auth-api-keys|
6. Password Hashing ...................... |auth-passwords|
7. CORS .................................. |auth-cors|
8. CSRF Protection ....................... |auth-csrf|
9. Rate Limiting ......................... |auth-rate-limiting|
10. Security Best Practices .............. |auth-security|

==============================================================================
1. AUTHENTICATION VS AUTHORIZATION                            *auth-overview*

Definitions~                                           *auth-overview-definitions*
>
    Authentication: Who are you?
    - Verifying identity
    - Login with username/password
    - Token validation

    Authorization: What can you do?
    - Verifying permissions
    - Role-based access control (RBAC)
    - Resource-level permissions
<

==============================================================================
2. JWT (JSON WEB TOKENS)                                          *auth-jwt*

Structure~                                                  *auth-jwt-structure*
>
    Structure: header.payload.signature

    Header: Algorithm and token type
    Payload: Claims (user data)
    Signature: Verification hash
<

JWT example~                                                  *auth-jwt-example*
>
    // JWT structure
    {
      // Header
      "alg": "HS256",
      "typ": "JWT"
    }
    {
      // Payload
      "sub": "1234567890",
      "name": "John Doe",
      "iat": 1516239022,
      "exp": 1516242622
    }
<

Creating JWT~                                                *auth-jwt-creating*
>
    // Creating JWT (Node.js with jsonwebtoken)
    const jwt = require('jsonwebtoken');

    const token = jwt.sign(
      {
        userId: user.id,
        email: user.email,
        role: user.role
      },
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );
<

Verifying JWT~                                              *auth-jwt-verifying*
>
    // Verifying JWT
    try {
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      console.log(decoded.userId);
    } catch (error) {
      console.error('Invalid token');
    }
<

Middleware~                                                *auth-jwt-middleware*
>
    // Middleware
    const authenticateToken = (req, res, next) => {
      const authHeader = req.headers['authorization'];
      const token = authHeader && authHeader.split(' ')[1]; // Bearer TOKEN

      if (!token) {
        return res.status(401).json({ error: 'No token provided' });
      }

      jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) {
          return res.status(403).json({ error: 'Invalid token' });
        }
        req.user = user;
        next();
      });
    };

    // Using middleware
    app.get('/api/protected', authenticateToken, (req, res) => {
      res.json({ data: 'Protected data', user: req.user });
    });
<

Refresh tokens~                                         *auth-jwt-refresh-tokens*
>
    const generateAccessToken = (user) => {
      return jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, {
        expiresIn: '15m'
      });
    };

    const generateRefreshToken = (user) => {
      return jwt.sign(user, process.env.REFRESH_TOKEN_SECRET, {
        expiresIn: '7d'
      });
    };

    // Login endpoint
    app.post('/login', async (req, res) => {
      const { email, password } = req.body;
      const user = await authenticateUser(email, password);

      if (!user) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }

      const accessToken = generateAccessToken({ id: user.id, email: user.email });
      const refreshToken = generateRefreshToken({ id: user.id });

      // Store refresh token in database
      await storeRefreshToken(user.id, refreshToken);

      res.json({
        accessToken,
        refreshToken,
        expiresIn: 900 // 15 minutes
      });
    });
<

Client-side usage~                                       *auth-jwt-client-side*
>
    // Store tokens
    localStorage.setItem('accessToken', accessToken);
    localStorage.setItem('refreshToken', refreshToken);

    // Include in requests
    fetch('/api/protected', {
      headers: {
        'Authorization': `Bearer ${localStorage.getItem('accessToken')}`
      }
    });

    // Auto-refresh on 401
    async function fetchWithAuth(url, options = {}) {
      let response = await fetch(url, {
        ...options,
        headers: {
          ...options.headers,
          'Authorization': `Bearer ${localStorage.getItem('accessToken')}`
        }
      });

      if (response.status === 401) {
        // Try to refresh token
        const refreshResponse = await fetch('/token/refresh', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({
            refreshToken: localStorage.getItem('refreshToken')
          })
        });

        if (refreshResponse.ok) {
          const { accessToken } = await refreshResponse.json();
          localStorage.setItem('accessToken', accessToken);

          // Retry original request
          response = await fetch(url, {
            ...options,
            headers: {
              ...options.headers,
              'Authorization': `Bearer ${accessToken}`
            }
          });
        }
      }

      return response;
    }
<

==============================================================================
3. SESSION-BASED AUTH                                           *auth-session*

Using express-session~                                    *auth-session-setup*
>
    // Using express-session
    const session = require('express-session');
    const RedisStore = require('connect-redis')(session);

    app.use(session({
      store: new RedisStore({ client: redisClient }),
      secret: process.env.SESSION_SECRET,
      resave: false,
      saveUninitialized: false,
      cookie: {
        secure: true, // HTTPS only
        httpOnly: true, // No JavaScript access
        maxAge: 24 * 60 * 60 * 1000, // 24 hours
        sameSite: 'strict' // CSRF protection
      }
    }));
<

Login/Logout~                                           *auth-session-login*
>
    // Login
    app.post('/login', async (req, res) => {
      const { email, password } = req.body;
      const user = await authenticateUser(email, password);

      if (!user) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }

      req.session.userId = user.id;
      req.session.email = user.email;
      req.session.role = user.role;

      res.json({ success: true });
    });

    // Logout
    app.post('/logout', (req, res) => {
      req.session.destroy((err) => {
        if (err) {
          return res.status(500).json({ error: 'Logout failed' });
        }
        res.clearCookie('connect.sid');
        res.json({ success: true });
      });
    });
<

Protected routes~                                   *auth-session-protected*
>
    // Protected route
    app.get('/api/protected', (req, res) => {
      if (!req.session.userId) {
        return res.status(401).json({ error: 'Not authenticated' });
      }

      res.json({ data: 'Protected data' });
    });

    // Auth middleware
    const requireAuth = (req, res, next) => {
      if (!req.session.userId) {
        return res.status(401).json({ error: 'Not authenticated' });
      }
      next();
    };

    app.get('/api/protected', requireAuth, (req, res) => {
      res.json({ data: 'Protected data' });
    });
<

==============================================================================
4. OAUTH 2.0                                                     *auth-oauth*

OAuth flows~                                               *auth-oauth-flows*
>
    OAuth Flows:
    1. Authorization Code (most common)
    2. Implicit (deprecated)
    3. Client Credentials
    4. Resource Owner Password Credentials

    Roles:
    - Resource Owner: User
    - Client: Your application
    - Authorization Server: OAuth provider (Google, GitHub, etc.)
    - Resource Server: API with protected resources
<

Authorization Code Flow~                                *auth-oauth-code-flow*
>
    // 1. Redirect to authorization URL
    app.get('/auth/google', (req, res) => {
      const authUrl = `https://accounts.google.com/o/oauth2/v2/auth?` +
        `client_id=${CLIENT_ID}&` +
        `redirect_uri=${REDIRECT_URI}&` +
        `response_type=code&` +
        `scope=openid email profile&` +
        `state=${generateState()}`;

      res.redirect(authUrl);
    });

    // 2. Handle callback
    app.get('/auth/callback', async (req, res) => {
      const { code, state } = req.query;

      // Verify state to prevent CSRF
      if (!verifyState(state)) {
        return res.status(400).send('Invalid state');
      }

      // Exchange code for tokens
      const tokenResponse = await fetch('https://oauth2.googleapis.com/token', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: new URLSearchParams({
          code,
          client_id: CLIENT_ID,
          client_secret: CLIENT_SECRET,
          redirect_uri: REDIRECT_URI,
          grant_type: 'authorization_code'
        })
      });

      const tokens = await tokenResponse.json();
      // tokens.access_token, tokens.refresh_token, tokens.id_token

      // Get user info
      const userResponse = await fetch('https://www.googleapis.com/oauth2/v2/userinfo', {
        headers: { 'Authorization': `Bearer ${tokens.access_token}` }
      });

      const user = await userResponse.json();

      // Create session or JWT
      req.session.userId = user.id;
      res.redirect('/dashboard');
    });
<

Using Passport.js~                                      *auth-oauth-passport*
>
    // Using Passport.js (easier)
    const passport = require('passport');
    const GoogleStrategy = require('passport-google-oauth20').Strategy;

    passport.use(new GoogleStrategy({
        clientID: process.env.GOOGLE_CLIENT_ID,
        clientSecret: process.env.GOOGLE_CLIENT_SECRET,
        callbackURL: "/auth/google/callback"
      },
      (accessToken, refreshToken, profile, done) => {
        // Find or create user
        User.findOrCreate({ googleId: profile.id }, (err, user) => {
          return done(err, user);
        });
      }
    ));

    app.get('/auth/google',
      passport.authenticate('google', { scope: ['profile', 'email'] })
    );

    app.get('/auth/google/callback',
      passport.authenticate('google', { failureRedirect: '/login' }),
      (req, res) => {
        res.redirect('/dashboard');
      }
    );
<

==============================================================================
5. API KEYS                                                   *auth-api-keys*

Generating API keys~                                 *auth-api-keys-generate*
>
    // Generating API keys
    const crypto = require('crypto');

    const generateApiKey = () => {
      return crypto.randomBytes(32).toString('hex');
    };

    // Storing API keys (hashed)
    const apiKey = generateApiKey();
    const hashedKey = crypto
      .createHash('sha256')
      .update(apiKey)
      .digest('hex');

    await db.apiKeys.insert({
      userId: user.id,
      keyHash: hashedKey,
      createdAt: new Date()
    });

    // Return to user (only once!)
    res.json({ apiKey });
<

Validating API keys~                                *auth-api-keys-validate*
>
    // Validating API keys
    const validateApiKey = async (req, res, next) => {
      const apiKey = req.headers['x-api-key'];

      if (!apiKey) {
        return res.status(401).json({ error: 'API key required' });
      }

      const hashedKey = crypto
        .createHash('sha256')
        .update(apiKey)
        .digest('hex');

      const key = await db.apiKeys.findOne({ keyHash: hashedKey });

      if (!key) {
        return res.status(403).json({ error: 'Invalid API key' });
      }

      req.userId = key.userId;
      next();
    };

    // Usage
    app.get('/api/data', validateApiKey, (req, res) => {
      res.json({ data: 'Protected data' });
    });

    // Client usage
    fetch('/api/data', {
      headers: {
        'X-API-Key': 'your-api-key-here'
      }
    });
<

==============================================================================
6. PASSWORD HASHING                                          *auth-passwords*

Using bcrypt~                                          *auth-passwords-bcrypt*
>
    // Using bcrypt
    const bcrypt = require('bcrypt');

    // Hashing password
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    // Verifying password
    const isValid = await bcrypt.compare(password, hashedPassword);
<

Registration~                                    *auth-passwords-registration*
>
    // Registration
    app.post('/register', async (req, res) => {
      const { email, password } = req.body;

      // Validate password strength
      if (password.length < 8) {
        return res.status(400).json({ error: 'Password too short' });
      }

      const hashedPassword = await bcrypt.hash(password, 10);

      const user = await db.users.insert({
        email,
        password: hashedPassword
      });

      res.json({ success: true, userId: user.id });
    });
<

Login~                                                  *auth-passwords-login*
>
    // Login
    app.post('/login', async (req, res) => {
      const { email, password } = req.body;

      const user = await db.users.findOne({ email });

      if (!user) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }

      const isValid = await bcrypt.compare(password, user.password);

      if (!isValid) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }

      const token = jwt.sign({ id: user.id, email: user.email }, JWT_SECRET);
      res.json({ token });
    });
<

==============================================================================
7. CORS                                                           *auth-cors*

Using cors middleware~                                      *auth-cors-basic*
>
    // Using cors middleware
    const cors = require('cors');

    // Allow all origins (development only)
    app.use(cors());

    // Specific origin
    app.use(cors({
      origin: 'https://example.com'
    }));

    // Multiple origins
    app.use(cors({
      origin: ['https://example.com', 'https://app.example.com']
    }));
<

Dynamic origin~                                          *auth-cors-dynamic*
>
    // Dynamic origin
    app.use(cors({
      origin: (origin, callback) => {
        const allowedOrigins = ['https://example.com', 'https://app.example.com'];
        if (!origin || allowedOrigins.includes(origin)) {
          callback(null, true);
        } else {
          callback(new Error('Not allowed by CORS'));
        }
      }
    }));

    // With credentials
    app.use(cors({
      origin: 'https://example.com',
      credentials: true
    }));
<

Manual CORS headers~                                      *auth-cors-manual*
>
    // Manual CORS headers
    app.use((req, res, next) => {
      res.header('Access-Control-Allow-Origin', '*');
      res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
      res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');

      if (req.method === 'OPTIONS') {
        return res.sendStatus(200);
      }
      next();
    });
<

==============================================================================
8. CSRF PROTECTION                                               *auth-csrf*

Using csurf~                                              *auth-csrf-csurf*
>
    // Using csurf
    const csurf = require('csurf');
    const csrfProtection = csurf({ cookie: true });

    app.use(csrfProtection);

    // Send CSRF token to client
    app.get('/form', (req, res) => {
      res.render('form', { csrfToken: req.csrfToken() });
    });

    // Verify CSRF token
    app.post('/submit', csrfProtection, (req, res) => {
      res.json({ success: true });
    });
<

HTML form~                                                *auth-csrf-html*
>
    <!-- In HTML form -->
    <form method="POST">
      <input type="hidden" name="_csrf" value="<%= csrfToken %>">
      <button type="submit">Submit</button>
    </form>
<

With AJAX~                                                *auth-csrf-ajax*
>
    // With AJAX
    fetch('/submit', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'CSRF-Token': csrfToken
      },
      body: JSON.stringify(data)
    });
<

==============================================================================
9. RATE LIMITING                                         *auth-rate-limiting*

Using express-rate-limit~                         *auth-rate-limiting-basic*
>
    // Using express-rate-limit
    const rateLimit = require('express-rate-limit');

    const limiter = rateLimit({
      windowMs: 15 * 60 * 1000, // 15 minutes
      max: 100, // Limit each IP to 100 requests per windowMs
      message: 'Too many requests, please try again later.'
    });

    app.use('/api/', limiter);
<

Login rate limiting~                              *auth-rate-limiting-login*
>
    // Stricter limit for login
    const loginLimiter = rateLimit({
      windowMs: 15 * 60 * 1000,
      max: 5,
      message: 'Too many login attempts, please try again later.'
    });

    app.post('/login', loginLimiter, async (req, res) => {
      // Login logic
    });
<

Custom key generator~                           *auth-rate-limiting-custom*
>
    // Custom key generator (by user ID)
    const userLimiter = rateLimit({
      windowMs: 15 * 60 * 1000,
      max: 100,
      keyGenerator: (req) => req.user?.id || req.ip
    });
<

==============================================================================
10. SECURITY BEST PRACTICES                                  *auth-security*

Security checklist~                                 *auth-security-checklist*
>
    1. Use HTTPS only
    2. Store secrets in environment variables
    const JWT_SECRET = process.env.JWT_SECRET;

    3. Validate and sanitize input
    const validator = require('validator');

    if (!validator.isEmail(email)) {
      return res.status(400).json({ error: 'Invalid email' });
    }

    4. Use security headers (helmet)
    const helmet = require('helmet');
    app.use(helmet());

    5. Implement rate limiting (see above)

    6. Use secure cookies
    res.cookie('token', token, {
      httpOnly: true,
      secure: true,
      sameSite: 'strict',
      maxAge: 24 * 60 * 60 * 1000
    });

    7. Hash passwords (never store plain text)
    // See password hashing section

    8. Implement proper error handling (don't leak info)
    // Bad
    res.status(401).json({ error: 'User john@example.com not found' });

    // Good
    res.status(401).json({ error: 'Invalid credentials' });

    9. Use parameterized queries (prevent SQL injection)
    const result = await db.query('SELECT * FROM users WHERE id = $1', [userId]);

    10. Validate JWTs properly
    // Check expiration, signature, issuer, audience

    11. Implement logout (invalidate tokens)
    // Store tokens in database or use short expiration

    12. Use secure random for tokens
    const crypto = require('crypto');
    const token = crypto.randomBytes(32).toString('hex');

    13. Implement account lockout after failed attempts
    let failedAttempts = 0;
    const maxAttempts = 5;

    if (failedAttempts >= maxAttempts) {
      return res.status(429).json({ error: 'Account locked' });
    }

    14. Use password strength requirements
    // Min length, uppercase, lowercase, numbers, special chars

    15. Implement 2FA (two-factor authentication)
    // TOTP, SMS, email verification
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
