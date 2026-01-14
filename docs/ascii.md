*ascii.txt*  ASCII Character Codes Reference

==============================================================================
CONTENTS                                                        *ascii-contents*

1. ASCII Table ........................... |ascii-table|
2. Quick Reference ....................... |ascii-quick|
3. Common Codes .......................... |ascii-common|
4. Conversions ........................... |ascii-conversions|
5. Escape Sequences ...................... |ascii-escape|

==============================================================================
1. ASCII TABLE                                                  *ascii-table*

Complete ASCII table (0-127)~                            *ascii-table-full*
>
    Dec  Hex  Char  Description
    0    00   NUL   Null
    1    01   SOH   Start of Heading
    2    02   STX   Start of Text
    3    03   ETX   End of Text
    4    04   EOT   End of Transmission
    5    05   ENQ   Enquiry
    6    06   ACK   Acknowledgment
    7    07   BEL   Bell
    8    08   BS    Backspace
    9    09   HT    Horizontal Tab
    10   0A   LF    Line Feed
    11   0B   VT    Vertical Tab
    12   0C   FF    Form Feed
    13   0D   CR    Carriage Return
    14   0E   SO    Shift Out
    15   0F   SI    Shift In
    16   10   DLE   Data Link Escape
    17   11   DC1   Device Control 1
    18   12   DC2   Device Control 2
    19   13   DC3   Device Control 3
    20   14   DC4   Device Control 4
    21   15   NAK   Negative Acknowledgment
    22   16   SYN   Synchronous Idle
    23   17   ETB   End of Transmission Block
    24   18   CAN   Cancel
    25   19   EM    End of Medium
    26   1A   SUB   Substitute
    27   1B   ESC   Escape
    28   1C   FS    File Separator
    29   1D   GS    Group Separator
    30   1E   RS    Record Separator
    31   1F   US    Unit Separator
    32   20   SP    Space
    33   21   !     Exclamation mark
    34   22   "     Quotation mark
    35   23   #     Number sign
    36   24   $     Dollar sign
    37   25   %     Percent sign
    38   26   &     Ampersand
    39   27   '     Apostrophe
    40   28   (     Left parenthesis
    41   29   )     Right parenthesis
    42   2A   *     Asterisk
    43   2B   +     Plus sign
    44   2C   ,     Comma
    45   2D   -     Hyphen-minus
    46   2E   .     Period
    47   2F   /     Slash
    48   30   0     Digit Zero
    49   31   1     Digit One
    50   32   2     Digit Two
    51   33   3     Digit Three
    52   34   4     Digit Four
    53   35   5     Digit Five
    54   36   6     Digit Six
    55   37   7     Digit Seven
    56   38   8     Digit Eight
    57   39   9     Digit Nine
    58   3A   :     Colon
    59   3B   ;     Semicolon
    60   3C   <     Less-than sign
    61   3D   =     Equal sign
    62   3E   >     Greater-than sign
    63   3F   ?     Question mark
    64   40   @     At sign
    65   41   A     Uppercase A
    66   42   B     Uppercase B
    67   43   C     Uppercase C
    68   44   D     Uppercase D
    69   45   E     Uppercase E
    70   46   F     Uppercase F
    71   47   G     Uppercase G
    72   48   H     Uppercase H
    73   49   I     Uppercase I
    74   4A   J     Uppercase J
    75   4B   K     Uppercase K
    76   4C   L     Uppercase L
    77   4D   M     Uppercase M
    78   4E   N     Uppercase N
    79   4F   O     Uppercase O
    80   50   P     Uppercase P
    81   51   Q     Uppercase Q
    82   52   R     Uppercase R
    83   53   S     Uppercase S
    84   54   T     Uppercase T
    85   55   U     Uppercase U
    86   56   V     Uppercase V
    87   57   W     Uppercase W
    88   58   X     Uppercase X
    89   59   Y     Uppercase Y
    90   5A   Z     Uppercase Z
    91   5B   [     Left square bracket
    92   5C   \     Backslash
    93   5D   ]     Right square bracket
    94   5E   ^     Caret
    95   5F   _     Underscore
    96   60   `     Grave accent
    97   61   a     Lowercase a
    98   62   b     Lowercase b
    99   63   c     Lowercase c
    100  64   d     Lowercase d
    101  65   e     Lowercase e
    102  66   f     Lowercase f
    103  67   g     Lowercase g
    104  68   h     Lowercase h
    105  69   i     Lowercase i
    106  6A   j     Lowercase j
    107  6B   k     Lowercase k
    108  6C   l     Lowercase l
    109  6D   m     Lowercase m
    110  6E   n     Lowercase n
    111  6F   o     Lowercase o
    112  70   p     Lowercase p
    113  71   q     Lowercase q
    114  72   r     Lowercase r
    115  73   s     Lowercase s
    116  74   t     Lowercase t
    117  75   u     Lowercase u
    118  76   v     Lowercase v
    119  77   w     Lowercase w
    120  78   x     Lowercase x
    121  79   y     Lowercase y
    122  7A   z     Lowercase z
    123  7B   {     Left curly brace
    124  7C   |     Vertical bar
    125  7D   }     Right curly brace
    126  7E   ~     Tilde
    127  7F   DEL   Delete
<

==============================================================================
2. QUICK REFERENCE                                              *ascii-quick*

Character ranges~                                        *ascii-quick-ranges*
>
    Control Characters (0-31, 127)
    Printable (32-126)

    Digits:        48-57   (0-9)
    Uppercase:     65-90   (A-Z)
    Lowercase:     97-122  (a-z)

    Space:         32
    Newline:       10  (LF)
    Carriage Ret:  13  (CR)
    Tab:           9
<

==============================================================================
3. COMMON CODES                                                *ascii-common*

Whitespace~                                           *ascii-common-whitespace*
>
    32  Space
    9   Tab
    10  Line Feed (LF) \n
    13  Carriage Return (CR) \r
<

Punctuation~                                         *ascii-common-punctuation*
>
    33  !
    46  .
    44  ,
    63  ?
    58  :
    59  ;
<

Math operators~                                            *ascii-common-math*
>
    43  +
    45  -
    42  *
    47  /
    61  =
<

Brackets~                                              *ascii-common-brackets*
>
    40  (
    41  )
    91  [
    93  ]
    123 {
    125 }
<

Quotes~                                                  *ascii-common-quotes*
>
    34  " (double)
    39  ' (single)
    96  ` (backtick)
<

==============================================================================
4. CONVERSIONS                                              *ascii-conversions*

Bash conversions~                                   *ascii-conversions-bash*
>
    # Decimal to character
    printf '\x41'        # A (hex)
    echo -e '\101'       # A (octal)
    printf "$(printf '\\%03o' 65)"  # A (decimal)

    # Character to decimal
    printf '%d\n' "'A"   # 65

    # Show ASCII value
    man ascii
<

Programming conversions~                            *ascii-conversions-code*
>
    # JavaScript
    'A'.charCodeAt(0)              // 65
    String.fromCharCode(65)        // 'A'

    # Python
    ord('A')                       # 65
    chr(65)                        # 'A'

    # C/C++
    int code = (int)'A';           // 65
    char c = (char)65;             // 'A'

    # Go
    code := int('A')               // 65
    c := rune(65)                  // 'A'
<

Conversion formulas~                              *ascii-conversions-formulas*
>
    # Uppercase to lowercase
    lowercase = uppercase + 32
    'A' (65) + 32 = 'a' (97)

    # Lowercase to uppercase
    uppercase = lowercase - 32
    'a' (97) - 32 = 'A' (65)

    # Digit character to integer
    integer = digit - 48
    '5' (53) - 48 = 5

    # Integer to digit character
    digit = integer + 48
    5 + 48 = '5' (53)
<

Validation checks~                                *ascii-conversions-validation*
>
    # Check if letter
    (char >= 65 && char <= 90) ||   // Uppercase
    (char >= 97 && char <= 122)     // Lowercase

    # Check if digit
    char >= 48 && char <= 57

    # Check if alphanumeric
    (char >= 48 && char <= 57) ||   // Digit
    (char >= 65 && char <= 90) ||   // Uppercase
    (char >= 97 && char <= 122)     // Lowercase

    # Check if printable
    char >= 32 && char <= 126
<

==============================================================================
5. ESCAPE SEQUENCES                                            *ascii-escape*

Common escape sequences~                               *ascii-escape-common*
>
    \n   Newline (LF)
    \r   Carriage Return (CR)
    \t   Tab
    \b   Backspace
    \f   Form Feed
    \v   Vertical Tab
    \\   Backslash
    \'   Single quote
    \"   Double quote
    \0   Null
<

Extended escape sequences~                           *ascii-escape-extended*
>
    \a       Alert (bell)
    \xhh     Hex value (e.g., \x41 = 'A')
    \ooo     Octal value (e.g., \101 = 'A')
    \uhhhh   Unicode (4 hex digits)
    \Uhhhhhhhh Unicode (8 hex digits)
<

Language-specific~                                   *ascii-escape-languages*
>
    # JavaScript/C/C++/Java
    '\n'   Newline
    '\t'   Tab
    '\\'   Backslash
    '\''   Single quote (in char literals)
    '\"'   Double quote

    # Python
    '\n'   Newline
    '\t'   Tab
    '\\'   Backslash
    r'\n'  Raw string (literal \n)

    # Bash
    $'\n'  Newline
    $'\t'  Tab
    $'\\'  Backslash
    echo -e "\n"  # With -e flag
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
