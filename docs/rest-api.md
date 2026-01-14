*rest-api.txt*  REST API Reference

==============================================================================
CONTENTS                                                  *rest-api-contents*

1. HTTP Methods .......................... |rest-api-methods|
2. Status Codes .......................... |rest-api-status|
3. URL Design ............................ |rest-api-url|
4. Request Headers ....................... |rest-api-request-headers|
5. Response Headers ...................... |rest-api-response-headers|
6. Authentication ........................ |rest-api-auth|
7. Versioning ............................ |rest-api-versioning|
8. Pagination ............................ |rest-api-pagination|
9. Filtering and Sorting ................. |rest-api-filtering|
10. Error Responses ...................... |rest-api-errors|
11. CORS ................................. |rest-api-cors|
12. Rate Limiting ........................ |rest-api-rate-limiting|
13. Caching .............................. |rest-api-caching|
14. HATEOAS .............................. |rest-api-hateoas|
15. Best Practices ....................... |rest-api-best-practices|

==============================================================================
1. HTTP METHODS                                           *rest-api-methods*

HTTP methods~                                       *rest-api-methods-list*
>
    GET     - Retrieve resource(s) (idempotent, safe)
    POST    - Create new resource
    PUT     - Update/replace entire resource (idempotent)
    PATCH   - Partial update of resource (idempotent)
    DELETE  - Delete resource (idempotent)
    HEAD    - Get headers only (like GET without body)
    OPTIONS - Get supported methods for resource
<

Examples~                                        *rest-api-methods-examples*
>
    GET    /users              # Get all users
    GET    /users/123          # Get user 123
    POST   /users              # Create new user
    PUT    /users/123          # Replace user 123
    PATCH  /users/123          # Update user 123
    DELETE /users/123          # Delete user 123
<

==============================================================================
2. STATUS CODES                                            *rest-api-status*

2xx Success~                                         *rest-api-status-2xx*
>
    200 OK                    # General success
    201 Created               # Resource created (POST)
    202 Accepted              # Request accepted, processing async
    204 No Content            # Success with no body (DELETE)
<

3xx Redirection~                                     *rest-api-status-3xx*
>
    301 Moved Permanently     # Resource permanently moved
    302 Found                 # Temporary redirect
    304 Not Modified          # Cached version is still valid
<

4xx Client Errors~                                   *rest-api-status-4xx*
>
    400 Bad Request           # Invalid request syntax/data
    401 Unauthorized          # Authentication required
    403 Forbidden             # Authenticated but no permission
    404 Not Found             # Resource doesn't exist
    405 Method Not Allowed    # HTTP method not supported
    409 Conflict              # Request conflicts with current state
    422 Unprocessable Entity  # Validation errors
    429 Too Many Requests     # Rate limit exceeded
<

5xx Server Errors~                                   *rest-api-status-5xx*
>
    500 Internal Server Error # Generic server error
    502 Bad Gateway           # Invalid response from upstream
    503 Service Unavailable   # Server temporarily down
    504 Gateway Timeout       # Upstream timeout
<

==============================================================================
3. URL DESIGN                                                *rest-api-url*

Resource naming~                                       *rest-api-url-naming*
>
    # Use nouns, not verbs
    /users                    # Collection
    /users/123                # Specific resource
    /users/123/posts          # Nested resource
    /users/123/posts/456      # Specific nested resource

    # Use plural nouns
    ✓ /users
    ✗ /user

    # Avoid deep nesting (max 2-3 levels)
    ✓ /posts/123/comments
    ✗ /users/123/posts/456/comments/789/replies/012

    # Use hyphens, not underscores
    ✓ /user-profiles
    ✗ /user_profiles

    # Lowercase only
    ✓ /users
    ✗ /Users

    # Query parameters for filtering, sorting, pagination
    /users?status=active&sort=name&page=2

    # Actions as sub-resources (when REST doesn't fit)
    POST /users/123/activate
    POST /orders/456/cancel
    POST /documents/789/publish
<

==============================================================================
4. REQUEST HEADERS                                *rest-api-request-headers*

Request headers~                               *rest-api-request-headers-list*
>
    # Content negotiation
    Accept: application/json
    Accept: application/xml
    Accept-Language: en-US
    Accept-Encoding: gzip, deflate

    # Authentication
    Authorization: Bearer <token>
    Authorization: Basic <base64-credentials>
    API-Key: <api-key>

    # Content type (for POST/PUT/PATCH)
    Content-Type: application/json
    Content-Type: application/x-www-form-urlencoded
    Content-Type: multipart/form-data

    # Other common headers
    User-Agent: MyApp/1.0
    X-Request-ID: unique-id-123
    If-None-Match: "etag-value"
    If-Modified-Since: Wed, 21 Oct 2024 07:28:00 GMT
<

==============================================================================
5. RESPONSE HEADERS                              *rest-api-response-headers*

Response headers~                             *rest-api-response-headers-list*
>
    # Content information
    Content-Type: application/json; charset=utf-8
    Content-Length: 1234
    Content-Encoding: gzip

    # Caching
    Cache-Control: max-age=3600, public
    Cache-Control: no-cache, no-store, must-revalidate
    ETag: "33a64df551425fcc55e4d42a148795d9f25f89d4"
    Last-Modified: Wed, 21 Oct 2024 07:28:00 GMT
    Expires: Thu, 22 Oct 2024 07:28:00 GMT

    # Security
    X-Content-Type-Options: nosniff
    X-Frame-Options: DENY
    X-XSS-Protection: 1; mode=block
    Strict-Transport-Security: max-age=31536000

    # CORS
    Access-Control-Allow-Origin: *
    Access-Control-Allow-Methods: GET, POST, PUT, DELETE
    Access-Control-Allow-Headers: Content-Type, Authorization
    Access-Control-Max-Age: 3600

    # Rate limiting
    X-RateLimit-Limit: 1000
    X-RateLimit-Remaining: 999
    X-RateLimit-Reset: 1640000000

    # Pagination
    Link: </users?page=2>; rel="next", </users?page=5>; rel="last"

    # Location (for 201 Created)
    Location: /users/123
<

==============================================================================
6. AUTHENTICATION                                           *rest-api-auth*

Authentication methods~                             *rest-api-auth-methods*
>
    // Bearer Token (JWT)
    Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

    // Basic Auth
    Authorization: Basic base64(username:password)

    // API Key (header)
    X-API-Key: your-api-key

    // API Key (query param - less secure)
    GET /users?api_key=your-api-key

    // Example request with token
    fetch('/api/users', {
      headers: {
        'Authorization': 'Bearer ' + token,
        'Content-Type': 'application/json'
      }
    })
<

==============================================================================
7. VERSIONING                                          *rest-api-versioning*

Versioning strategies~                          *rest-api-versioning-methods*
>
    # URL versioning (most common)
    /v1/users
    /v2/users

    # Header versioning
    Accept: application/vnd.myapi.v1+json

    # Query parameter versioning
    /users?version=1

    # Hostname versioning
    api.v1.example.com/users
<

==============================================================================
8. PAGINATION                                          *rest-api-pagination*

Pagination strategies~                          *rest-api-pagination-methods*
>
    # Offset-based (page/limit)
    GET /users?page=2&limit=20

    # Cursor-based (better for large datasets)
    GET /users?cursor=abc123&limit=20

    # Link header (GitHub style)
    Link: <https://api.example.com/users?page=3>; rel="next",
          <https://api.example.com/users?page=1>; rel="prev",
          <https://api.example.com/users?page=10>; rel="last"
<

Response format~                               *rest-api-pagination-response*
>
    # Offset-based response
    {
      "data": [...],
      "pagination": {
        "total": 1000,
        "page": 2,
        "limit": 20,
        "totalPages": 50,
        "hasNext": true,
        "hasPrev": true
      }
    }

    # Cursor-based response
    {
      "data": [...],
      "pagination": {
        "nextCursor": "abc123",
        "hasMore": true
      }
    }
<

==============================================================================
9. FILTERING AND SORTING                               *rest-api-filtering*

Filtering~                                       *rest-api-filtering-methods*
>
    # Basic filtering
    GET /users?status=active
    GET /users?role=admin&status=active

    # Comparison operators
    GET /users?age_gt=18          # Greater than
    GET /users?age_gte=18         # Greater than or equal
    GET /users?age_lt=65          # Less than
    GET /users?age_lte=65         # Less than or equal
    GET /users?name_contains=john # Contains
    GET /users?created_at_after=2024-01-01
<

Sorting~                                           *rest-api-filtering-sort*
>
    # Sorting
    GET /users?sort=name          # Ascending
    GET /users?sort=-name         # Descending (minus prefix)
    GET /users?sort=name,age      # Multiple fields
    GET /users?sort=name&order=desc

    # Field selection (sparse fieldsets)
    GET /users?fields=id,name,email

    # Search
    GET /users?q=john             # General search
    GET /users?search=john%20doe  # URL encoded
<

==============================================================================
10. ERROR RESPONSES                                       *rest-api-errors*

Error formats~                                      *rest-api-errors-format*
>
    // Standard error format
    {
      "error": {
        "code": "VALIDATION_ERROR",
        "message": "Invalid request data",
        "details": [
          {
            "field": "email",
            "message": "Invalid email format"
          },
          {
            "field": "age",
            "message": "Must be at least 18"
          }
        ]
      }
    }

    // Simple error format
    {
      "error": "User not found"
    }

    // Problem Details (RFC 7807)
    {
      "type": "https://example.com/errors/validation",
      "title": "Validation Error",
      "status": 422,
      "detail": "Invalid email format",
      "instance": "/users/123"
    }
<

Status codes for errors~                          *rest-api-errors-status*
>
    400 - Validation errors, malformed requests
    401 - Missing or invalid authentication
    403 - Valid auth but insufficient permissions
    404 - Resource not found
    409 - Conflict (duplicate, state conflict)
    422 - Unprocessable (semantic errors)
    429 - Rate limit exceeded
    500 - Internal server error
    503 - Service unavailable
<

==============================================================================
11. CORS                                                     *rest-api-cors*

CORS configuration~                                   *rest-api-cors-config*
>
    // Server configuration
    app.use((req, res, next) => {
      res.header('Access-Control-Allow-Origin', '*');
      res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE, OPTIONS');
      res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
      res.header('Access-Control-Max-Age', '3600');

      if (req.method === 'OPTIONS') {
        return res.sendStatus(200);
      }
      next();
    });
<

Preflight requests~                               *rest-api-cors-preflight*
>
    // Preflight request (browser sends automatically)
    OPTIONS /api/users
    Access-Control-Request-Method: POST
    Access-Control-Request-Headers: Content-Type

    // Preflight response
    200 OK
    Access-Control-Allow-Origin: *
    Access-Control-Allow-Methods: GET, POST, PUT, DELETE
    Access-Control-Allow-Headers: Content-Type, Authorization
<

==============================================================================
12. RATE LIMITING                                    *rest-api-rate-limiting*

Rate limit headers~                         *rest-api-rate-limiting-headers*
>
    X-RateLimit-Limit: 1000          # Max requests per window
    X-RateLimit-Remaining: 999       # Remaining requests
    X-RateLimit-Reset: 1640000000    # Unix timestamp when limit resets
<

Rate limit exceeded~                       *rest-api-rate-limiting-exceeded*
>
    HTTP/1.1 429 Too Many Requests
    Retry-After: 3600                # Seconds to wait
    X-RateLimit-Limit: 1000
    X-RateLimit-Remaining: 0
    X-RateLimit-Reset: 1640000000

    {
      "error": {
        "code": "RATE_LIMIT_EXCEEDED",
        "message": "Rate limit exceeded. Try again in 3600 seconds."
      }
    }
<

==============================================================================
13. CACHING                                               *rest-api-caching*

Cache control~                                     *rest-api-caching-control*
>
    # Client caching
    Cache-Control: max-age=3600, public       # Cache for 1 hour
    Cache-Control: max-age=0, private         # Don't cache
    Cache-Control: no-cache, no-store         # Never cache
    Cache-Control: must-revalidate            # Validate before use
<

ETags~                                                *rest-api-caching-etag*
>
    # First request
    GET /users/123
    200 OK
    ETag: "33a64df551425fcc55e"
    { "id": 123, "name": "John" }

    # Subsequent request
    GET /users/123
    If-None-Match: "33a64df551425fcc55e"

    # If not modified
    304 Not Modified
    ETag: "33a64df551425fcc55e"
<

Last-Modified~                            *rest-api-caching-last-modified*
>
    # Last-Modified
    Last-Modified: Wed, 21 Oct 2024 07:28:00 GMT

    # Conditional request
    If-Modified-Since: Wed, 21 Oct 2024 07:28:00 GMT
<

==============================================================================
14. HATEOAS                                               *rest-api-hateoas*

HATEOAS examples~                                  *rest-api-hateoas-examples*
>
    // Hypermedia as the Engine of Application State
    // Include links to related resources

    {
      "id": 123,
      "name": "John Doe",
      "email": "john@example.com",
      "_links": {
        "self": { "href": "/users/123" },
        "posts": { "href": "/users/123/posts" },
        "profile": { "href": "/users/123/profile" },
        "avatar": { "href": "/users/123/avatar" }
      }
    }

    // Actions
    {
      "id": 456,
      "status": "pending",
      "_links": {
        "self": { "href": "/orders/456" },
        "cancel": {
          "href": "/orders/456/cancel",
          "method": "POST"
        },
        "confirm": {
          "href": "/orders/456/confirm",
          "method": "POST"
        }
      }
    }
<

==============================================================================
15. BEST PRACTICES                                *rest-api-best-practices*

Best practices~                              *rest-api-best-practices-list*
>
    # 1. Use nouns, not verbs in URLs
    ✓ GET /users
    ✗ GET /getUsers

    # 2. Use HTTP methods correctly
    ✓ DELETE /users/123
    ✗ POST /users/123/delete

    # 3. Use proper status codes
    ✓ 404 for not found
    ✗ 200 with error message in body

    # 4. Version your API
    ✓ /v1/users
    ✗ /users (unversioned)

    # 5. Use SSL/TLS (HTTPS)
    ✓ https://api.example.com
    ✗ http://api.example.com

    # 6. Document your API
    - OpenAPI/Swagger
    - Postman collections
    - Clear README

    # 7. Use consistent naming
    ✓ created_at, updated_at (pick snake_case)
    ✓ createdAt, updatedAt (or camelCase)
    ✗ created_at, updatedAt (mixed)

    # 8. Include metadata in responses
    {
      "data": [...],
      "meta": {
        "page": 1,
        "total": 100
      }
    }

    # 9. Handle trailing slashes consistently
    /users and /users/ should be equivalent

    # 10. Use query params for operations
    ✓ GET /users?status=active
    ✗ GET /users/active

    # 11. Idempotency for safety
    PUT, PATCH, DELETE should be idempotent
    Use idempotency keys for POST when needed

    # 12. Return created resource
    POST /users
    201 Created
    Location: /users/123
    { "id": 123, "name": "John" }

    # 13. Bulk operations
    POST /users/bulk
    DELETE /users?ids=1,2,3

    # 14. Nested resources
    ✓ /users/123/posts (user's posts)
    ✗ /users/posts (ambiguous)

    # 15. Use JSON as default
    Content-Type: application/json
    Accept: application/json
<

Complete example~                          *rest-api-best-practices-example*
>
    // GET /users
    {
      "data": [
        {
          "id": 1,
          "name": "John Doe",
          "email": "john@example.com",
          "createdAt": "2024-01-15T10:30:00Z"
        }
      ],
      "meta": {
        "page": 1,
        "limit": 20,
        "total": 100,
        "totalPages": 5
      },
      "links": {
        "self": "/users?page=1",
        "next": "/users?page=2",
        "last": "/users?page=5"
      }
    }

    // POST /users
    Request:
    {
      "name": "Jane Doe",
      "email": "jane@example.com",
      "password": "secure123"
    }

    Response: 201 Created
    Location: /users/2
    {
      "id": 2,
      "name": "Jane Doe",
      "email": "jane@example.com",
      "createdAt": "2024-01-15T10:35:00Z"
    }

    // PUT /users/2
    Request:
    {
      "name": "Jane Smith",
      "email": "jane.smith@example.com"
    }

    Response: 200 OK
    {
      "id": 2,
      "name": "Jane Smith",
      "email": "jane.smith@example.com",
      "updatedAt": "2024-01-15T10:40:00Z"
    }

    // DELETE /users/2
    Response: 204 No Content
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
