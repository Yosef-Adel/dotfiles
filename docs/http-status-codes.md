*http-status-codes.txt*  HTTP Status Codes Reference

==============================================================================
CONTENTS                                            *http-status-codes-contents*

1. Overview .............................. |http-status-overview|
2. 1xx Informational ..................... |http-status-1xx|
3. 2xx Success ........................... |http-status-2xx|
4. 3xx Redirection ....................... |http-status-3xx|
5. 4xx Client Errors ..................... |http-status-4xx|
6. 5xx Server Errors ..................... |http-status-5xx|
7. Common Use Cases ...................... |http-status-use-cases|
8. REST API Guidelines ................... |http-status-rest|
9. Status Code Selection ................. |http-status-selection|

==============================================================================
1. OVERVIEW                                          *http-status-overview*

HTTP status codes indicate the result of an HTTP request~
>
    1xx - Informational responses
    2xx - Success
    3xx - Redirection
    4xx - Client errors
    5xx - Server errors
<

==============================================================================
2. 1XX INFORMATIONAL                                     *http-status-1xx*

Informational responses~
>
    100 Continue
        Server has received request headers
        Client should continue with request

    101 Switching Protocols
        Server is switching protocols
        Response to Upgrade request header

    102 Processing
        Server has received request and is processing

    103 Early Hints
        Return some response headers before final response
        Allows preloading resources
<

==============================================================================
3. 2XX SUCCESS                                           *http-status-2xx*

Success responses~
>
    200 OK
        Standard success response
        GET: Resource retrieved
        POST: Resource created/processed

    201 Created
        Resource successfully created
        Usually with POST
        Location header with new resource URI

    202 Accepted
        Request accepted, processing not complete
        Used for async operations

    203 Non-Authoritative Information
        Proxy modified the response

    204 No Content
        Success but no content to return
        Common with DELETE requests

    205 Reset Content
        Success, reset document view

    206 Partial Content
        Partial resource returned
        Used with Range header

    207 Multi-Status (WebDAV)
        Multiple status codes for sub-requests

    208 Already Reported (WebDAV)
        Members already enumerated

    226 IM Used
        Resource changed, delta transmitted
<

==============================================================================
4. 3XX REDIRECTION                                       *http-status-3xx*

Redirection responses~
>
    300 Multiple Choices
        Multiple options available

    301 Moved Permanently
        Resource permanently moved
        Search engines update their links

    302 Found
        Temporary redirect
        Original URI should be used for future requests

    303 See Other
        Redirect to different URI with GET
        Common after POST

    304 Not Modified
        Resource not modified (caching)
        Used with If-Modified-Since, If-None-Match

    305 Use Proxy (deprecated)

    307 Temporary Redirect
        Like 302 but method must not change

    308 Permanent Redirect
        Like 301 but method must not change
<

==============================================================================
5. 4XX CLIENT ERRORS                                     *http-status-4xx*

Client error responses~
>
    400 Bad Request
        Invalid request syntax or parameters
        Malformed JSON
        Validation errors

    401 Unauthorized
        Authentication required or failed
        No valid credentials provided

    402 Payment Required
        Reserved for future use

    403 Forbidden
        Server understood request but refuses
        Valid auth but insufficient permissions

    404 Not Found
        Resource doesn't exist
        Most common error code

    405 Method Not Allowed
        HTTP method not supported for resource
        GET on POST-only endpoint
        Allow header shows allowed methods

    406 Not Acceptable
        Server can't produce acceptable response
        Content negotiation failure

    407 Proxy Authentication Required
        Authentication with proxy required

    408 Request Timeout
        Server timeout waiting for request

    409 Conflict
        Request conflicts with current state
        Duplicate resource
        Version conflict

    410 Gone
        Resource permanently removed
        More specific than 404

    411 Length Required
        Content-Length header missing

    412 Precondition Failed
        If-Match, If-None-Match failed

    413 Payload Too Large
        Request body too large
        File upload too big

    414 URI Too Long
        URL exceeds server limit

    415 Unsupported Media Type
        Content-Type not supported
        Server expects different format

    416 Range Not Satisfiable
        Invalid Range header

    417 Expectation Failed
        Expect header can't be met

    418 I'm a teapot (April Fools' RFC)

    421 Misdirected Request
        Request directed at wrong server

    422 Unprocessable Entity (WebDAV)
        Semantic errors
        Validation failed
        Request well-formed but semantically incorrect

    423 Locked (WebDAV)
        Resource is locked

    424 Failed Dependency (WebDAV)
        Request failed due to previous request failure

    425 Too Early
        Server unwilling to risk replaying request

    426 Upgrade Required
        Client should switch to different protocol

    428 Precondition Required
        Request must be conditional

    429 Too Many Requests
        Rate limit exceeded
        Retry-After header may be present

    431 Request Header Fields Too Large
        Request headers too large

    451 Unavailable For Legal Reasons
        Censored or blocked by law
<

==============================================================================
6. 5XX SERVER ERRORS                                     *http-status-5xx*

Server error responses~
>
    500 Internal Server Error
        Generic server error
        Unhandled exception
        Server malfunction

    501 Not Implemented
        Server doesn't support functionality
        Method not recognized

    502 Bad Gateway
        Invalid response from upstream server
        Proxy/gateway error
        Common with reverse proxies

    503 Service Unavailable
        Server temporarily unavailable
        Maintenance mode
        Overloaded
        Retry-After header may be present

    504 Gateway Timeout
        Upstream server timeout
        Proxy didn't receive timely response

    505 HTTP Version Not Supported
        HTTP version not supported by server

    506 Variant Also Negotiates
        Server configuration error

    507 Insufficient Storage (WebDAV)
        Server cannot store representation

    508 Loop Detected (WebDAV)
        Infinite loop detected

    510 Not Extended
        Further extensions required

    511 Network Authentication Required
        Client needs to authenticate for network access
<

==============================================================================
7. COMMON USE CASES                                  *http-status-use-cases*

Successful operations~                       *http-status-use-cases-success*
>
    GET /users/123          → 200 OK
    POST /users             → 201 Created (with Location header)
    PUT /users/123          → 200 OK or 204 No Content
    PATCH /users/123        → 200 OK
    DELETE /users/123       → 204 No Content
<

Client errors~                                 *http-status-use-cases-errors*
>
    GET /users/999          → 404 Not Found
    POST /users (invalid)   → 400 Bad Request
    POST /users (no auth)   → 401 Unauthorized
    GET /admin (no perms)   → 403 Forbidden
    POST /users (conflict)  → 409 Conflict
    POST /users (invalid)   → 422 Unprocessable Entity
<

Rate limiting~                            *http-status-use-cases-rate-limit*
>
    GET /api/data (too many)  → 429 Too Many Requests
<

Server errors~                                *http-status-use-cases-server*
>
    GET /users (exception)    → 500 Internal Server Error
    GET /api/data (timeout)   → 504 Gateway Timeout
<

==============================================================================
8. REST API GUIDELINES                                    *http-status-rest*

Success patterns~                              *http-status-rest-success*
>
    GET    → 200 (retrieve)
    POST   → 201 (create)
    PUT    → 200 or 204 (replace)
    PATCH  → 200 (update)
    DELETE → 204 (remove)
<

Error patterns~                                  *http-status-rest-errors*
>
    Invalid data          → 400
    No authentication     → 401
    No permission         → 403
    Resource not found    → 404
    Method not allowed    → 405
    Duplicate             → 409
    Validation failed     → 422
    Rate limited          → 429
    Server error          → 500
    Upstream error        → 502
    Service down          → 503
    Upstream timeout      → 504
<

Caching~                                        *http-status-rest-caching*
>
    Cached, not modified  → 304
<

Redirection~                                 *http-status-rest-redirection*
>
    Moved permanently     → 301
    Temporary redirect    → 302 or 307
<

==============================================================================
9. STATUS CODE SELECTION                               *http-status-selection*

2xx: Success~                                  *http-status-selection-2xx*
>
    Use when operation succeeds
    200: Default success
    201: Created new resource
    204: Success with no content
<

3xx: Redirection~                              *http-status-selection-3xx*
>
    Use when resource moved
    301: Permanent move
    302/307: Temporary redirect
    304: Not modified (caching)
<

4xx: Client Error~                             *http-status-selection-4xx*
>
    Use when client made mistake
    400: Bad request format
    401: Auth required
    403: No permission
    404: Not found
    422: Validation error
<

5xx: Server Error~                             *http-status-selection-5xx*
>
    Use when server fails
    500: Server error
    502: Upstream error
    503: Unavailable
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
