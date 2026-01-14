*vim.txt*  Vim Reference

==============================================================================
CONTENTS                                                         *vim-contents*

1. Modes ................................. |vim-modes|
2. Basic Movement ........................ |vim-movement|
3. Advanced Movement ..................... |vim-movement-advanced|
4. Text Objects .......................... |vim-text-objects|
5. Operators ............................. |vim-operators|
6. Editing ............................... |vim-editing|
7. Search and Replace .................... |vim-search|
8. Marks and Jumps ....................... |vim-marks|
9. Registers ............................. |vim-registers|
10. Macros ............................... |vim-macros|
11. Visual Mode .......................... |vim-visual|
12. Windows and Tabs ..................... |vim-windows|
13. Buffers .............................. |vim-buffers|
14. File Operations ...................... |vim-files|
15. Command Mode ......................... |vim-commands|
16. Folding .............................. |vim-folding|
17. Autocomplete ......................... |vim-autocomplete|
18. Neovim LSP ........................... |vim-lsp|
19. Common Patterns ...................... |vim-patterns|

==============================================================================
1. MODES                                                            *vim-modes*

Mode switching~
>
    i       " Insert mode before cursor
    I       " Insert at beginning of line
    a       " Insert after cursor (append)
    A       " Append at end of line
    o       " Open new line below
    O       " Open new line above
    v       " Visual mode (character)
    V       " Visual line mode
    <C-v>   " Visual block mode
    R       " Replace mode
    <Esc>   " Return to normal mode
    <C-[>   " Return to normal mode (alternative)
<

==============================================================================
2. BASIC MOVEMENT                                                *vim-movement*

Basic navigation~
>
    h       " Left
    j       " Down
    k       " Up
    l       " Right
<

Word movement~
>
    w       " Next word start
    W       " Next WORD start (ignores punctuation)
    b       " Previous word start
    B       " Previous WORD start
    e       " Next word end
    E       " Next WORD end
    ge      " Previous word end
<

Line movement~
>
    0       " Start of line
    ^       " First non-blank character
    $       " End of line
    g_      " Last non-blank character
<

File navigation~
>
    gg      " First line of file
    G       " Last line of file
    123G    " Go to line 123
    :123    " Go to line 123
<

Screen positioning~
>
    H       " Top of screen (High)
    M       " Middle of screen
    L       " Bottom of screen (Low)

    <C-u>   " Scroll up half page
    <C-d>   " Scroll down half page
    <C-b>   " Scroll up full page (back)
    <C-f>   " Scroll down full page (forward)
    zz      " Center cursor on screen
    zt      " Cursor to top of screen
    zb      " Cursor to bottom of screen
<

==============================================================================
3. ADVANCED MOVEMENT                                     *vim-movement-advanced*

Character search on line~
>
    f{char}     " Find next {char} on line
    F{char}     " Find previous {char} on line
    t{char}     " Till (before) next {char}
    T{char}     " Till (before) previous {char}
    ;           " Repeat last f/F/t/T
    ,           " Repeat last f/F/t/T backwards
<

Special movements~
>
    %           " Jump to matching bracket/paren
    *           " Search for word under cursor forward
    #           " Search for word under cursor backward
    n           " Next search result
    N           " Previous search result

    {           " Previous paragraph/block
    }           " Next paragraph/block
    (           " Previous sentence
    )           " Next sentence
<

Jump list~
>
    gd          " Go to definition (local)
    gD          " Go to definition (global)
    <C-o>       " Jump to older position
    <C-i>       " Jump to newer position
<

==============================================================================
4. TEXT OBJECTS                                              *vim-text-objects*

Text object format: <operator><a/i><object>~
    a = "a" (includes delimiter)
    i = "inner" (excludes delimiter)

Word objects~
>
    iw      " Inner word
    aw      " A word (includes space)
    iW      " Inner WORD
    aW      " A WORD
<

Sentence and paragraph~
>
    is      " Inner sentence
    as      " A sentence
    ip      " Inner paragraph
    ap      " A paragraph
<

Quote objects~
>
    i"      " Inside quotes
    a"      " Around quotes (includes quotes)
    i'      " Inside single quotes
    a'      " Around single quotes
<

Bracket objects~
>
    i(      " Inside parentheses
    a(      " Around parentheses (includes parens)
    i[      " Inside brackets
    a[      " Around brackets
    i{      " Inside braces
    a{      " Around braces
    i<      " Inside angle brackets
    a<      " Around angle brackets
<

Tag objects (HTML/XML)~
>
    it      " Inner tag
    at      " Around tag
<

Examples~
>
    diw     " Delete inner word
    ci"     " Change inside quotes
    da(     " Delete around parentheses
    yip     " Yank inner paragraph
    vit     " Visually select inner tag
<

==============================================================================
5. OPERATORS                                                    *vim-operators*

Basic operators~
>
    d       " Delete
    c       " Change (delete and enter insert)
    y       " Yank (copy)
    p       " Paste after
    P       " Paste before
    ~       " Toggle case
    gu      " Make lowercase
    gU      " Make uppercase
    >       " Indent
    <       " Dedent
    =       " Auto-indent
<

Line operators~
>
    dd      " Delete line
    cc      " Change line
    yy      " Yank line
    D       " Delete to end of line
    C       " Change to end of line
    Y       " Yank line (same as yy)
<

Combining with motions~
>
    dw      " Delete word
    cw      " Change word
    d$      " Delete to end of line
    c^      " Change to start of line
    y}      " Yank to next paragraph
<

With counts~
>
    3dd     " Delete 3 lines
    2dw     " Delete 2 words
    5yy     " Yank 5 lines
<

==============================================================================
6. EDITING                                                       *vim-editing*

Character operations~
>
    x       " Delete character under cursor
    X       " Delete character before cursor
    s       " Substitute character (delete and insert)
    S       " Substitute line
    r{char} " Replace character with {char}
    R       " Enter replace mode
<

Undo/redo~
>
    u       " Undo
    <C-r>   " Redo
    U       " Undo all changes on line
    .       " Repeat last change
<

Line operations~
>
    J       " Join line below
    gJ      " Join line without space
    >>      " Indent line
    <<      " Dedent line
    ==      " Auto-indent line
<

Insert mode special keys~
>
    <C-w>   " Delete word before cursor
    <C-u>   " Delete to start of line
    <C-t>   " Indent current line
    <C-d>   " Dedent current line
<

==============================================================================
7. SEARCH AND REPLACE                                             *vim-search*

Search~
>
    /pattern        " Search forward
    ?pattern        " Search backward
    n               " Next match
    N               " Previous match
    *               " Search word under cursor forward
    #               " Search word under cursor backward
    :noh            " Clear search highlighting
<

Replace~
>
    :s/old/new/     " Replace first on line
    :s/old/new/g    " Replace all on line
    :%s/old/new/g   " Replace all in file
    :%s/old/new/gc  " Replace all with confirmation
<

Range replace~
>
    :10,20s/old/new/g       " Lines 10-20
    :'<,'>s/old/new/g       " Visual selection
    :.,$s/old/new/g         " Current line to end
<

Regex flags~
>
    /pattern/i      " Case insensitive
    /pattern/I      " Case sensitive
    /\<word\>       " Match whole word
    /\vpattern      " Very magic (less escaping)
<

Common patterns~
>
    :%s/\s\+$//     " Remove trailing whitespace
    :%s/\n\n\+/\r\r/g  " Remove multiple blank lines
<

==============================================================================
8. MARKS AND JUMPS                                                 *vim-marks*

Setting marks~
>
    m{a-z}      " Set mark (lowercase = file-local)
    m{A-Z}      " Set mark (uppercase = global)
    '{a-z}      " Jump to mark
    `{a-z}      " Jump to exact mark position
    ''          " Jump to last position
    ``          " Jump to exact last position
<

Mark management~
>
    :marks      " List all marks
    :delmarks a " Delete mark a
    :delmarks!  " Delete all lowercase marks
<

Special marks~
>
    '.          " Last change position
    '[          " Start of last change/yank
    ']          " End of last change/yank
    '<          " Start of last visual selection
    '>          " End of last visual selection
<

==============================================================================
9. REGISTERS                                                    *vim-registers*

Using registers~
>
    "{register}     " Use specific register
<

Named registers (a-z)~
>
    "ayy            " Yank line to register a
    "ap             " Paste from register a
<

Special registers~
>
    ""              " Unnamed (default)
    "0              " Last yank
    "1-9            " Delete history
    "-              " Small delete
    "+              " System clipboard
    "*              " Selection clipboard
    "/              " Last search
    ":              " Last command
    ".              " Last inserted text
    "%              " Current filename
    "#              " Alternate filename
<

Register commands~
>
    :reg            " Show all registers
    :reg a          " Show register a
<

Examples~
>
    "+yy            " Yank line to system clipboard
    "+p             " Paste from system clipboard
    "0p             " Paste last yank (ignoring deletes)
<

==============================================================================
10. MACROS                                                         *vim-macros*

Recording macros~
>
    q{a-z}      " Start recording macro to register
    q           " Stop recording
    @{a-z}      " Play macro
    @@          " Replay last macro
    10@a        " Play macro 10 times
<

Example workflow~
>
    qa          " Start recording to register a
    j           " Move down
    dw          " Delete word
    q           " Stop recording
    10@a        " Execute macro 10 times
<

Edit macro~
>
    :let @a='new content'
    " Or paste, edit, and yank back
    "ap
    " edit
    "ayy
<

==============================================================================
11. VISUAL MODE                                                    *vim-visual*

Visual mode types~
>
    v           " Character-wise visual
    V           " Line-wise visual
    <C-v>       " Block visual
    o           " Toggle cursor to other end
    O           " Move to other corner (block mode)
    gv          " Reselect last visual selection
<

Visual mode operations~
>
    d           " Delete selection
    c           " Change selection
    y           " Yank selection
    >           " Indent selection
    <           " Dedent selection
    =           " Auto-indent selection
    ~           " Toggle case
    u           " Lowercase
    U           " Uppercase
<

Block mode special~
>
    I           " Insert at start of all lines
    A           " Append at end of all lines
    c           " Change all lines
<

==============================================================================
12. WINDOWS AND TABS                                              *vim-windows*

Window splits~
>
    :split or :sp       " Horizontal split
    :vsplit or :vsp     " Vertical split
    :new                " New window
    :vnew               " New vertical window

    <C-w>s              " Horizontal split
    <C-w>v              " Vertical split
    <C-w>q              " Quit window
    <C-w>o              " Close all other windows
<

Window navigation~
>
    <C-w>h              " Move to left window
    <C-w>j              " Move to below window
    <C-w>k              " Move to above window
    <C-w>l              " Move to right window
    <C-w>w              " Cycle through windows
    <C-w>p              " Previous window
<

Window resize~
>
    <C-w>=              " Equal size
    <C-w>_              " Max height
    <C-w>|              " Max width
    <C-w>10+            " Increase height by 10
    <C-w>10-            " Decrease height by 10
    <C-w>10>            " Increase width by 10
    <C-w>10<            " Decrease width by 10
    :resize 20          " Set height to 20
    :vertical resize 80 " Set width to 80
<

Window moving~
>
    <C-w>H              " Move window to far left
    <C-w>J              " Move window to bottom
    <C-w>K              " Move window to top
    <C-w>L              " Move window to far right
    <C-w>r              " Rotate windows
    <C-w>x              " Exchange with next window
<

Tabs~
>
    :tabnew             " New tab
    :tabnew file.txt    " Open file in new tab
    :tabclose           " Close tab
    :tabonly            " Close all other tabs
    gt                  " Next tab
    gT                  " Previous tab
    1gt                 " Go to tab 1
    :tabs               " List tabs
<

==============================================================================
13. BUFFERS                                                       *vim-buffers*

Buffer operations~
>
    :e file.txt         " Edit file (open buffer)
    :bnext or :bn       " Next buffer
    :bprev or :bp       " Previous buffer
    :buffer N or :b N   " Go to buffer N
    :bfirst             " First buffer
    :blast              " Last buffer
    :buffers or :ls     " List buffers
    :bdelete or :bd     " Delete buffer
    :bwipeout           " Wipeout buffer (clear history)
<

Buffer navigation~
>
    <C-^>               " Toggle between current and alternate
    :b partial_name     " Go to buffer by partial name
<

Buffer states~
    %   current
    #   alternate
    a   active (loaded and displayed)
    h   hidden (loaded but not displayed)
    -   not modifiable
    +   modified

==============================================================================
14. FILE OPERATIONS                                                *vim-files*

File commands~
>
    :w                  " Write (save)
    :w filename         " Save as filename
    :wa                 " Write all buffers
    :q                  " Quit
    :q!                 " Quit without saving
    :wq or :x or ZZ     " Write and quit
    :qa                 " Quit all
    :qa!                " Quit all without saving
<

File editing~
>
    :e filename         " Edit file
    :e!                 " Reload file (discard changes)
    :e .                " Browse current directory
    :find filename      " Find and open file
<

Read/write commands~
>
    :r filename         " Read file and insert below cursor
    :r !command         " Insert command output
<

Directory operations~
>
    :pwd                " Print working directory
    :cd path            " Change directory
    :cd -               " Go to previous directory
<

Netrw (file browser)~
>
    :E or :Ex           " Explore current directory
    :Sex                " Split and explore
    :Vex                " Vertical split and explore
<

==============================================================================
15. COMMAND MODE                                                *vim-commands*

Basic commands~
>
    :                   " Enter command mode
    :!command           " Execute shell command
    :shell              " Open shell
    :r !command         " Insert command output
<

Range commands~
>
    :10,20d             " Delete lines 10-20
    :5,10y              " Yank lines 5-10
    :1,5m10             " Move lines 1-5 after line 10
    :1,5t10             " Copy lines 1-5 after line 10
    :.,$d               " Delete from current to end
    :%d                 " Delete all lines
    :g/pattern/d        " Delete all lines matching pattern
    :g!/pattern/d       " Delete lines NOT matching pattern
    :v/pattern/d        " Delete lines NOT matching (same as g!)
<

Command history~
>
    :10                 " Go to line 10
    @:                  " Repeat last command
    @@                  " Repeat again
    q:                  " Open command history window
    :<Up>               " Previous command
    :<Down>             " Next command
<

==============================================================================
16. FOLDING                                                       *vim-folding*

Fold commands~
>
    zf{motion}          " Create fold
    zf3j                " Fold 3 lines down
    zfa{                " Fold around braces

    zo                  " Open fold
    zc                  " Close fold
    za                  " Toggle fold
    zR                  " Open all folds
    zM                  " Close all folds

    zj                  " Move to next fold
    zk                  " Move to previous fold
<

Fold methods~
>
    :set foldmethod=manual      " Manual folding
    :set foldmethod=indent      " Fold by indentation
    :set foldmethod=syntax      " Fold by syntax
    :set foldmethod=marker      " Fold by markers
<

==============================================================================
17. AUTOCOMPLETE                                              *vim-autocomplete*

Insert mode completion~
>
    <C-n>               " Next completion
    <C-p>               " Previous completion
    <C-x><C-n>          " Word completion (current file)
    <C-x><C-f>          " File path completion
    <C-x><C-l>          " Line completion
    <C-x><C-o>          " Omni completion (language-aware)
    <C-x><C-]>          " Tag completion
<

Accept completion~
>
    <Enter>             " Accept and continue
    <C-y>               " Accept (yes)
    <C-e>               " Cancel (exit)
<

==============================================================================
18. NEOVIM LSP                                                       *vim-lsp*

Common LSP commands~
>
    gd                  " Go to definition
    gr                  " Show references
    K                   " Hover documentation
    <leader>rn          " Rename symbol
    <leader>ca          " Code actions
    [d                  " Previous diagnostic
    ]d                  " Next diagnostic
    <leader>f           " Format document
<

==============================================================================
19. COMMON PATTERNS                                              *vim-patterns*

Line operations~
>
    :g/^$/d             " Delete all empty lines
    :%s/\s\+$//e        " Delete trailing whitespace
    :sort               " Sort lines
    :sort!              " Reverse sort
    :sort u             " Unique sort
<

Tab/space operations~
>
    :set expandtab      " Use spaces instead of tabs
    :retab              " Convert tabs to spaces
<

Number operations~
>
    <C-a>               " Increment number under cursor
    <C-x>               " Decrement number under cursor
    g<C-a>              " Incrementing sequence (visual block)
<

Text transformations~
>
    :g/^/m0             " Reverse lines
    :%s/^/\=line('.').'. '  " Add line numbers
    :%s/\<\(\w\)\(\w*\)\>/\u\1\L\2/g  " Capitalize words
<

Paragraph formatting~
>
    gq{motion}          " Reformat
    gwip                " Reformat paragraph
<

Normal mode on range~
>
    :1,5norm A;         " Append ; to lines 1-5
    :'<,'>norm I//      " Comment visual selection
<

Multiple cursors effect (block visual)~
>
    <C-v>               " Select column
    I text <Esc>        " Insert at start of all lines
    A text <Esc>        " Append at end of all lines
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
