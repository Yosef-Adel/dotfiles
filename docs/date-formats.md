*date-formats.txt*  Date & Time Formats Reference

==============================================================================
CONTENTS                                                *date-formats-contents*

1. ISO 8601 (Standard) ................... |date-formats-iso|
2. Common Formats ........................ |date-formats-common|
3. JavaScript ............................ |date-formats-javascript|
4. Python ................................ |date-formats-python|
5. Python Format Codes ................... |date-formats-python-codes|
6. Go .................................... |date-formats-go|
7. Go Reference Layout ................... |date-formats-go-layout|
8. SQL ................................... |date-formats-sql|
9. Unix Timestamp ........................ |date-formats-unix|
10. Common Patterns ...................... |date-formats-patterns|
11. Timezones ............................ |date-formats-timezones|
12. Best Practices ....................... |date-formats-best-practices|

==============================================================================
1. ISO 8601 (STANDARD)                                   *date-formats-iso*

Date~                                                    *date-formats-iso-date*
>
    YYYY-MM-DD           2024-01-15
<

Date and time~                                           *date-formats-iso-time*
>
    YYYY-MM-DDTHH:mm:ss           2024-01-15T14:30:00
    YYYY-MM-DDTHH:mm:ss.sss       2024-01-15T14:30:00.123
    YYYY-MM-DDTHH:mm:ssZ          2024-01-15T14:30:00Z (UTC)
    YYYY-MM-DDTHH:mm:ss+HH:mm     2024-01-15T14:30:00+05:30
    YYYY-MM-DDTHH:mm:ss-HH:mm     2024-01-15T14:30:00-08:00
<

Week~                                                    *date-formats-iso-week*
>
    YYYY-Www             2024-W03
<

Ordinal date~                                         *date-formats-iso-ordinal*
>
    YYYY-DDD             2024-015 (15th day of year)
<

Duration~                                             *date-formats-iso-duration*
>
    P3Y6M4DT12H30M5S     3 years, 6 months, 4 days, 12 hours, 30 minutes, 5 seconds
    PT15M                15 minutes
    P1D                  1 day
<

==============================================================================
2. COMMON FORMATS                                        *date-formats-common*

Date formats~                                      *date-formats-common-date*
>
    MM/DD/YYYY           01/15/2024 (US)
    DD/MM/YYYY           15/01/2024 (EU)
    YYYY/MM/DD           2024/01/15 (ISO-like)
    DD-MM-YYYY           15-01-2024
    YYYY-MM-DD           2024-01-15 (ISO)

    Month DD, YYYY       January 15, 2024
    DD Month YYYY        15 January 2024
    Mon DD, YYYY         Jan 15, 2024
<

Time formats~                                      *date-formats-common-time*
>
    HH:mm:ss             14:30:00 (24-hour)
    HH:mm                14:30
    hh:mm:ss AM/PM       02:30:00 PM (12-hour)
    hh:mm AM/PM          02:30 PM
<

==============================================================================
3. JAVASCRIPT                                        *date-formats-javascript*

Creating dates~                                *date-formats-javascript-create*
>
    // Creating dates
    new Date()                          // Current
    new Date('2024-01-15')              // ISO string
    new Date('2024-01-15T14:30:00Z')    // ISO with time
    new Date('January 15, 2024')        // String
    new Date(2024, 0, 15)               // Year, month (0-11), day
    new Date(1705329000000)             // Unix timestamp (ms)
<

Formatting~                                    *date-formats-javascript-format*
>
    const date = new Date('2024-01-15T14:30:00');

    date.toISOString()          // 2024-01-15T14:30:00.000Z
    date.toLocaleDateString()   // 1/15/2024 (locale-specific)
    date.toLocaleTimeString()   // 2:30:00 PM
    date.toLocaleString()       // 1/15/2024, 2:30:00 PM
    date.toDateString()         // Mon Jan 15 2024
    date.toTimeString()         // 14:30:00 GMT+0000
    date.toJSON()               // 2024-01-15T14:30:00.000Z
<

Intl.DateTimeFormat~                            *date-formats-javascript-intl*
>
    new Intl.DateTimeFormat('en-US').format(date)
    // 1/15/2024

    new Intl.DateTimeFormat('en-GB').format(date)
    // 15/01/2024

    new Intl.DateTimeFormat('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    }).format(date)
    // January 15, 2024

    new Intl.DateTimeFormat('en-US', {
      hour: '2-digit',
      minute: '2-digit',
      hour12: true
    }).format(date)
    // 02:30 PM
<

Custom formatting~                            *date-formats-javascript-custom*
>
    const year = date.getFullYear()          // 2024
    const month = date.getMonth() + 1        // 1 (0-11)
    const day = date.getDate()               // 15
    const hours = date.getHours()            // 14
    const minutes = date.getMinutes()        // 30
    const seconds = date.getSeconds()        // 0

    // Padding
    const pad = (n) => n.toString().padStart(2, '0');
    `${year}-${pad(month)}-${pad(day)}`      // 2024-01-15
    `${pad(hours)}:${pad(minutes)}`          // 14:30
<

==============================================================================
4. PYTHON                                                *date-formats-python*

Creating dates~                                  *date-formats-python-create*
>
    from datetime import datetime, date, time
    import time as time_module

    # Creating
    datetime.now()                        # Current
    datetime.utcnow()                     # Current UTC
    datetime(2024, 1, 15)                 # Year, month, day
    datetime(2024, 1, 15, 14, 30, 0)      # With time
    date(2024, 1, 15)                     # Date only
    time(14, 30, 0)                       # Time only
<

From string~                                    *date-formats-python-parse*
>
    # From string
    datetime.fromisoformat('2024-01-15')
    datetime.fromisoformat('2024-01-15T14:30:00')
    datetime.strptime('2024-01-15', '%Y-%m-%d')
    datetime.strptime('01/15/2024', '%m/%d/%Y')

    # From timestamp
    datetime.fromtimestamp(1705329000)
<

Formatting~                                    *date-formats-python-format*
>
    dt = datetime(2024, 1, 15, 14, 30, 0)

    dt.strftime('%Y-%m-%d')               # 2024-01-15
    dt.strftime('%m/%d/%Y')               # 01/15/2024
    dt.strftime('%d/%m/%Y')               # 15/01/2024
    dt.strftime('%B %d, %Y')              # January 15, 2024
    dt.strftime('%b %d, %Y')              # Jan 15, 2024
    dt.strftime('%A, %B %d, %Y')          # Monday, January 15, 2024
    dt.strftime('%H:%M:%S')               # 14:30:00
    dt.strftime('%I:%M %p')               # 02:30 PM
    dt.strftime('%Y-%m-%d %H:%M:%S')      # 2024-01-15 14:30:00
    dt.isoformat()                        # 2024-01-15T14:30:00

    # To timestamp
    dt.timestamp()                        # 1705329000.0
    time_module.time()                    # Current timestamp
<

==============================================================================
5. PYTHON FORMAT CODES                           *date-formats-python-codes*

Format codes~                                 *date-formats-python-codes-list*
>
    %Y  Year (4-digit)        2024
    %y  Year (2-digit)        24
    %m  Month (01-12)         01
    %B  Month name (full)     January
    %b  Month name (abbr)     Jan
    %d  Day (01-31)           15
    %A  Weekday (full)        Monday
    %a  Weekday (abbr)        Mon
    %H  Hour 24-hour (00-23)  14
    %I  Hour 12-hour (01-12)  02
    %M  Minute (00-59)        30
    %S  Second (00-59)        00
    %p  AM/PM                 PM
    %f  Microsecond           000000
    %z  UTC offset            +0000
    %Z  Timezone name         UTC
    %j  Day of year (001-366) 015
    %U  Week of year (00-53)  03
    %W  Week of year (00-53)  03
    %%  Literal %             %
<

==============================================================================
6. GO                                                        *date-formats-go*

Creating dates~                                      *date-formats-go-create*
>
    import "time"

    // Creating
    time.Now()                               // Current
    time.Date(2024, 1, 15, 14, 30, 0, 0, time.UTC)
    time.Parse("2006-01-02", "2024-01-15")
    time.Parse(time.RFC3339, "2024-01-15T14:30:00Z")
<

Formatting~                                          *date-formats-go-format*
>
    t := time.Now()

    t.Format("2006-01-02")                   // 2024-01-15
    t.Format("01/02/2006")                   // 01/15/2024
    t.Format("02/01/2006")                   // 15/01/2024
    t.Format("Jan 02, 2006")                 // Jan 15, 2024
    t.Format("January 02, 2006")             // January 15, 2024
    t.Format("15:04:05")                     // 14:30:00
    t.Format("3:04 PM")                      // 2:30 PM
    t.Format("2006-01-02 15:04:05")          // 2024-01-15 14:30:00
    t.Format(time.RFC3339)                   // 2024-01-15T14:30:00Z
    t.Format(time.Kitchen)                   // 2:30PM

    // Unix timestamp
    t.Unix()                                 // 1705329000
    time.Unix(1705329000, 0)                 // From timestamp
<

==============================================================================
7. GO REFERENCE LAYOUT                               *date-formats-go-layout*

Go uses reference time~                          *date-formats-go-reference*
>
    // Go uses reference time: Mon Jan 2 15:04:05 MST 2006
    "2006-01-02"              // YYYY-MM-DD
    "01/02/2006"              // MM/DD/YYYY
    "02/01/2006"              // DD/MM/YYYY
    "Jan 02, 2006"            // Mon DD, YYYY
    "January 02, 2006"        // Month DD, YYYY
    "15:04:05"                // HH:MM:SS (24-hour)
    "3:04 PM"                 // H:MM AM/PM (12-hour)
    "2006-01-02T15:04:05Z07:00" // ISO 8601
<

==============================================================================
8. SQL                                                      *date-formats-sql*

Date functions~                                   *date-formats-sql-functions*
>
    -- Date functions
    NOW()                     -- Current timestamp
    CURDATE()                 -- Current date
    CURTIME()                 -- Current time
<

MySQL formatting~                                     *date-formats-sql-mysql*
>
    -- Formatting (MySQL)
    DATE_FORMAT(date, format)
    DATE_FORMAT(NOW(), '%Y-%m-%d')           -- 2024-01-15
    DATE_FORMAT(NOW(), '%m/%d/%Y')           -- 01/15/2024
    DATE_FORMAT(NOW(), '%W, %M %d, %Y')      -- Monday, January 15, 2024
    DATE_FORMAT(NOW(), '%H:%i:%s')           -- 14:30:00
<

PostgreSQL formatting~                           *date-formats-sql-postgresql*
>
    -- Formatting (PostgreSQL)
    TO_CHAR(date, format)
    TO_CHAR(NOW(), 'YYYY-MM-DD')             -- 2024-01-15
    TO_CHAR(NOW(), 'MM/DD/YYYY')             -- 01/15/2024
    TO_CHAR(NOW(), 'Day, Month DD, YYYY')    -- Monday, January 15, 2024
    TO_CHAR(NOW(), 'HH24:MI:SS')             -- 14:30:00
<

Extract parts~                                         *date-formats-sql-parts*
>
    -- Extract parts
    YEAR(date)
    MONTH(date)
    DAY(date)
    HOUR(timestamp)
    MINUTE(timestamp)
    SECOND(timestamp)
<

Date arithmetic~                                   *date-formats-sql-arithmetic*
>
    -- Date arithmetic
    DATE_ADD(date, INTERVAL 1 DAY)
    DATE_SUB(date, INTERVAL 1 MONTH)
    date + INTERVAL '1 day'                   -- PostgreSQL
<

==============================================================================
9. UNIX TIMESTAMP                                        *date-formats-unix*

Unix timestamp format~                             *date-formats-unix-format*
>
    Seconds since January 1, 1970 00:00:00 UTC (Unix epoch)

    1705329000  = 2024-01-15 14:30:00 UTC
<

By language~                                          *date-formats-unix-langs*
>
    JavaScript (milliseconds):
    Date.now()               // 1705329000000
    new Date().getTime()     // 1705329000000

    Python (seconds):
    time.time()              // 1705329000.0

    Go (seconds):
    time.Now().Unix()        // 1705329000

    Bash:
    date +%s                 // 1705329000
<

==============================================================================
10. COMMON PATTERNS                                  *date-formats-patterns*

Common date/time patterns~                       *date-formats-patterns-list*
>
    ISO 8601:           2024-01-15T14:30:00Z
    RFC 2822:           Mon, 15 Jan 2024 14:30:00 +0000
    RFC 3339:           2024-01-15T14:30:00Z
    Unix timestamp:     1705329000
    US format:          01/15/2024
    EU format:          15/01/2024
    Long format:        January 15, 2024
    Short format:       Jan 15, 2024
    Time 24-hour:       14:30
    Time 12-hour:       2:30 PM
    Date and time:      2024-01-15 14:30:00
    Relative:           2 hours ago, in 3 days
<

==============================================================================
11. TIMEZONES                                        *date-formats-timezones*

Common timezones~                               *date-formats-timezones-list*
>
    UTC/GMT:            +00:00 or Z
    PST:                -08:00
    EST:                -05:00
    IST:                +05:30
    JST:                +09:00
<

Examples~                                     *date-formats-timezones-examples*
>
    2024-01-15T14:30:00Z             UTC
    2024-01-15T14:30:00+00:00        UTC (explicit)
    2024-01-15T09:30:00-05:00        EST
    2024-01-15T20:00:00+05:30        IST
<

==============================================================================
12. BEST PRACTICES                           *date-formats-best-practices*

Best practices for handling dates~              *date-formats-best-practices-list*
>
    1. Use ISO 8601 for storage and APIs
       ✓ 2024-01-15T14:30:00Z
       ✗ 01/15/2024 2:30 PM

    2. Store in UTC, display in local time
       Store: 2024-01-15T14:30:00Z
       Display: January 15, 2024 at 9:30 AM EST

    3. Include timezone information
       ✓ 2024-01-15T14:30:00+05:30
       ✗ 2024-01-15T14:30:00

    4. Use Unix timestamps for calculations
       const diff = timestamp2 - timestamp1;

    5. Be consistent across your app
       Pick one format and stick to it

    6. Handle timezones properly
       - User input in their timezone
       - Store in UTC
       - Display in their timezone
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
