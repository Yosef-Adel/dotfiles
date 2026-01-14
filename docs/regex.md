*regex.txt*  Regular Expressions Reference

==============================================================================
CONTENTS                                                        *regex-contents*

1. Basic Syntax .......................... |regex-syntax|
2. Character Classes ..................... |regex-classes|
3. Quantifiers ........................... |regex-quantifiers|
4. Anchors ............................... |regex-anchors|
5. Groups and Capturing .................. |regex-groups|
6. Lookahead and Lookbehind .............. |regex-lookaround|
7. Flags/Modifiers ....................... |regex-flags|
8. Common Patterns ....................... |regex-patterns|
9. Language-Specific ..................... |regex-languages|
10. Examples ............................. |regex-examples|

==============================================================================
1. BASIC SYNTAX                                                   *regex-syntax*

Basic metacharacters~
>
    .           # Any character except newline
    \w          # Word character [a-zA-Z0-9_]
    \W          # Non-word character
    \d          # Digit [0-9]
    \D          # Non-digit
    \s          # Whitespace [ \t\r\n\f]
    \S          # Non-whitespace
    \b          # Word boundary
    \B          # Non-word boundary

    [abc]       # Any of a, b, or c
    [^abc]      # Not a, b, or c
    [a-z]       # Lowercase letters
    [A-Z]       # Uppercase letters
    [0-9]       # Digits
    [a-zA-Z]    # All letters

    \           # Escape special characters
    \n          # Newline
    \t          # Tab
    \r          # Carriage return
    \\          # Literal backslash
    \.          # Literal dot
<

==============================================================================
2. CHARACTER CLASSES                                             *regex-classes*

Standard classes~
>
    \w          # [a-zA-Z0-9_]
    \d          # [0-9]
    \s          # [ \t\r\n\f]
<

POSIX classes (when supported)~
>
    [:alnum:]   # Alphanumeric [a-zA-Z0-9]
    [:alpha:]   # Alphabetic [a-zA-Z]
    [:digit:]   # Digits [0-9]
    [:lower:]   # Lowercase [a-z]
    [:upper:]   # Uppercase [A-Z]
    [:space:]   # Whitespace
    [:punct:]   # Punctuation
<

Custom classes~
>
    [aeiou]     # Vowels
    [^aeiou]    # Non-vowels (negation)
    [0-5]       # Digits 0-5
    [a-fA-F0-9] # Hexadecimal
<

==============================================================================
3. QUANTIFIERS                                                *regex-quantifiers*

Greedy quantifiers~
>
    *           # 0 or more (greedy)
    +           # 1 or more (greedy)
    ?           # 0 or 1 (optional)
    {n}         # Exactly n times
    {n,}        # n or more times
    {n,m}       # Between n and m times
<

Non-greedy (lazy) quantifiers~
>
    *?          # 0 or more (lazy)
    +?          # 1 or more (lazy)
    ??          # 0 or 1 (lazy)
    {n,}?       # n or more (lazy)
    {n,m}?      # Between n and m (lazy)
<

Examples~                                               *regex-quantifier-examples*
>
    a*          # "", "a", "aa", "aaa"...
    a+          # "a", "aa", "aaa"... (at least one)
    a?          # "" or "a"
    a{3}        # "aaa"
    a{2,4}      # "aa", "aaa", "aaaa"
    a{2,}       # "aa", "aaa", "aaaa"... (at least 2)

    # Greedy vs lazy
    <.*>        # Matches <div>hello</div> as one match
    <.*?>       # Matches <div> and </div> separately
<

==============================================================================
4. ANCHORS                                                       *regex-anchors*

Position anchors~
>
    ^           # Start of line/string
    $           # End of line/string
    \A          # Start of string (not line)
    \Z          # End of string (not line)
    \b          # Word boundary
    \B          # Non-word boundary
<

Examples~                                              *regex-anchor-examples*
>
    ^hello      # "hello" at start of line
    world$      # "world" at end of line
    ^hello$     # Entire line is "hello"
    \bhello\b   # "hello" as complete word
<

==============================================================================
5. GROUPS AND CAPTURING                                          *regex-groups*

Group types~
>
    (pattern)       # Capturing group
    (?:pattern)     # Non-capturing group
    (?<name>pattern) # Named capturing group
<

Backreferences~                                         *regex-backreferences*
>
    \1              # Reference to group 1
    \2              # Reference to group 2
    \k<name>        # Reference to named group
<

Examples~                                              *regex-group-examples*
>
    (\w+)\s\1       # Matches repeated word: "hello hello"
    (\d{3})-\1      # Matches "123-123"

    # Non-capturing (better performance)
    (?:https?://)?example\.com

    # Alternation
    cat|dog         # "cat" or "dog"
    gr(a|e)y        # "gray" or "grey"
<

==============================================================================
6. LOOKAHEAD AND LOOKBEHIND                                   *regex-lookaround*

Lookahead~                                              *regex-lookahead*
>
    (?=pattern)     # Positive lookahead
    (?!pattern)     # Negative lookahead
<

Lookbehind~                                             *regex-lookbehind*
>
    (?<=pattern)    # Positive lookbehind
    (?<!pattern)    # Negative lookbehind
<

Examples~                                         *regex-lookaround-examples*
>
    \d(?=px)        # Digit followed by "px": "10px" → "10"
    \d(?!px)        # Digit NOT followed by "px"

    (?<=\$)\d+      # Number after dollar sign: "$100" → "100"
    (?<!\d)\d{3}    # 3 digits NOT preceded by digit

    # Password validation (contains at least one digit)
    ^(?=.*\d).{8,}$

    # Password with letter, digit, and special char
    ^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$
<

==============================================================================
7. FLAGS/MODIFIERS                                                *regex-flags*

Common flags~
>
    i           # Case insensitive
    g           # Global (find all matches)
    m           # Multiline (^ and $ match line breaks)
    s           # Dotall (. matches newlines)
    u           # Unicode
    x           # Extended (ignore whitespace, allow comments)
<

Usage in different languages~
>
    /pattern/i          # JavaScript
    /pattern/gi         # JavaScript global + case insensitive
    (?i)pattern         # Go inline flag
    (?m)^pattern        # Multiline mode
<

==============================================================================
8. COMMON PATTERNS                                              *regex-patterns*

Email~                                                  *regex-email*
>
    [\w.-]+@[\w.-]+\.\w+
    [a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}
<

URL~                                                    *regex-url*
>
    https?://[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+
<

Phone (US)~                                             *regex-phone*
>
    \d{3}-\d{3}-\d{4}
    \(\d{3}\)\s?\d{3}-\d{4}
<

Date formats~                                           *regex-date*
>
    \d{4}-\d{2}-\d{2}                # YYYY-MM-DD
    \d{2}/\d{2}/\d{4}                # MM/DD/YYYY
    \d{1,2}/\d{1,2}/\d{2,4}          # Flexible
<

Time~                                                   *regex-time*
>
    \d{2}:\d{2}:\d{2}                # HH:MM:SS
    \d{1,2}:\d{2}\s?[AP]M            # 12-hour format
<

IP Address (IPv4)~                                      *regex-ip*
>
    \b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b
    \b(?:\d{1,3}\.){3}\d{1,3}\b
<

Hex color~                                              *regex-color*
>
    #[0-9a-fA-F]{6}
    #[0-9a-fA-F]{3,6}
<

Username~                                               *regex-username*
>
    ^[a-zA-Z0-9_]{3,16}$
<

Strong password~                                        *regex-password*
>
    ^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$
<

Credit card~                                            *regex-creditcard*
>
    \d{4}[\s-]?\d{4}[\s-]?\d{4}[\s-]?\d{4}
<

Markdown link~                                          *regex-markdown*
>
    \[([^\]]+)\]\(([^)]+)\)
<

HTML tag~                                               *regex-html*
>
    <([a-z]+)([^>]*)>(.*?)</\1>
<

Trailing whitespace~                                    *regex-whitespace*
>
    \s+$
<

Numbers~                                                *regex-numbers*
>
    -?\d+                            # Integer
    -?\d+\.\d+                       # Decimal
    -?\d+\.?\d*                      # Integer or decimal
<

==============================================================================
9. LANGUAGE-SPECIFIC                                          *regex-languages*

JavaScript~                                             *regex-javascript*
>
    // Creating regex
    const regex1 = /pattern/flags;
    const regex2 = new RegExp('pattern', 'flags');

    // Methods
    str.match(/pattern/g)            // Array of matches
    str.matchAll(/pattern/g)         // Iterator of matches
    str.replace(/pattern/g, 'text')  // Replace
    str.search(/pattern/)            // Index of match
    str.split(/pattern/)             // Split by pattern
    /pattern/.test(str)              // Boolean
    /pattern/.exec(str)              // Match details

    // Named groups
    const re = /(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})/;
    const {groups} = '2024-01-15'.match(re);
    console.log(groups.year); // '2024'

    // Replace with function
    text.replace(/\d+/g, (match) => parseInt(match) * 2);
<

Go~                                                     *regex-go*
>
    import "regexp"

    // Compile regex
    re := regexp.MustCompile(`pattern`)
    re, err := regexp.Compile(`pattern`)

    // Methods
    re.MatchString(str)              // Boolean
    re.FindString(str)               // First match
    re.FindAllString(str, -1)        // All matches
    re.ReplaceAllString(str, repl)   // Replace
    re.Split(str, -1)                // Split

    // Named groups
    re := regexp.MustCompile(`(?P<year>\d{4})-(?P<month>\d{2})`)
    match := re.FindStringSubmatch("2024-01")

    // Inline flags
    (?i)pattern     // Case insensitive
    (?m)pattern     // Multiline
    (?s)pattern     // Dotall
<

Bash~                                                   *regex-bash*
>
    # Using grep
    grep 'pattern' file.txt
    grep -E 'pattern' file.txt      # Extended regex
    grep -P 'pattern' file.txt      # Perl regex

    # Using sed
    sed 's/pattern/replacement/' file.txt

    # Using [[ ]] (bash builtin)
    if [[ $str =~ pattern ]]; then
        echo "${BASH_REMATCH[0]}"   # Full match
        echo "${BASH_REMATCH[1]}"   # Group 1
    fi

    # Examples
    [[ "test123" =~ [0-9]+ ]] && echo "has numbers"
<

Python~                                                 *regex-python*
>
    import re

    # Methods
    re.match(pattern, str)           # Match at start
    re.search(pattern, str)          # Find anywhere
    re.findall(pattern, str)         # All matches
    re.finditer(pattern, str)        # Iterator
    re.sub(pattern, repl, str)       # Replace
    re.split(pattern, str)           # Split

    # Compile for reuse
    regex = re.compile(r'pattern')
    regex.search(str)

    # Named groups
    match = re.search(r'(?P<year>\d{4})-(?P<month>\d{2})', date)
    match.group('year')

    # Flags
    re.IGNORECASE or re.I
    re.MULTILINE or re.M
    re.DOTALL or re.S
<

Vim~                                                    *regex-vim*
>
    " Very magic (\v) - most like standard regex
    /\v pattern
    :%s/\vpattern/replace/g

    " Special vim patterns
    \<          " Start of word
    \>          " End of word
    \%^         " Start of file
    \%$         " End of file
    \zs         " Start of match
    \ze         " End of match

    " Examples
    /\<word\>               " Match whole word
    :%s/\v(\w+)\s+\1/\1/g  " Remove duplicate words
    :%s/\v\s+$//           " Remove trailing whitespace
    /\v<word>              " Whole word (less escaping)
<

==============================================================================
10. EXAMPLES                                                    *regex-examples*

Extract domain from email~
>
    (?<=@)[\w.-]+
<

Extract domain from URL~
>
    (?<=://)([\w.-]+)
<

Remove HTML tags~
>
    <[^>]*>
<

Validate hex color~
>
    ^#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3})$
<

Match quoted string~
>
    "([^"\\]|\\.)*"
    '([^'\\]|\\.)*'
<

CSV parsing (basic)~
>
    (?:^|,)(?:"([^"]*)"|([^,]*))
<

Camel case to snake case~
>
    ([a-z])([A-Z])  →  \1_\2
<

Find duplicated words~
>
    \b(\w+)\s+\1\b
<

Version number~
>
    \d+\.\d+\.\d+(-[a-zA-Z0-9]+)?
<

IPv4 address (accurate)~
>
    ^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$
<

JWT token~
>
    ^[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+\.[A-Za-z0-9-_]*$
<

File extension~
>
    \.([a-zA-Z0-9]+)$
<

Extract YouTube video ID~
>
    (?:youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]{11})
<

Social security number (US)~
>
    ^\d{3}-\d{2}-\d{4}$
<

MAC address~
>
    ^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$
<

UUID~
>
    ^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$
<

Remove comments (C-style)~
>
    //.*$           # Single line
    /\*[\s\S]*?\*/ # Multi-line
<

Match environment variables~
>
    \$\{?([A-Z_][A-Z0-9_]*)\}?
<

Extract URLs from markdown links~
>
    \[([^\]]+)\]\(([^)]+)\)  → $2
<

Validate slug (URL-friendly string)~
>
    ^[a-z0-9]+(?:-[a-z0-9]+)*$
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
