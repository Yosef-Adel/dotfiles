# HTTP Reference

Quick reference for HTTP methods, status codes, and headers.

## Table of Contents

- [HTTP Methods](#http-methods)
- [Status Codes](#status-codes)
  - [1xx Informational](#1xx-informational)
  - [2xx Success](#2xx-success)
  - [3xx Redirection](#3xx-redirection)
  - [4xx Client Error](#4xx-client-error)
  - [5xx Server Error](#5xx-server-error)
- [Common Request Headers](#common-request-headers)
- [Common Response Headers](#common-response-headers)
- [Content Types](#content-types)
- [CORS Headers](#cors-headers)
- [Cache Control](#cache-control)

## HTTP Methods

| Method  | Purpose              | Safe | Idempotent | Has Body |
| ------- | -------------------- | ---- | ---------- | -------- |
| GET     | Retrieve resource    | ✅   | ✅         | ❌       |
| HEAD    | Like GET but no body | ✅   | ✅         | ❌       |
| POST    | Create resource      | ❌   | ❌         | ✅       |
| PUT     | Replace resource     | ❌   | ✅         | ✅       |
| PATCH   | Partial update       | ❌   | ❌         | ✅       |
| DELETE  | Delete resource      | ❌   | ✅         | ❌       |
| OPTIONS | Get allowed methods  | ✅   | ✅         | ❌       |

**Safe** = Doesn't modify server state  
**Idempotent** = Multiple requests = same as single request

```javascript
// Examples
GET / users; // Get all users
POST / users; // Create new user
GET / users / 1; // Get specific user
PUT / users / 1; // Replace user
PATCH / users / 1; // Update user fields
DELETE / users / 1; // Delete user
```

## Status Codes

### 1xx Informational

| Code | Name                | Meaning                             |
| ---- | ------------------- | ----------------------------------- |
| 100  | Continue            | Client should continue request      |
| 101  | Switching Protocols | Protocol upgrade (HTTP → WebSocket) |

### 2xx Success

| Code | Name            | Meaning                            |
| ---- | --------------- | ---------------------------------- |
| 200  | OK              | Request succeeded                  |
| 201  | Created         | Resource created (POST)            |
| 202  | Accepted        | Request accepted, processing async |
| 204  | No Content      | Success but no response body       |
| 206  | Partial Content | Partial resource (range request)   |

### 3xx Redirection

| Code | Name               | Meaning                             |
| ---- | ------------------ | ----------------------------------- |
| 300  | Multiple Choices   | Multiple options available          |
| 301  | Moved Permanently  | Resource moved, use new URL forever |
| 302  | Found              | Resource moved temporarily          |
| 304  | Not Modified       | Cached version is valid             |
| 307  | Temporary Redirect | Temporary redirect, preserve method |
| 308  | Permanent Redirect | Permanent redirect, preserve method |

### 4xx Client Error

| Code | Name                 | Meaning                              |
| ---- | -------------------- | ------------------------------------ |
| 400  | Bad Request          | Invalid request syntax               |
| 401  | Unauthorized         | Authentication required              |
| 403  | Forbidden            | Authenticated but not allowed        |
| 404  | Not Found            | Resource doesn't exist               |
| 405  | Method Not Allowed   | HTTP method not supported            |
| 409  | Conflict             | Request conflicts with state         |
| 422  | Unprocessable Entity | Request well-formed but invalid data |
| 429  | Too Many Requests    | Rate limited                         |

### 5xx Server Error

| Code | Name                  | Meaning                        |
| ---- | --------------------- | ------------------------------ |
| 500  | Internal Server Error | Generic server error           |
| 501  | Not Implemented       | Feature not implemented        |
| 502  | Bad Gateway           | Invalid response from upstream |
| 503  | Service Unavailable   | Server overloaded/down         |
| 504  | Gateway Timeout       | Upstream took too long         |

## Common Request Headers

```javascript
// Authentication
Authorization: "Bearer token_here"
Authorization: "Basic base64_encoded"

// Content
Content-Type: "application/json"
Content-Type: "application/x-www-form-urlencoded"
Content-Type: "multipart/form-data; boundary=..."
Content-Length: 1234

// Caching
If-Modified-Since: "Wed, 21 Oct 2025 07:28:00 GMT"
If-None-Match: "W/\"abc123\"" // ETag
Cache-Control: "no-cache, no-store"

// Cookies
Cookie: "session=abc123; user=john"

// Request info
Host: "example.com"
User-Agent: "Mozilla/5.0..."
Referer: "https://example.com/page"
Accept: "application/json"
Accept-Language: "en-US,en;q=0.9"
Accept-Encoding: "gzip, deflate"

// CORS (cross-origin)
Origin: "https://another-site.com"

// Other
X-Requested-With: "XMLHttpRequest"
X-Forwarded-For: "192.168.1.1" // Client IP
```

## Common Response Headers

```javascript
// Content
Content-Type: "application/json; charset=utf-8"
Content-Length: 1234
Content-Encoding: "gzip"
Content-Disposition: "attachment; filename=data.csv"

// Caching
Cache-Control: "max-age=3600, public"
Cache-Control: "no-cache, must-revalidate"
Cache-Control: "private, max-age=0" // Don't cache
ETag: "W/\"abc123\""
Last-Modified: "Wed, 21 Oct 2025 07:28:00 GMT"
Expires: "Wed, 21 Oct 2026 07:28:00 GMT"

// Cookies
Set-Cookie: "session=abc123; Path=/; HttpOnly; Secure; SameSite=Strict"
Set-Cookie: "user=john; Max-Age=3600"

// CORS
Access-Control-Allow-Origin: "*"
Access-Control-Allow-Origin: "https://example.com"
Access-Control-Allow-Methods: "GET, POST, PUT, DELETE"
Access-Control-Allow-Headers: "Content-Type, Authorization"
Access-Control-Allow-Credentials: "true"
Access-Control-Max-Age: "86400"

// Security
Strict-Transport-Security: "max-age=31536000"
X-Content-Type-Options: "nosniff"
X-Frame-Options: "SAMEORIGIN"
X-XSS-Protection: "1; mode=block"
Content-Security-Policy: "default-src 'self'"

// Other
Location: "https://example.com/new-url" // Redirect
Retry-After: "120" // Retry in 120 seconds
Server: "nginx/1.21"
Date: "Wed, 21 Oct 2025 07:28:00 GMT"
Vary: "Accept-Encoding" // Cache varies by this header
```

## Content Types

```javascript
// Text
text / plain;
text / html;
text / css;
text / javascript; // Old, use application/javascript

// Application
application / json;
application / xml;
application / pdf;
application / zip;
application / octet - stream; // Binary file

// Form data
application / x - www - form - urlencoded; // Default form submission
multipart / form - data; // File uploads

// Images
image / png;
image / jpeg;
image / gif;
image / svg + xml;
image / webp;

// Audio/Video
audio / mpeg;
audio / ogg;
video / mp4;
video / webm;
```

## CORS Headers

```javascript
// Request (sent by browser for cross-origin requests)
Origin: "https://myapp.com"
Access-Control-Request-Method: "POST"
Access-Control-Request-Headers: "Content-Type"

// Response
// Allow origin
Access-Control-Allow-Origin: "*" // Any origin
Access-Control-Allow-Origin: "https://myapp.com" // Specific origin

// Allow credentials (cookies, auth)
Access-Control-Allow-Credentials: "true"
// Note: Can't use "*" with credentials, must specify origin

// Allow methods
Access-Control-Allow-Methods: "GET, POST, PUT, DELETE"

// Allow headers
Access-Control-Allow-Headers: "Content-Type, Authorization"

// Cache preflight
Access-Control-Max-Age: "86400" // Cache for 1 day

// Simple CORS (no preflight needed)
// GET, HEAD, POST with these content types:
// - application/x-www-form-urlencoded
// - multipart/form-data
// - text/plain

// Complex CORS (preflight OPTIONS required)
// - PUT, DELETE, PATCH
// - Custom headers
// - application/json content type
```

## Cache Control

```javascript
// No cache
Cache-Control: "no-cache"
// Browser can cache but must validate with server

// Don't cache
Cache-Control: "no-store"
// Never cache, always fetch from server

// Public cache (can be cached by intermediaries)
Cache-Control: "public, max-age=3600"

// Private cache (only browser, not CDN)
Cache-Control: "private, max-age=3600"

// Max age (in seconds)
Cache-Control: "max-age=3600" // 1 hour
Cache-Control: "max-age=0" // Don't cache

// Revalidate
Cache-Control: "must-revalidate" // Must check after max-age expires
Cache-Control: "proxy-revalidate" // Only for proxies

// Immutable (never changes)
Cache-Control: "public, max-age=31536000, immutable"

// Common patterns
// Static assets (never changes)
Cache-Control: "public, max-age=31536000, immutable"

// API responses
Cache-Control: "private, max-age=0, must-revalidate"

// HTML (check often)
Cache-Control: "public, max-age=3600, must-revalidate"

// User pages
Cache-Control: "private, no-cache"
```
