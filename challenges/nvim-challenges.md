# Neovim Navigation & Manipulation Challenges

Complete these challenges to master Neovim text editing. For each challenge, try to use the most efficient motion/command possible.

---

## Level 1: Basic Navigation

### Challenge 1: Word Movement

**Description:** Learn to navigate between words efficiently using `w`, `W`, `e`, and `b` motions. These are fundamental to fast text navigation.

**Practice 1:**

```
The quick brown fox jumps over the lazy dog
```

Starting at 'T', move to 'f' in "fox" using only 3 keystrokes

**Practice 2:**

```
Hello world this is a test sentence
```

Starting at 'H', move to the end of "test" using word motions

**Practice 3:**

```
one two three four five six seven
```

Starting at 'o', move backward to the beginning of "three"

**Solution Hints:** `w` moves to start of next word, `e` moves to end of current/next word, `b` moves backward

**Common Mistakes:** Using `l` repeatedly instead of word motions; forgetting that `W` treats punctuation as part of word

---

### Challenge 2: Line Jumping

**Description:** Master vertical navigation using line numbers, `G`, `gg`, and relative jumps. Essential for navigating large files.

**Practice 1:**

```
1. First line
2. Second line
3. Third line
4. Fourth line
5. Fifth line
```

From line 1, jump to line 5 in one command

**Practice 2:**

```
Line A
Line B
Line C
Line D
Line E
Line F
Line G
```

From line A, jump to line D, then to line G, then back to line A

**Practice 3:**

```
Start here
...
...
Target line
```

Use relative line numbers to jump exactly 3 lines down

**Solution Hints:** `5G` or `5gg` goes to line 5; `3j` moves 3 lines down; `gg` goes to first line; `G` goes to last line

**Common Mistakes:** Not using `:set relativenumber` for efficient relative jumps; using `j` repeatedly

---

### Challenge 3: Character Find

**Description:** The `f`, `F`, `t`, `T` motions find characters on the current line. Combine with `;` and `,` to repeat.

**Practice 1:**

```
function calculateTotal(price, quantity, discount)
```

Starting at 'f', jump to the second comma in one motion

**Practice 2:**

```
const message = "Hello, World!";
```

From 'c', jump to the opening quote character

**Practice 3:**

```
array[index].property.value
```

From 'a', jump to each '.' character using find and repeat

**Solution Hints:** `f,;` finds first comma then repeats; `2f,` jumps directly to second comma; `;` repeats last f/t motion

**Common Mistakes:** Forgetting `;` to repeat; confusing `f` (to char) with `t` (till char - stops before)

---

## Level 2: Word Motions & Text Objects

### Challenge 4: Delete Words

**Description:** Combine `d` (delete) operator with word motions. Understanding counts (e.g., `3dw`) multiplies your efficiency.

**Practice 1:**

```
This is a very very very long sentence with redundant words
```

Delete "very very very " (3 words + space) with one command

**Practice 2:**

```
Remove these unnecessary extra words from this sentence
```

Delete "these unnecessary extra" without affecting surrounding text

**Practice 3:**

```
const temporaryVariable = someFunction();
```

Delete just "temporary" from "temporaryVariable"

**Solution Hints:** `d3w` or `3dw` deletes 3 words; `daw` deletes a word including space; `diw` deletes inner word only

**Common Mistakes:** Using `dw` repeatedly instead of count; not understanding difference between `dw` and `de`

---

### Challenge 5: Change Inside

**Description:** The `ci` (change inside) motion is one of Vim's most powerful features. It deletes inside a text object and enters insert mode.

**Practice 1:**

```
const message = "Hello, World!";
```

Change "Hello, World!" to "Goodbye!" without leaving normal mode twice

**Practice 2:**

```
function test(oldParam) { return oldParam; }
```

Change "oldParam" in parentheses to "newParam"

**Practice 3:**

```
const array = [1, 2, 3, 4, 5];
```

Change array contents to [10, 20, 30]

**Solution Hints:** `ci"` changes inside quotes; `ci(` or `ci)` changes inside parentheses; `ci[` changes inside brackets

**Common Mistakes:** Not placing cursor inside the target before using `ci`; forgetting that `ci` works with any delimiter

---

### Challenge 6: Delete Around

**Description:** The `da` (delete around) motion deletes the text object INCLUDING its delimiters. Contrast with `di` (inside only).

**Practice 1:**

```
The price is (100 dollars) for this item
```

Delete "(100 dollars) " including parentheses and trailing space

**Practice 2:**

```
Remove the 'quoted text' from this line
```

Delete 'quoted text' including the quotes

**Practice 3:**

```
function test(arg1, (nested), arg2)
```

Delete "(nested)" including parentheses

**Solution Hints:** `da(` or `dab` deletes around parentheses; `da'` deletes around single quotes; `daw` deletes a word with space

**Common Mistakes:** Confusing `di` and `da`; not realizing `da` includes surrounding whitespace for some objects

---

## Level 3: Line Operations

### Challenge 7: Delete Till End

**Description:** `d$` or `D` deletes from cursor to end of line. `d0` deletes to beginning. Master these for quick line edits.

**Practice 1:**

```
Remove everything after the colon: this should be deleted completely
```

From 'R', delete "this should be deleted completely"

**Practice 2:**

```
Keep this part -> delete everything after arrow
```

Position at '>', delete to end of line

**Practice 3:**

```
prefix_to_remove: keep this text
```

Delete from beginning up to and including ": "

**Solution Hints:** `f:lD` finds colon, moves right, deletes to end; `d$` same as `D`; `d0` deletes to line start

**Common Mistakes:** Forgetting `D` is shorthand for `d$`; not using `f` to position before delete

---

### Challenge 8: Change Till Character

**Description:** `ct{char}` changes text up to (but not including) a character. `cf{char}` includes the character.

**Practice 1:**

```
firstName = "OldValue" # Update this value
```

From 'f', change everything up to (not including) the '#' to 'firstName = "NewValue" '

**Practice 2:**

```
old_value -> new_value
```

Change "old_value" to "changed" (stop before the space)

**Practice 3:**

```
function(param1, param2, param3)
```

From 'p' in param1, change to first comma

**Solution Hints:** `ct#` changes till '#'; `cf,` changes through comma; `c2t,` changes till second comma

**Common Mistakes:** Confusing `ct` (till, exclusive) with `cf` (find, inclusive)

---

### Challenge 9: Join Lines

**Description:** `J` joins current line with next, adding a space. `gJ` joins without space. Essential for reformatting.

**Practice 1:**

```
const result =
    calculateValue();
```

Join these lines with a single space between '=' and 'calculateValue'

**Practice 2:**

```
This is a
multi-line
sentence
```

Join all three lines into one

**Practice 3:**

```
URL="https://
example.com/
path"
```

Join without adding spaces (use `gJ`)

**Solution Hints:** `J` joins with space; `3J` joins 3 lines; `gJ` joins without adding space

**Common Mistakes:** Not knowing about `gJ` for joining without spaces; using `J` repeatedly instead of count

---

## Level 4: Search & Navigate

### Challenge 10: Search Forward

**Description:** `/pattern` searches forward, `n` repeats search, `N` reverses. Use counts like `3n` for efficiency.

**Practice 1:**

```
apple banana apple cherry apple date apple elderberry
```

Starting at beginning, jump to the third "apple" efficiently

**Practice 2:**

```
error: something went wrong. error: another issue. error: final problem.
```

Find and jump between all "error:" occurrences

**Practice 3:**

```
TODO: fix this. NOTE: check later. TODO: urgent. TODO: low priority.
```

Jump to the second TODO

**Solution Hints:** `/apple` then `2n` (or `/apple` then `n` twice); `3/apple<CR>` finds third match

**Common Mistakes:** Not using count with `n`; forgetting `N` goes backward

---

### Challenge 11: Search Backward

**Description:** `?pattern` searches backward. Useful when you know the target is before your cursor.

**Practice 1:**

```
function test() { return true; } function main() { return false; }
```

From the end, jump to the first occurrence of "function"

**Practice 2:**

```
const a = 1; const b = 2; const c = 3;
```

From end, find the first "const"

**Practice 3:**

```
start -> middle -> end
```

From "end", search backward for "start"

**Solution Hints:** `?function<CR>` searches backward; `?` then `n` continues backward; `N` reverses to forward

**Common Mistakes:** Forgetting `n` after `?` still goes backward (opposite of after `/`)

---

### Challenge 12: Search Current Word

**Description:** `*` searches forward for word under cursor, `#` searches backward. Faster than typing the word.

**Practice 1:**

```
const value = 10;
let total = value + value * 2;
return value;
```

From the first "value", highlight all occurrences and jump between them

**Practice 2:**

```
function test() { test(); return test; }
```

From first "test", navigate to all occurrences

**Practice 3:**

```
data.process(data).filter(data => data.valid)
```

Find all "data" using word-under-cursor search

**Solution Hints:** `*` finds next occurrence; `#` finds previous; `g*` and `g#` for partial matches

**Common Mistakes:** Not knowing `g*` matches partial words (e.g., "test" in "testing")

---

## Level 5: Advanced Text Objects

### Challenge 13: Delete Inside Quotes

**Description:** Vim distinguishes between quote types: `"`, `'`, and backticks. `i"` targets inner double quotes specifically.

**Practice 1:**

```
print("This is a 'quoted' string with \"nested\" quotes")
```

Delete the text inside the outer double quotes only

**Practice 2:**

```
const template = `Hello, ${name}!`;
```

Delete content inside backticks

**Practice 3:**

```
message = 'Don\'t forget the "important" part'
```

Change content inside single quotes

**Solution Hints:** `di"` for double quotes; `di'` for single; `di`` for backticks; cursor can be anywhere on line

**Common Mistakes:** Not realizing Vim finds the quotes on the line; confusing quote types

---

### Challenge 14: Change Inside Brackets

**Description:** `i[`, `i{`, `i(`, and `i<` work with their respective bracket types. Use `a` variants to include brackets.

**Practice 1:**

```
const array = [1, 2, 3, 4, 5];
```

Replace array contents with [10, 20, 30]

**Practice 2:**

```
if (condition && other) { doSomething(); }
```

Change the condition inside parentheses

**Practice 3:**

```
const obj = { key: "value", other: "data" };
```

Delete everything inside the braces

**Solution Hints:** `ci[` changes inside brackets; `ci{` or `ciB` for braces; `ci(` or `cib` for parentheses

**Common Mistakes:** Forgetting `b` is alias for `(` and `B` for `{`

---

### Challenge 15: Delete Around Tags (HTML/XML)

**Description:** `it` and `at` work with HTML/XML tags. `it` targets content only, `at` includes the tags themselves.

**Practice 1:**

```
<div class="container"><p>Delete this entire paragraph</p></div>
```

Delete the entire `<p>` tag and its contents, leaving the div

**Practice 2:**

```
<span>Change this text</span>
```

Change the text inside the span tags

**Practice 3:**

```
<ul><li>Item 1</li><li>Item 2</li></ul>
```

Delete the first `<li>` element completely

**Solution Hints:** `dat` deletes around tag (including tags); `dit` deletes inside tag (content only); `cit` changes inside

**Common Mistakes:** Not having cursor inside the tag; `at`/`it` only works in filetypes with tag support

---

## Level 6: Vertical Navigation

### Challenge 16: Paragraph Jump

**Description:** `{` and `}` jump to previous/next blank line (paragraph boundary). Great for navigating code blocks.

**Practice 1:**

```
First paragraph text here.
More text in first paragraph.

Second paragraph starts here.
And continues here.

Third paragraph is here.
```

From first line, jump to "Third paragraph" using paragraph motions

**Practice 2:**

```
function one() {
    // code
}

function two() {
    // code
}

function three() {
    // code
}
```

Navigate between functions using paragraph motions

**Practice 3:**

```
// Comment block
// continues here

code_line_1();
code_line_2();

// Another comment
```

Jump from first comment to "code_line_1"

**Solution Hints:** `}` jumps to next blank line; `2}` jumps 2 paragraphs; `{` goes backward

**Common Mistakes:** Not realizing paragraph = text separated by blank lines

---

### Challenge 17: Matching Bracket

**Description:** `%` jumps to matching bracket: `()`, `[]`, `{}`. Works in both directions.

**Practice 1:**

```
function complex() {
    if (condition) {
        while (true) {
            return value;
        }
    }
}
```

From the first '{', jump to its matching '}' in one keystroke

**Practice 2:**

```
array[index][nested[deep]]
```

Navigate between all bracket pairs

**Practice 3:**

```
if ((a && b) || (c && d))
```

From opening '(' of condition, jump to closing ')'

**Solution Hints:** `%` finds and jumps to matching bracket; works from either side

**Common Mistakes:** Cursor must be ON a bracket character; doesn't work with quotes

---

### Challenge 18: Start/End of Line

**Description:** `0` goes to column 0, `^` to first non-blank, `$` to end. `g_` goes to last non-blank.

**Practice 1:**

```
    const variable = "value"; // comment here
```

From middle of line, jump to first non-whitespace character, then to absolute end

**Practice 2:**

```
        deeply indented code here
```

Jump to "deeply" (first non-space), then to start of line (column 0)

**Practice 3:**

```
text with trailing spaces
```

Jump to last non-whitespace character

**Solution Hints:** `^` for first non-blank; `0` for column 0; `$` for end; `g_` for last non-blank

**Common Mistakes:** Confusing `0` and `^`; not knowing `g_` for trailing whitespace

---

## Level 7: Visual Mode Mastery

### Challenge 19: Visual Block Edit

**Description:** `Ctrl-v` enters visual block mode for column editing. Combined with `I` or `A`, edit multiple lines at once.

**Practice 1:**

```
const firstName = "John";
const lastName = "Doe";
const userAge = 25;
const userCity = "NYC";
```

Add "let " prefix to all lines using visual block

**Practice 2:**

```
item1
item2
item3
item4
```

Add "- " prefix to create a bullet list

**Practice 3:**

```
name,age,city
john,25,nyc
jane,30,la
```

Add quotes around each value in the first column

**Solution Hints:** `Ctrl-v` + select + `I` + type + `Esc`; changes apply to all selected lines

**Common Mistakes:** Forgetting to press `Esc` to apply; not extending selection to all target lines

---

### Challenge 20: Visual Line Delete

**Description:** `V` enters visual line mode, selecting entire lines. Combine with motions to select multiple lines.

**Practice 1:**

```
// Start comment block
// This is line 1
// This is line 2
// This is line 3
// End comment block
```

Delete lines 1-3 (middle three lines) using visual line mode

**Practice 2:**

```
keep this
delete this
delete this too
keep this also
```

Delete only the middle two lines

**Practice 3:**

```
function one() {}
function two() {}
function three() {}
function four() {}
```

Delete functions two and three

**Solution Hints:** `V` then `j` to extend; `Vjjd` deletes 3 lines; can also use `3dd`

**Common Mistakes:** Not using `V` for whole lines; forgetting `d` after selection

---

### Challenge 21: Visual Select & Replace

**Description:** Visual selection + `:s` command allows precise substitution within selection.

**Practice 1:**

```
oldName oldName oldName
```

Visually select the first "oldName" and replace all occurrences in line with "newName"

**Practice 2:**

```
foo bar foo baz foo
```

Replace only the first two "foo" with "qux" using visual selection

**Practice 3:**

```
test_data test_info test_value
```

Replace "test" with "my" in all occurrences

**Solution Hints:** Visual select then `:s/old/new/g`; `gv` reselects last selection

**Common Mistakes:** Not using `g` flag for all occurrences; forgetting the range is the visual selection

---

## Level 8: Combination Moves

### Challenge 22: Complex Delete

**Description:** Chain motions with operators for precise deletions. Think: "delete from here to there."

**Practice 1:**

```
function calculatePrice(basePrice, taxRate, discountPercent, shippingCost)
```

Delete ", discountPercent, shippingCost" starting from the comma before "discountPercent"

**Practice 2:**

```
const result = getValue() + getOther() + getMore();
```

Delete "+ getOther() + getMore()"

**Practice 3:**

```
array.filter().map().reduce().forEach()
```

Delete ".map().reduce()" from the chain

**Solution Hints:** `d2f)` deletes through second ')'; `dt.` deletes till '.'; combine `f` and `d` creatively

**Common Mistakes:** Not combining find with delete; using multiple commands when one suffices

---

### Challenge 23: Change Surround

**Description:** With vim-surround plugin: `cs'"` changes single to double quotes. `ds"` deletes quotes. `ysiw"` adds quotes.

**Practice 1:**

```
const message = 'single quotes here';
```

Change single quotes to double quotes

**Practice 2:**

```
const value = "remove these quotes";
```

Remove the surrounding quotes

**Practice 3:**

```
const word = unquoted;
```

Add double quotes around "unquoted"

**Solution Hints:** `cs'"` changes surrounding; `ds'` deletes surrounding; `ysiw"` surrounds word with quotes

**Common Mistakes:** Not having vim-surround installed; wrong order of quote arguments

**Note:** Requires vim-surround or similar plugin. Without plugin: `f'r"f'r"` works but is slower

---

### Challenge 24: Delete Until Pattern

**Description:** `d/pattern` deletes from cursor to (but not including) the search match. Powerful for precise deletions.

**Practice 1:**

```
Remove this text but keep what follows -> KEEP THIS
```

Delete everything from 'R' up to (not including) "KEEP"

**Practice 2:**

```
prefix_stuff_to_remove::actual_content
```

Delete everything up to "::"

**Practice 3:**

```
old code // MARKER new code after marker
```

Delete from "old" up to "MARKER"

**Solution Hints:** `d/KEEP<CR>` deletes to search match; `d/pattern` is operator-pending search

**Common Mistakes:** Forgetting this works in operator-pending mode; search is exclusive by default

---

## Level 9: Mark & Jump

### Challenge 25: Using Marks

**Description:** `m{a-z}` sets a local mark, `'{a-z}` jumps to it. `m{A-Z}` sets global marks across files.

**Practice 1:**

```
Line 1: First important location
Line 2: Some text
Line 3: Some text
Line 4: Some text
Line 5: Second important location
```

Mark line 1, jump to line 5, then return to line 1 using marks

**Practice 2:**

```
function start() {
    // ... many lines ...
}

function end() {
    // need to jump back to start
}
```

Set marks at both functions and jump between them

**Practice 3:**

```
const config = {
    // mark this
    important: true,
    // ... lots of config ...
    other: false,
};
```

Mark "important" line, navigate away, return to exact position

**Solution Hints:** `ma` sets mark 'a'; `'a` jumps to line; `` `a `` jumps to exact position; `''` jumps to previous position

**Common Mistakes:** Confusing `'a` (line) with `` `a `` (exact position); forgetting marks

---

### Challenge 26: Jump List

**Description:** `Ctrl-o` jumps back through history, `Ctrl-i` jumps forward. Vim remembers where you've been.

**Practice 1:**
Navigate to 3 different locations, then jump back through your history

**Practice 2:**
Search for a word, jump to match, then return to original position

**Practice 3:**
Open a file, navigate to several functions, return to where you started

**Solution Hints:** `Ctrl-o` goes back; `Ctrl-i` goes forward; `:jumps` shows jump list

**Common Mistakes:** Not knowing the jump list exists; using marks when jump list suffices

---

## Level 10: Search & Replace

### Challenge 27: Substitute in Line

**Description:** `:s/old/new/` substitutes first occurrence on current line. Add `g` for all on line.

**Practice 1:**

```
The cat sat on the mat with another cat nearby
```

Replace only the first "cat" with "dog" on this line

**Practice 2:**

```
one two one three one four
```

Replace only the first "one" with "1"

**Practice 3:**

```
error error success error
```

Replace the second "error" only

**Solution Hints:** `:s/cat/dog/` replaces first; position cursor, then `cgn` for next matches

**Common Mistakes:** Adding `g` when only wanting first occurrence

---

### Challenge 28: Substitute All in Line

**Description:** The `g` flag makes substitution global (all occurrences). Without it, only first match is replaced.

**Practice 1:**

```
foo bar foo baz foo qux foo
```

Replace all "foo" with "bar" on this line only

**Practice 2:**

```
test_test_test_done
```

Replace all underscores with hyphens

**Practice 3:**

```
a,b,c,d,e
```

Replace all commas with semicolons

**Solution Hints:** `:s/foo/bar/g` for all on line; `:%s/foo/bar/g` for all in file

**Common Mistakes:** Forgetting `g` and wondering why only one replaced

---

### Challenge 29: Substitute with Confirmation

**Description:** The `c` flag prompts for confirmation on each match. Answer: `y`es, `n`o, `a`ll, `q`uit, `l`ast.

**Practice 1:**

```
test test test important_test test
```

Replace "test" with "exam" but skip "important_test"

**Practice 2:**

```
old old old keep_old old
```

Interactively replace "old" with "new", skipping where needed

**Practice 3:**

```
debug debug production debug
```

Replace some "debug" with "info" using confirmation

**Solution Hints:** `:s/test/exam/gc` prompts for each; `y` to replace, `n` to skip

**Common Mistakes:** Not knowing confirmation options; accidentally pressing `a` (replaces all remaining)

---

## Level 11: Advanced Manipulation

### Challenge 30: Transpose Characters

**Description:** `xp` is a quick idiom: delete character, put after cursor. Effectively swaps two characters.

**Practice 1:**

```
teh quick brown fox
```

Fix "teh" to "the" using transpose

**Practice 2:**

```
recieve the package
```

Fix "recieve" to "receive"

**Practice 3:**

```
tset the value
```

Fix "tset" to "test"

**Solution Hints:** `xp` transposes; cursor on first char to swap; `Xp` if cursor on second char

**Common Mistakes:** Cursor position matters; `xp` swaps cursor char with next

---

### Challenge 31: Duplicate Line

**Description:** `yy` yanks current line, `p` puts below, `P` puts above. `yyp` is the duplicate idiom.

**Practice 1:**

```
const importantLine = "duplicate me";
```

Duplicate this line below itself

**Practice 2:**

```
border: 1px solid black;
```

Duplicate and modify for different properties

**Practice 3:**

```
function template() {}
```

Create 3 copies of this line

**Solution Hints:** `yyp` duplicates below; `yyP` duplicates above; `3yyp` copies 3 lines

**Common Mistakes:** Using `yy` then navigating before `p`; register gets overwritten

---

### Challenge 32: Move Line

**Description:** `:m` command moves lines. `:m+1` moves down, `:m-2` moves up. Or use `ddp`/`ddkP`.

**Practice 1:**

```
Line 3 (should be third)
Line 1 (should be first)
Line 2 (should be second)
```

Reorder these lines correctly

**Practice 2:**

```
C
A
B
```

Move C to the end

**Practice 3:**

```
last
first
middle
```

Reorder to: first, middle, last

**Solution Hints:** `ddp` moves line down; `ddkP` moves up; `:m+1` and `:m-2` are precise

**Common Mistakes:** Confusing direction with `:m`; count is relative to current line

---

## Level 12: Macro Challenges

### Challenge 33: Simple Macro

**Description:** `q{a-z}` starts recording, `q` stops, `@{a-z}` plays. `@@` repeats last macro.

**Practice 1:**

```
apple
banana
cherry
date
```

Record a macro to wrap each word in quotes: "apple", "banana", etc.

**Practice 2:**

```
item1
item2
item3
```

Add "- [ ] " prefix to create a task list

**Practice 3:**

```
one
two
three
```

Add semicolons to end of each line

**Solution Hints:** `qa` start recording into 'a'; `I"<Esc>A"<Esc>j` wraps and moves; `q` stops; `3@a` repeats

**Common Mistakes:** Forgetting to end recording; macro not ending on correct position for repeat

---

### Challenge 34: Complex Macro

**Description:** Macros can include searches, mode changes, and complex edits. Plan the sequence carefully.

**Practice 1:**

```
firstName:John
lastName:Doe
age:25
```

Record a macro to transform each line to: const firstName = "John";

**Practice 2:**

```
- apple
- banana
- cherry
```

Transform to: { name: "apple" },

**Practice 3:**

```
width=100
height=200
depth=50
```

Transform to: const width = 100;

**Solution Hints:** Plan each keystroke; `0` to start of line; `f:` to find; `s` to substitute; end with `j`

**Common Mistakes:** Not starting at consistent position; using line-specific motions that fail on other lines

---

## Level 13: Indentation & Formatting

### Challenge 35: Indent Block

**Description:** `>>` indents current line, `>}` indents paragraph, visual select + `>` indents selection.

**Practice 1:**

```
function test() {
console.log("not indented");
console.log("also not indented");
}
```

Properly indent the two console.log lines

**Practice 2:**

```
if (true) {
doSomething();
doMore();
finish();
}
```

Indent all three lines inside the if block

**Practice 3:**

```
<div>
<p>Not indented</p>
<span>Also not</span>
</div>
```

Indent the inner elements

**Solution Hints:** `Vj>` selects and indents; `>j` indents 2 lines; `=` auto-indents

**Common Mistakes:** Using `>>` repeatedly; not knowing `=` for auto-indent

---

### Challenge 36: Outdent Block

**Description:** `<<` outdents, `<` in visual mode outdents selection. Use with counts or motions.

**Practice 1:**

```
    if (true) {
        console.log("normal");
            console.log("too indented");
            console.log("too indented");
    }
```

Fix the over-indented lines

**Practice 2:**

```
        too much indent
        on these lines
        fix them
```

Remove one level of indentation from all lines

**Practice 3:**

```
    outer
        inner (correct)
            too deep
    outer
```

Fix "too deep" to match "inner"

**Solution Hints:** `<<` outdents line; `Vj<` outdents visual selection; count works: `2<<`

**Common Mistakes:** Not selecting all lines to outdent; using wrong count

---

## Level 14: Advanced Text Objects

### Challenge 37: Delete Function Argument

**Description:** Arguments are comma-separated. Use `f,` and `dt,` or `df,` combinations. Plugins add `ia`/`aa` objects.

**Practice 1:**

```
function example(arg1, arg2, arg3, arg4)
```

Delete only "arg2, " from the parameters

**Practice 2:**

```
calculate(price, tax, discount, shipping)
```

Delete the "tax, " argument

**Practice 3:**

```
method(first, second, third)
```

Delete "second" and its surrounding comma

**Solution Hints:** `f,ldt,` or `f,ldf,`; with treesitter-textobjects: `daa` deletes argument

**Common Mistakes:** Leaving trailing/leading comma; not handling edge cases (first/last arg)

---

### Challenge 38: Change Inside Parentheses

**Description:** Nested parentheses: `ci(` works with innermost. Use `%` to navigate to outer first.

**Practice 1:**

```
if ((condition1 && condition2) || condition3)
```

Change the content inside the outer parentheses

**Practice 2:**

```
outer(middle(inner(value)))
```

Change only "value" inside the innermost parentheses

**Practice 3:**

```
func(a, func2(b, c), d)
```

Change "b, c" inside the nested call

**Solution Hints:** For outer: position at outer `(` then `ci(`; `%` helps navigate

**Common Mistakes:** `ci(` targets innermost from cursor position; may need to navigate first

---

## Level 15: Window & Buffer Navigation

### Challenge 39: Quick Fix

**Description:** `:cnext`, `:cprev` navigate quickfix list. `:copen` shows the list. Used with linters, grep, etc.

**Practice 1:**

```
// Multiple syntax errors in file
const x =
const y =
const z =
```

After running a linter, navigate between errors using quickfix

**Practice 2:**
Use `:vimgrep /TODO/g %` then navigate results

**Practice 3:**
Compile code with errors, navigate to each error location

**Solution Hints:** `:cn` next error; `:cp` previous; `:copen` shows list; `:ccl` closes list

**Common Mistakes:** Not knowing quickfix exists; using manual search instead

---

### Challenge 40: Last Position

**Description:** `` `. `` jumps to last change position. `''` or ` `` ` jumps to previous position.

**Practice 1:**
Make an edit, move to another location, then return to your last edit location

**Practice 2:**
Edit in three places, jump back through edit history

**Practice 3:**
Use search to jump away, return to where you were before search

**Solution Hints:** `` `. `` exact position of last change; `gi` goes to last insert position and enters insert mode

**Common Mistakes:** Not knowing `` `. `` mark exists; confusing with `''`

---

## Level 16: Case Manipulation

### Challenge 41: Toggle Case

**Description:** `~` toggles case of character. `g~{motion}` toggles case over motion. `g~~` toggles entire line.

**Practice 1:**

```
tHiS iS wEiRd CaSiNg
```

Toggle the case of all characters in this line

**Practice 2:**

```
MAKE lowercase
```

Toggle "MAKE" to "make"

**Practice 3:**

```
toggle THIS word only
```

Toggle only "THIS" to "this"

**Solution Hints:** `g~~` toggles line; `g~w` toggles word; `~` toggles single char and advances

**Common Mistakes:** Not knowing `g~` motion form; using `~` char by char

---

### Challenge 42: Uppercase Word

**Description:** `gU{motion}` uppercases. `gUw` uppercases word, `gUU` uppercases line.

**Practice 1:**

```
make this word UPPERCASE
```

From 'w' in "word", make "word" all uppercase

**Practice 2:**

```
const max_value = 100;
```

Make "max_value" uppercase for constant

**Practice 3:**

```
convert entire line to uppercase
```

Uppercase the entire line

**Solution Hints:** `gUw` or `gUiw` uppercases word; `gUU` or `gU$` for line

**Common Mistakes:** Confusing `gU` with `gu` (lowercase); forgetting the motion

---

### Challenge 43: Lowercase Selection

**Description:** `gu{motion}` lowercases. Visual select + `u` also lowercases.

**Practice 1:**

```
MAKE THIS SENTENCE lowercase
```

Make "THIS SENTENCE" lowercase while keeping first word

**Practice 2:**

```
VARIABLE_NAME = value
```

Lowercase only "VARIABLE_NAME"

**Practice 3:**

```
Some WORDS Are UPPERCASE
```

Lowercase only the uppercase words

**Solution Hints:** `gu{motion}` lowercases; visual select then `u`; `guw` for word

**Common Mistakes:** Affecting more than intended; not using precise motion

---

## Level 17: Number Operations

### Challenge 44: Increment Number

**Description:** `Ctrl-a` increments number under/after cursor. Works with counts: `5Ctrl-a` adds 5.

**Practice 1:**

```
const version = 1;
```

Increment the number from 1 to 2

**Practice 2:**

```
let count = 10;
```

Increment by 5 (to 15)

**Practice 3:**

```
index0, index1, index2
```

Increment index0 to index1

**Solution Hints:** `Ctrl-a` increments; `5Ctrl-a` adds 5; cursor finds next number on line

**Common Mistakes:** Cursor doesn't need to be ON number; it finds next number

---

### Challenge 45: Decrement Number

**Description:** `Ctrl-x` decrements. Same rules as increment.

**Practice 1:**

```
let countdown = 10;
```

Decrement 10 to 9

**Practice 2:**

```
step5
```

Decrement to step4

**Practice 3:**

```
version = 100
```

Decrement by 10 (to 90)

**Solution Hints:** `Ctrl-x` decrements; `10Ctrl-x` subtracts 10

**Common Mistakes:** Same as increment; forgetting count multiplier

---

### Challenge 46: Visual Block Number Operations

**Description:** In visual block mode, `g Ctrl-a` creates incrementing sequence.

**Practice 1:**

```
item0
item0
item0
```

Change each '0' to '1', '2', '3' respectively

**Practice 2:**

```
version1
version1
version1
```

Make incrementing sequence: version1, version2, version3

**Practice 3:**

```
0. First
0. Second
0. Third
```

Create numbered list: 1. First, 2. Second, 3. Third

**Solution Hints:** Visual block select numbers, `g Ctrl-a` makes sequence; regular `Ctrl-a` increments all same

**Common Mistakes:** Not using `g` prefix for sequence; selecting wrong column

---

## Level 18: Advanced Search Patterns

### Challenge 47: Search Whole Word

**Description:** `\<` and `\>` are word boundaries. `/\<test\>` matches "test" but not "testing".

**Practice 1:**

```
test testing tested testify
```

Search for "test" but only match the standalone word

**Practice 2:**

```
in inner inn inn-keeper
```

Find only "in" not "inner" or "inn"

**Practice 3:**

```
cat catalog catch caterpillar
```

Find only the word "cat"

**Solution Hints:** `/\<test\>` for word boundaries; `*` does this automatically

**Common Mistakes:** Forgetting word boundary syntax; `*` already does whole word search

---

### Challenge 48: Case-Insensitive Search

**Description:** `\c` anywhere in pattern makes it case-insensitive. `\C` forces case-sensitive.

**Practice 1:**

```
Apple apple APPLE aPpLe
```

Search for all variations of "apple" regardless of case

**Practice 2:**

```
Error ERROR error
```

Find all case variations of "Error"

**Practice 3:**

```
TODO Todo todo
```

Match all "TODO" variations

**Solution Hints:** `/apple\c` or `/\capple` for case-insensitive; `:set ignorecase` as default

**Common Mistakes:** Not knowing `\c` flag; relying on settings that may vary

---

## Level 19: Clipboard Operations

### Challenge 49: Yank and Put

**Description:** `y{motion}` yanks (copies), `p` puts after cursor, `P` puts before. Line-wise yanks put on new lines.

**Practice 1:**

```
First line to copy
Second line placeholder
```

Copy "First line to copy" and replace "Second line placeholder" with it

**Practice 2:**

```
const source = "copy me";
const target = "replace me";
```

Copy "copy me" and replace "replace me"

**Practice 3:**

```
word
```

Duplicate this word on the same line: "word word"

**Solution Hints:** `yy` yanks line; `p` puts after; `Vp` replaces visual selection with register

**Common Mistakes:** `p` after line yank puts below, not after cursor on same line

---

### Challenge 50: Yank Inner Word

**Description:** `yiw` yanks word without surrounding space. `yaw` includes one space.

**Practice 1:**

```
The wonderful word is here
```

From inside "wonderful", yank just that word (no spaces)

**Practice 2:**

```
extract_this_part from the line
```

Yank only "extract_this_part"

**Practice 3:**

```
const value = important;
```

Yank only "important" without the semicolon

**Solution Hints:** `yiw` yanks inner word; cursor can be anywhere in word; `yi"` yanks inner quotes

**Common Mistakes:** Using `yw` which includes trailing space; wrong cursor position

---

### Challenge 51: Delete to Black Hole

**Description:** `"_d{motion}` deletes without affecting registers. Useful to preserve clipboard.

**Practice 1:**

```
temporary text to delete
important text to keep
```

Delete first line without affecting your default register

**Practice 2:**
Yank something important, then delete other text without losing yank

**Practice 3:**

```
overwrite_this
save_this
```

Yank "save_this", then delete "overwrite_this" without losing clipboard, then put

**Solution Hints:** `"_dd` deletes to black hole register; `"_d{motion}` for any deletion

**Common Mistakes:** Forgetting `"_` prefix; registers get overwritten by default

---

## Level 20: Text Composition

### Challenge 52: Repeat Command

**Description:** `.` repeats the last change. Plan edits to be repeatable for maximum efficiency.

**Practice 1:**

```
apple apple apple apple
```

Delete the first "apple ", then repeat the deletion for remaining

**Practice 2:**

```
old old old old
```

Change first "old" to "new", repeat for all

**Practice 3:**

```
word1 word2 word3 word4
```

Delete each word one by one using repeat

**Solution Hints:** `dw` then `.` repeats; `cw` + new text + `Esc` then `.` replaces repeatedly

**Common Mistakes:** Making changes that don't repeat well; extra keystrokes that break repetition

---

### Challenge 53: Dot Command Chain

**Description:** Combine search with dot command: search, make change, `n.` to repeat search and change.

**Practice 1:**

```
function foo() {}
function bar() {}
function baz() {}
```

Add "async " before each "function" using efficient edit + dot command

**Practice 2:**

```
var x = 1;
var y = 2;
var z = 3;
```

Change all "var" to "const"

**Practice 3:**

```
console.log(a);
console.log(b);
console.log(c);
```

Change "log" to "error" in all lines

**Solution Hints:** `/function<CR>ciw<Ctrl-r>=<Esc>n.`; or `*cwasync <Esc>n.`

**Common Mistakes:** Not using `n.` pattern; over-complicating with substitution

---

## Level 21: Complex Selections

### Challenge 54: Expand Region

**Description:** With plugins like vim-expand-region, progressively select larger regions. Without, use text objects.

**Practice 1:**

```
const obj = { key: { nested: { deep: "value" } } };
```

Progressively select: "value" → { deep: "value" } → { nested: ... } → entire object

**Practice 2:**

```
function outer() { function inner() { return true; } }
```

Select inner function, then outer function

**Practice 3:**

```
<div><span><b>text</b></span></div>
```

Select text, then b tag, then span, then div

**Solution Hints:** `vi"` then `a"` extends; or `vi{` repeatedly selects larger braces

**Common Mistakes:** Not building up incrementally; trying to select everything at once

---

### Challenge 55: Select Until

**Description:** `v/pattern` visually selects to search match. Combine with operators.

**Practice 1:**

```
Delete everything from here until the END marker -> this goes -> END keep this
```

Delete from "Delete" up to "END"

**Practice 2:**

```
remove_prefix KEEP_THIS rest
```

Select and delete "remove_prefix "

**Practice 3:**

```
old code /* MARKER */ new code
```

Select from start to MARKER

**Solution Hints:** `v/END<CR>d` selects to END and deletes; or `d/END<CR>`

**Common Mistakes:** Search is exclusive; may need to adjust selection

---

## Level 22: Multi-line Operations

### Challenge 56: Comment Toggle

**Description:** Without plugins: visual block `I//` adds comments. With plugins: `gc` toggles.

**Practice 1:**

```
const x = 1;
const y = 2;
const z = 3;
```

Comment out all three lines with //

**Practice 2:**

```
// const a = 1;
// const b = 2;
```

Uncomment these lines

**Practice 3:**

```
line1();
// line2();
line3();
```

Toggle comments on all lines

**Solution Hints:** `Ctrl-v` select column, `I// <Esc>`; plugins: `gc3j` or `gcc` per line

**Common Mistakes:** Not using visual block; forgetting space after //

---

### Challenge 57: Align Assignments

**Description:** Use visual block or plugins like vim-easy-align. Manual: add spaces strategically.

**Practice 1:**

```
const x=1;
const name="value";
const isActive=true;
```

Add spaces around = signs

**Practice 2:**

```
a = 1
ab = 2
abc = 3
```

Align the = signs vertically

**Practice 3:**

```
short = 1;
mediumLength = 2;
veryLongVariable = 3;
```

Align all = at same column

**Solution Hints:** Visual block + `I` to add spaces; `:EasyAlign =` with plugin

**Common Mistakes:** Manual alignment is tedious; consider using plugin for real work

---

## Level 23: Pattern-Based Editing

### Challenge 58: Delete Empty Lines

**Description:** `:g/^$/d` deletes all empty lines. `:v/./d` is alternative (delete lines not matching any character).

**Practice 1:**

```
Line 1

Line 2


Line 3
```

Remove all empty lines

**Practice 2:**

```
code()

more_code()


// comment

end()
```

Remove all blank lines

**Practice 3:**

```
text


many


blank


lines
```

Collapse to no empty lines

**Solution Hints:** `:g/^$/d` global command; `:g/^\s*$/d` includes whitespace-only lines

**Common Mistakes:** Not matching whitespace-only lines; `^$` is truly empty only

---

### Challenge 59: Delete Trailing Spaces

**Description:** `:%s/\s\+$//` removes trailing whitespace from all lines.

**Practice 1:**

```
Line with spaces
Another line
Clean line
```

Remove trailing spaces from first two lines

**Practice 2:**

```
code();
more();
end();
```

Clean all trailing whitespace

**Practice 3:**

```
const x = 1;
const y = 2;
```

Remove trailing tabs

**Solution Hints:** `:%s/\s\+$//g` for all lines; `:s/\s\+$//` for current line only

**Common Mistakes:** `\s` matches tabs too; `\+` means one or more

---

## Level 24: Advanced Combinations

### Challenge 60: Change Case of Character

**Description:** `r` replaces single character. `~` toggles case. Combine for precise edits.

**Practice 1:**

```
const firstName = "john";
```

Capitalize just the 'j' in "john" to make it "John"

**Practice 2:**

```
const UserName = "test";
```

Lowercase the 'U' in UserName

**Practice 3:**

```
variable.methodname()
```

Capitalize 'm' to create "variable.Methodname()"

**Solution Hints:** Navigate to char, `~` toggles; or `gUl` to uppercase one char

**Common Mistakes:** Using `~` which toggles vs `gUl`/`gul` which set case

---

### Challenge 61: Swap Words

**Description:** `dawwP` or `dawbP` swaps words depending on direction. Requires practice.

**Practice 1:**

```
wrong right order
```

Swap "wrong" and "right" to make "right wrong order"

**Practice 2:**

```
second first third
```

Swap "second" and "first"

**Practice 3:**

```
const b = a;
```

Swap to "const a = b;"

**Solution Hints:** `dawwP` deletes word, moves, puts before; or `dawbP` for backward swap

**Common Mistakes:** Spaces get tricky; `daw` includes trailing space

---

### Challenge 62: Delete Surrounding Function

**Description:** Delete function call but keep argument. Use `dt(` and `ds)` or manual method.

**Practice 1:**

```
someFunction(keepThis)
```

Delete "someFunction(" and ")" to leave just "keepThis"

**Practice 2:**

```
wrapper(inner(value))
```

Remove wrapper, keep inner(value)

**Practice 3:**

```
String(42)
```

Remove String() call, keep 42

**Solution Hints:** `dsf` with vim-surround for functions; or `dt(ds)` manually

**Common Mistakes:** Leaving orphan parentheses; off-by-one errors

---

## Level 25: Real-World Scenarios

### Challenge 63: Fix Function Call

**Description:** Real code has errors. Practice fixing common syntax issues efficiently.

**Practice 1:**

```
calculateTotal(price, ,quantity, discount)
```

Remove the extra comma (empty parameter)

**Practice 2:**

```
const x = getValue(;
```

Add missing closing parenthesis

**Practice 3:**

```
function test() {
    return value
}
```

Add missing semicolon after value

**Solution Hints:** `f,x` to find and delete; `A;<Esc>` to append semicolon

**Common Mistakes:** Using search when `f` is faster; not using `A` for end-of-line edits

---

### Challenge 64: Extract Variable

**Description:** Select expression, cut, create variable above, paste expression as value.

**Practice 1:**

```
return user.profile.settings.theme.primaryColor;
```

Extract "user.profile.settings.theme" to a variable on the line above

**Practice 2:**

```
console.log(getValue() + getOther());
```

Extract "getValue() + getOther()" to a const

**Practice 3:**

```
if (a && b && c && d) {
```

Extract "a && b && c && d" to a const condition

**Solution Hints:** Visual select, `d`, `O` (open above), type declaration, `<Esc>p`

**Common Mistakes:** Not replacing original with variable name; forgetting to update reference

---

### Challenge 65: Rename Parameter

**Description:** Use `cgn` pattern or substitution for renaming within scope.

**Practice 1:**

```
function process(data) {
    console.log(data);
    return data.map(x => x);
}
```

Rename all instances of "data" to "items"

**Practice 2:**

```
const x = 1;
const y = x + x;
return x;
```

Rename "x" to "value"

**Practice 3:**

```
for (let i = 0; i < len; i++) {
    array[i] = i * 2;
}
```

Rename "i" to "index"

**Solution Hints:** Visual select function, `:s/data/items/g`; or `*cgnitem<Esc>n.n.`

**Common Mistakes:** Replacing outside intended scope; not checking all occurrences

---

## Level 26: Speed Challenges

### Challenge 66: Quick Delete Word

**Description:** Minimize keystrokes. `daw` vs `dw` vs `diw` - choose appropriately.

**Practice 1:**

```
Remove unnecessary redundant extra superfluous words here
```

Delete "unnecessary redundant extra superfluous " as fast as possible

**Practice 2:**

```
delete just this word only
```

Delete "just" quickly

**Practice 3:**

```
the the repeated word
```

Delete duplicate "the "

**Solution Hints:** `4daw` if positioned right; `dw...` with repetition; search + `dgn`

**Common Mistakes:** Over-thinking; sometimes multiple `dw` is faster than planning

---

### Challenge 67: Fast Line Navigation

**Description:** Combine line jumps efficiently. Use relative numbers when enabled.

**Practice 1:**

```
[Line 1]
[Line 2]
[Line 3]
[Line 4]
[Line 5]
[Line 6]
[Line 7]
[Line 8]
[Line 9]
[Line 10]
```

From line 1, jump to line 10, then to line 5, then to line 8

**Practice 2:**
Navigate to line 50, then 25, then 75, then back to start

**Practice 3:**
Jump to end of file, then to middle, then to start

**Solution Hints:** `10G` or `10gg`; `5G`; `8G`; use `:set relativenumber` for relative jumps

**Common Mistakes:** Using `j` repeatedly; not using line number jumps

---

## Level 27: Code Refactoring

### Challenge 68: Extract String

**Description:** Identify strings to extract, create constant, replace original with constant.

**Practice 1:**

```
console.log("Error: Invalid input provided");
```

Extract the string to a const ERROR_MESSAGE above this line

**Practice 2:**

```
throw new Error("Something went wrong");
```

Extract error message to a constant

**Practice 3:**

```
const url = "https://api.example.com/v1";
```

Already a const, but rename variable to API_URL (uppercase)

**Solution Hints:** `yi"` yank string, `O` open above, type const, `p` paste, go back and replace

**Common Mistakes:** Forgetting to replace original; wrong capitalization for constants

---

### Challenge 69: Inline Variable

**Description:** Replace variable usage with its value, then delete declaration.

**Practice 1:**

```
const temp = getValue();
return temp;
```

Replace "temp" in return with "getValue()" and delete the temp line

**Practice 2:**

```
const result = a + b;
console.log(result);
```

Inline "result" into console.log

**Practice 3:**

```
const x = 5;
const y = x * 2;
```

Inline "x" into the y calculation

**Solution Hints:** Yank value, find usage, replace with paste, delete original line

**Common Mistakes:** Multiple usages need multiple replacements; delete declaration last

---

### Challenge 70: Wrap in Condition

**Description:** Add if statement around existing code. Manage indentation.

**Practice 1:**

```
executeAction();
```

Wrap in: if (condition) { executeAction(); }

**Practice 2:**

```
processData();
saveResult();
```

Wrap both lines in if block

**Practice 3:**

```
return value;
```

Wrap in: if (value) { return value; }

**Solution Hints:** `O` above, type if, `Jo` below for closing brace, `>>` indent middle

**Common Mistakes:** Forgetting to indent wrapped code; unbalanced braces

---

## Level 28: Advanced Deletion

### Challenge 71: Delete Inside Nested

**Description:** Navigate to correct nesting level before using text objects.

**Practice 1:**

```
outer(inner(deep(value)))
```

Delete just "value" inside the deepest parentheses

**Practice 2:**

```
[[nested[array]]]
```

Delete "array" from innermost brackets

**Practice 3:**

```
func(a, func2(b, c), d)
```

Delete "b, c" inside nested function call

**Solution Hints:** Navigate inside target parens first, then `di(`; `%` helps navigate

**Common Mistakes:** `di(` works on innermost from cursor; must position correctly

---

### Challenge 72: Delete Around Nested

**Description:** Include delimiters in deletion with `da`. Be precise about which level.

**Practice 1:**

```
const result = [[[1, 2, 3]]];
```

Delete the innermost array "[1, 2, 3]"

**Practice 2:**

```
obj = {outer: {inner: {deep: true}}}
```

Delete "{deep: true}" entirely

**Practice 3:**

```
(a + (b * (c - d)))
```

Delete "(c - d)" including parentheses

**Solution Hints:** Navigate inside target, `da[` or `da{`; position is key

**Common Mistakes:** Deleting wrong nesting level; not accounting for surrounding syntax

---

## Level 29: Line Text Objects

### Challenge 73: Change to End

**Description:** `C` changes to end of line (same as `c$`). Quick for end-of-line edits.

**Practice 1:**

```
const value = oldValue; // this comment stays
```

Change "oldValue" to "newValue" without affecting the comment

**Practice 2:**

```
let x = wrong_value;
```

Change "wrong_value" to "correct_value"

**Practice 3:**

```
const result = computeOld();
```

Change "computeOld()" to "computeNew()"

**Solution Hints:** Navigate to start of target, `ct;` changes till semicolon; or `ciw` for just word

**Common Mistakes:** Using `C` when you want to preserve part of line; `ct` is more precise

---

### Challenge 74: Delete from Start

**Description:** `d0` deletes to start of line, `d^` deletes to first non-blank.

**Practice 1:**

```
    remove this prefix: keep this part
```

Delete from first non-whitespace up to and including ": "

**Practice 2:**

```
unwanted_prefix_text: wanted content
```

Delete up through ":"

**Practice 3:**

```
TODO: DONE: actual content
```

Delete "TODO: DONE: "

**Solution Hints:** `^dt:x` or `^d2f:` depending on exact need; `d^` keeps leading whitespace

**Common Mistakes:** `d0` removes indentation; `d^` preserves leading whitespace

---

## Level 30: Special Characters

### Challenge 75: Navigate Camel Case

**Description:** Default Vim treats camelCase as one word. Plugins like CamelCaseMotion help.

**Practice 1:**

```
thisIsACamelCaseVariable
```

Move cursor to each capital letter

**Practice 2:**

```
getUserProfileSettings
```

Navigate to "Profile" then "Settings"

**Practice 3:**

```
XMLHttpRequest
```

Navigate between XML, Http, Request

**Solution Hints:** Without plugin: `f` to find capitals; with CamelCaseMotion: `,w` moves to next segment

**Common Mistakes:** Standard `w` jumps entire word; need plugin or `f` for camelCase

---

### Challenge 76: Navigate Snake Case

**Description:** Snake_case: `w` stops at underscores. Vim's default behavior works here.

**Practice 1:**

```
this_is_a_snake_case_variable
```

Move to each underscore-separated word

**Practice 2:**

```
user_profile_settings
```

Navigate through each segment

**Practice 3:**

```
get_user_by_id
```

Jump to "user", then "by", then "id"

**Solution Hints:** `w` works! Underscore is word boundary; `e` for end of segment

**Common Mistakes:** Over-complicating; default `w` handles snake_case well

---

### Challenge 77: Handle Special Characters

**Description:** Paths and URIs have special characters. Use `f` and `t` to navigate.

**Practice 1:**

```
const path = "/usr/local/bin:/usr/bin:/bin";
```

Delete just "/usr/local/bin:" leaving "/usr/bin:/bin"

**Practice 2:**

```
const url = "https://example.com/path/to/resource";
```

Delete "/path/to/resource"

**Practice 3:**

```
const regex = /^[a-z]+$/;
```

Change the regex pattern

**Solution Hints:** `f/dt:` combinations; `ci"` for entire string; `f/` multiple times

**Common Mistakes:** Special chars aren't word boundaries; need explicit `f`/`t`

---

## Level 31: Formatting Challenges

### Challenge 78: Add Trailing Comma

**Description:** Modern JS/JSON often uses trailing commas. Navigate to end and add.

**Practice 1:**

```
const obj = {
    key1: "value1",
    key2: "value2"
}
```

Add comma after "value2"

**Practice 2:**

```
const arr = [
    1,
    2,
    3
];
```

Add trailing comma after 3

**Practice 3:**

```
function(
    param1,
    param2
) {}
```

Add trailing comma after param2

**Solution Hints:** Navigate to line, `A,<Esc>`; or `$a,<Esc>`

**Common Mistakes:** Adding comma after wrong element; not handling existing punctuation

---

### Challenge 79: Remove Trailing Comma

**Description:** Some contexts don't allow trailing commas. Find and remove.

**Practice 1:**

```
const arr = [
    "item1",
    "item2",
];
```

Remove the trailing comma after "item2"

**Practice 2:**

```
{
    "key": "value",
}
```

Remove trailing comma (invalid JSON)

**Practice 3:**

```
enum { A, B, C, };
```

Remove trailing comma before };

**Solution Hints:** `/,\n/` or `f,x`; `$x` if comma is last char

**Common Mistakes:** Removing wrong comma; not checking context

---

## Level 32: Context Switching

### Challenge 80: Edit Multiple Functions

**Description:** Same change in multiple places. Use macros, substitution, or `cgn`.

**Practice 1:**

```
function first() { old }
function second() { old }
function third() { old }
```

Change all "old" to "new" efficiently

**Practice 2:**

```
getValue() { return x; }
setValue() { return x; }
resetValue() { return x; }
```

Change all "return x" to "return this.x"

**Practice 3:**

```
handleClick() {}
handleSubmit() {}
handleChange() {}
```

Add "async " before each "handle"

**Solution Hints:** `:%s/old/new/g`; or `*ciwnnew<Esc>n.n.`; macro for complex edits

**Common Mistakes:** Manual repetition; not recognizing pattern for substitution

---

## Bonus: Timed Challenges

### Speed Challenge 1

**Description:** Test your basic navigation and change speed.

Start: `The cat sat`
Goal: `The dog sat`
Target: Under 3 keystrokes

**Possible Solutions:**

- `wcwdog<Esc>` (5 keystrokes)
- `fc` then `cwdog<Esc>` (if positioned at start)

---

### Speed Challenge 2

**Description:** Function renaming speed test.

Start: `function oldName() {}`
Goal: `function newName() {}`
Target: Under 6 keystrokes

**Possible Solutions:**

- `wciwnewName<Esc>` (position at function, w to oldName, change inner word)

---

### Speed Challenge 3

**Description:** Line reordering speed test.

Start:

```
a
b
c
```

Goal:

```
c
b
a
```

Target: Minimal moves

**Possible Solutions:**

- `ddp` (move a down), `j` `ddkP` (move c up)
- Or: `ddGp` then navigate

---

## Master Challenges

### Master Challenge 1: Refactor Block

**Description:** Multiple operations on a code block. Practice combining skills.

```
const x = 1;
const y = 2;
if (true) {
const z = 3;
console.log(x, y, z);
}
```

**Tasks:**

1. Properly indent the if block contents
2. Change variable names x→a, y→b, z→c throughout
3. Add semicolons if missing

**Approach:**

- `=i{` to auto-indent inside braces
- `:%s/\bx\b/a/g` etc. for renames (use word boundaries)
- Check each line for semicolons

---

### Master Challenge 2: Transform Data

**Description:** Format conversion using macros.

```
name|age|city
John|25|NYC
Jane|30|LA
```

**Goal:**

```
{ name: "John", age: 25, city: "NYC" },
{ name: "Jane", age: 30, city: "LA" },
```

**Approach:**
Record macro on first data line:

- `I{ name: "<Esc>f|s", age: <Esc>f|s, city: "<Esc>A" },<Esc>j`
- Play on remaining lines

---

### Master Challenge 3: Clean Code

**Description:** Multiple formatting fixes.

```
const  x=1  ;
let   y =  2;
var z  = 3  ;
```

**Tasks:**

1. Fix spacing around =
2. Remove extra spaces
3. Change var to const

**Approach:**

- `:%s/  */ /g` collapse multiple spaces
- `:%s/\s*=\s*/ = /g` normalize around =
- `:%s/var/const/g` replace var
- Manual fixes for edge cases

---

## Practice Tips

1. **Start with Level 1** and progress sequentially
2. **Time yourself** on each challenge
3. **Try multiple solutions** - there's often more than one efficient way
4. **Focus on accuracy first**, then speed
5. **Use `:help` command** to learn about motions you don't know
6. **Practice daily** - even 10 minutes helps
7. **Create your own challenges** based on your real work
8. **Avoid using arrow keys** or mouse during challenges
9. **Learn one new motion per day**
10. **Review and repeat** challenges you find difficult

---

## Missing Skills to Practice

Here are important Vim skills not fully covered above:

### Registers

- `"ayy` - yank to register 'a'
- `"ap` - paste from register 'a'
- `"+y` - yank to system clipboard
- `:reg` - view all registers

### Folds

- `zf{motion}` - create fold
- `zo/zc` - open/close fold
- `zR/zM` - open/close all folds

### Spell Checking

- `:set spell` - enable spell check
- `]s/[s` - next/previous misspelling
- `z=` - suggest corrections
- `zg` - add word to dictionary

### Completion

- `Ctrl-n/Ctrl-p` - word completion
- `Ctrl-x Ctrl-f` - file path completion
- `Ctrl-x Ctrl-l` - line completion

### Command Line

- `q:` - command line window
- `Ctrl-f` in command mode - edit command in buffer
- `@:` - repeat last command

### Terminal Integration

- `:terminal` - open terminal
- `Ctrl-\ Ctrl-n` - exit terminal mode
- `:!command` - run shell command

---

## Motion Reference (Cheat Sheet)

### Basic Motions

- `h,j,k,l` - left, down, up, right
- `w,b` - word forward/backward
- `e` - end of word
- `W,B,E` - WORD (whitespace-delimited)
- `0,$` - start/end of line
- `^` - first non-blank
- `g_` - last non-blank
- `gg,G` - start/end of file
- `{,}` - paragraph up/down

### Text Objects

- `iw,aw` - inner word, a word
- `iW,aW` - inner WORD, a WORD
- `i",a"` - inner quotes, a quotes (also ', `, (, [, {, <)
- `it,at` - inner tag, a tag (HTML/XML)
- `ip,ap` - inner paragraph, a paragraph
- `is,as` - inner sentence, a sentence
- `ib,ab` - inner block (parentheses)
- `iB,aB` - inner Block (braces)

### Search

- `/,?` - search forward/backward
- `*,#` - search word under cursor forward/backward
- `g*,g#` - partial word search
- `f,F` - find character forward/backward
- `t,T` - till character forward/backward
- `;,,` - repeat find/till forward/backward
- `n,N` - repeat search forward/backward

### Operations

- `d` - delete
- `c` - change
- `y` - yank (copy)
- `p,P` - put (paste) after/before
- `r` - replace character
- `R` - replace mode
- `x,X` - delete character forward/backward
- `s` - substitute (delete char + insert)
- `~` - toggle case
- `gu,gU` - lowercase/uppercase
- `>,<` - indent/outdent
- `=` - auto-indent
- `J,gJ` - join lines with/without space

### Visual Mode

- `v` - character visual
- `V` - line visual
- `Ctrl-v` - block visual
- `gv` - reselect last visual
- `o` - jump to other end of selection

### Marks & Jumps

- `m{a-z}` - set local mark
- `'{a-z}` - jump to mark line
- `` `{a-z}`` - jump to mark position
- `''` or ` `` ` - previous position
- `` `. `` - last change position
- `Ctrl-o,Ctrl-i` - jump list back/forward

### Numbers

- `Ctrl-a` - increment
- `Ctrl-x` - decrement
- `g Ctrl-a` - incrementing sequence (visual)

---

Good luck with your challenges!
