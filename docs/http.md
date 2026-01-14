*http.txt*  HTTP Reference

==============================================================================
CONTENTS                                                       *http-contents*

1. HTTP Methods .......................... |http-methods|
2. Status Codes .......................... |http-status-codes|
3. Request Headers ....................... |http-request-headers|
4. Response Headers ...................... |http-response-headers|
5. Content Types ......................... |http-content-types|
6. CORS Headers .......................... |http-cors|
7. Cache Control ......................... |http-cache|

==============================================================================
1. HTTP METHODS                                              *http-methods*

Common HTTP methods~                                  *http-methods-common*

Method properties~
>
    Method   Purpose              Safe  Idempotent  Has Body
    -------  -------------------  ----  ----------  --------
    GET      Retrieve resource    Yes   Yes         No
    HEAD     Like GET but no body Yes   Yes         No
    POST     Create resource      No    No          Yes
    PUT      Replace resource     No    Yes         Yes
    PATCH    Partial update       No    No          Yes
    DELETE   Delete resource      No    Yes         No
    OPTIONS  Get allowed methods  Yes   Yes         No
<

Safe: Doesn't modify server state
Idempotent: Multiple requests = same as single request

Examples~                                            *http-methods-examples*
>
    GET /users              # Get all users
    POST /users             # Create new user
    GET /users/1            # Get specific user
    PUT /users/1            # Replace user
    PATCH /users/1          # Update user fields
    DELETE /users/1         # Delete user
<

==============================================================================
2. STATUS CODES                                         *http-status-codes*

1xx Informational~                                   *http-status-1xx*
>
    100  Continue            # Client should continue request
    101  Switching Protocols # Protocol upgrade (HTTP → WebSocket)
<

2xx Success~                                         *http-status-2xx*
>
    200  OK                  # Request succeeded
    201  Created             # Resource created (POST)
    202  Accepted            # Request accepted, processing async
    204  No Content          # Success but no response body
    206  Partial Content     # Partial resource (range request)
<

3xx Redirection~                                     *http-status-3xx*
>
    300  Multiple Choices    # Multiple options available
    301  Moved Permanently   # Resource moved, use new URL forever
    302  Found               # Resource moved temporarily
    304  Not Modified        # Cached version is valid
    307  Temporary Redirect  # Temporary redirect, preserve method
    308  Permanent Redirect  # Permanent redirect, preserve method
<

4xx Client Error~                                    *http-status-4xx*
>
    400  Bad Request          # Invalid request syntax
    401  Unauthorized         # Authentication required
    403  Forbidden            # Authenticated but not allowed
    404  Not Found            # Resource doesn't exist
    405  Method Not Allowed   # HTTP method not supported
    409  Conflict             # Request conflicts with state
    422  Unprocessable Entity # Request well-formed but invalid data
    429  Too Many Requests    # Rate limited
<

5xx Server Error~                                    *http-status-5xx*
>
    500  Internal Server Error # Generic server error
    501  Not Implemented       # Feature not implemented
    502  Bad Gateway           # Invalid response from upstream
    503  Service Unavailable   # Server overloaded/down
    504  Gateway Timeout       # Upstream took too long
<

==============================================================================
3. REQUEST HEADERS                                   *http-request-headers*

Authentication~                                  *http-request-headers-auth*
>
    Authorization: Bearer token_here
    Authorization: Basic base64_encoded
<

Content~                                      *http-request-headers-content*
>
    Content-Type: application/json
    Content-Type: application/x-www-form-urlencoded
    Content-Type: multipart/form-data; boundary=...
    Content-Length: 1234
<

Caching~                                       *http-request-headers-cache*
>
    If-Modified-Since: Wed, 21 Oct 2025 07:28:00 GMT
    If-None-Match: "W/\"abc123\""         # ETag
    Cache-Control: no-cache, no-store
<

Cookies~                                      *http-request-headers-cookies*
>
    Cookie: session=abc123; user=john
<

Request info~                                   *http-request-headers-info*
>
    Host: example.com
    User-Agent: Mozilla/5.0...
    Referer: https://example.com/page
    Accept: application/json
    Accept-Language: en-US,en;q=0.9
    Accept-Encoding: gzip, deflate
<

CORS~                                          *http-request-headers-cors*
>
    Origin: https://another-site.com
<

Other~                                        *http-request-headers-other*
>
    X-Requested-With: XMLHttpRequest
    X-Forwarded-For: 192.168.1.1          # Client IP
<

==============================================================================
4. RESPONSE HEADERS                                 *http-response-headers*

Content~                                    *http-response-headers-content*
>
    Content-Type: application/json; charset=utf-8
    Content-Length: 1234
    Content-Encoding: gzip
    Content-Disposition: attachment; filename=data.csv
<

Caching~                                     *http-response-headers-cache*
>
    Cache-Control: max-age=3600, public
    Cache-Control: no-cache, must-revalidate
    Cache-Control: private, max-age=0    # Don't cache
    ETag: "W/\"abc123\""
    Last-Modified: Wed, 21 Oct 2025 07:28:00 GMT
    Expires: Wed, 21 Oct 2026 07:28:00 GMT
<

Cookies~                                    *http-response-headers-cookies*
>
    Set-Cookie: session=abc123; Path=/; HttpOnly; Secure; SameSite=Strict
    Set-Cookie: user=john; Max-Age=3600
<

CORS~                                         *http-response-headers-cors*
>
    Access-Control-Allow-Origin: *
    Access-Control-Allow-Origin: https://example.com
    Access-Control-Allow-Methods: GET, POST, PUT, DELETE
    Access-Control-Allow-Headers: Content-Type, Authorization
    Access-Control-Allow-Credentials: true
    Access-Control-Max-Age: 86400
<

Security~                                  *http-response-headers-security*
>
    Strict-Transport-Security: max-age=31536000
    X-Content-Type-Options: nosniff
    X-Frame-Options: SAMEORIGIN
    X-XSS-Protection: 1; mode=block
    Content-Security-Policy: default-src 'self'
<

Other~                                      *http-response-headers-other*
>
    Location: https://example.com/new-url    # Redirect
    Retry-After: 120                         # Retry in 120 seconds
    Server: nginx/1.21
    Date: Wed, 21 Oct 2025 07:28:00 GMT
    Vary: Accept-Encoding                    # Cache varies by this header
<

==============================================================================
5. CONTENT TYPES                                        *http-content-types*

Text~                                              *http-content-types-text*
>
    text/plain
    text/html
    text/css
    text/javascript            # Old, use application/javascript
<

Application~                                  *http-content-types-application*
>
    application/json
    application/xml
    application/pdf
    application/zip
    application/octet-stream   # Binary file
<

Form data~                                      *http-content-types-form*
>
    application/x-www-form-urlencoded    # Default form submission
    multipart/form-data                  # File uploads
<

Images~                                        *http-content-types-images*
>
    image/png
    image/jpeg
    image/gif
    image/svg+xml
    image/webp
<

Audio/Video~                                   *http-content-types-media*
>
    audio/mpeg
    audio/ogg
    video/mp4
    video/webm
<

==============================================================================
6. CORS HEADERS                                                 *http-cors*

Request headers~                                       *http-cors-request*
>
    # Sent by browser for cross-origin requests
    Origin: https://myapp.com
    Access-Control-Request-Method: POST
    Access-Control-Request-Headers: Content-Type
<

Response headers~                                     *http-cors-response*
>
    # Allow origin
    Access-Control-Allow-Origin: *                    # Any origin
    Access-Control-Allow-Origin: https://myapp.com    # Specific origin

    # Allow credentials (cookies, auth)
    Access-Control-Allow-Credentials: true
    # Note: Can't use "*" with credentials, must specify origin

    # Allow methods
    Access-Control-Allow-Methods: GET, POST, PUT, DELETE

    # Allow headers
    Access-Control-Allow-Headers: Content-Type, Authorization

    # Cache preflight
    Access-Control-Max-Age: 86400    # Cache for 1 day
<

Simple CORS (no preflight needed)~                    *http-cors-simple*
>
    # GET, HEAD, POST with these content types:
    # - application/x-www-form-urlencoded
    # - multipart/form-data
    # - text/plain
<

Complex CORS (preflight OPTIONS required)~           *http-cors-complex*
>
    # - PUT, DELETE, PATCH
    # - Custom headers
    # - application/json content type
<

==============================================================================
7. CACHE CONTROL                                              *http-cache*

No cache~                                           *http-cache-no-cache*
>
    Cache-Control: no-cache
    # Browser can cache but must validate with server
<

Don't cache~                                        *http-cache-no-store*
>
    Cache-Control: no-store
    # Never cache, always fetch from server
<

Public cache~                                        *http-cache-public*
>
    # Can be cached by intermediaries
    Cache-Control: public, max-age=3600
<

Private cache~                                      *http-cache-private*
>
    # Only browser, not CDN
    Cache-Control: private, max-age=3600
<

Max age~                                             *http-cache-max-age*
>
    Cache-Control: max-age=3600    # 1 hour
    Cache-Control: max-age=0       # Don't cache
<

Revalidate~                                      *http-cache-revalidate*
>
    Cache-Control: must-revalidate       # Must check after max-age expires
    Cache-Control: proxy-revalidate      # Only for proxies
<

Immutable~                                        *http-cache-immutable*
>
    Cache-Control: public, max-age=31536000, immutable
<

Common patterns~                                  *http-cache-patterns*
>
    # Static assets (never changes)
    Cache-Control: public, max-age=31536000, immutable

    # API responses
    Cache-Control: private, max-age=0, must-revalidate

    # HTML (check often)
    Cache-Control: public, max-age=3600, must-revalidate

    # User pages
    Cache-Control: private, no-cache
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
