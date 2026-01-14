*markdown.txt*  Markdown Reference

==============================================================================
CONTENTS                                                   *markdown-contents*

1. Headers ............................... |markdown-headers|
2. Emphasis .............................. |markdown-emphasis|
3. Lists ................................. |markdown-lists|
4. Links ................................. |markdown-links|
5. Images ................................ |markdown-images|
6. Code .................................. |markdown-code|
7. Blockquotes ........................... |markdown-blockquotes|
8. Horizontal Rules ...................... |markdown-hr|
9. Tables ................................ |markdown-tables|
10. Task Lists ........................... |markdown-tasks|
11. Footnotes ............................ |markdown-footnotes|
12. Strikethrough ........................ |markdown-strikethrough|
13. HTML ................................. |markdown-html|
14. Escaping ............................. |markdown-escaping|
15. GitHub-Flavored Markdown ............. |markdown-github|
16. Badges ............................... |markdown-badges|
17. Collapsible Sections ................. |markdown-collapsible|
18. Math ................................. |markdown-math|
19. Diagrams (Mermaid) ................... |markdown-mermaid|

==============================================================================
1. HEADERS                                                 *markdown-headers*

Header syntax~                                      *markdown-headers-syntax*
>
    # H1 Header
    ## H2 Header
    ### H3 Header
    #### H4 Header
    ##### H5 Header
    ###### H6 Header

    Alternative H1
    ==============

    Alternative H2
    --------------
<

==============================================================================
2. EMPHASIS                                               *markdown-emphasis*

Text emphasis~                                     *markdown-emphasis-styles*
>
    *italic* or _italic_
    **bold** or __bold__
    ***bold and italic*** or ___bold and italic___
    ~~strikethrough~~
    `inline code`
<

==============================================================================
3. LISTS                                                     *markdown-lists*

Unordered lists~                                    *markdown-lists-unordered*
>
    # Unordered list
    - Item 1
    - Item 2
      - Nested item 2.1
      - Nested item 2.2
    - Item 3

    # Alternative syntax
    * Item 1
    * Item 2
    + Item 3
<

Ordered lists~                                        *markdown-lists-ordered*
>
    # Ordered list
    1. First item
    2. Second item
       1. Nested item 2.1
       2. Nested item 2.2
    3. Third item

    # Numbers don't matter (auto-numbered)
    1. First item
    1. Second item
    1. Third item

    # Mixed
    1. First
       - Nested unordered
       - Another
    2. Second
<

==============================================================================
4. LINKS                                                     *markdown-links*

Link syntax~                                          *markdown-links-syntax*
>
    # Inline link
    [Link text](https://example.com)
    [Link with title](https://example.com "Title on hover")

    # Reference-style link
    [Link text][reference]
    [reference]: https://example.com

    # Implicit reference
    [GitHub]
    [GitHub]: https://github.com

    # Automatic link
    <https://example.com>
    <email@example.com>

    # Anchor link (internal)
    [Go to section](#headers)

    # Relative link
    [README](./README.md)
    [File](../path/to/file.md)
<

==============================================================================
5. IMAGES                                                   *markdown-images*

Image syntax~                                        *markdown-images-syntax*
>
    # Inline image
    ![Alt text](image.png)
    ![Alt text](image.png "Image title")

    # Reference-style image
    ![Alt text][logo]
    [logo]: image.png

    # Image with link
    [![Alt text](image.png)](https://example.com)

    # HTML for sizing
    <img src="image.png" width="200" height="100">
    <img src="image.png" alt="Alt text" width="50%">
<

==============================================================================
6. CODE                                                       *markdown-code*

Inline code~                                          *markdown-code-inline*
>
    Use `const` for constants.
<

Code blocks~                                           *markdown-code-blocks*
>
    # Code block with backticks
    ```
    function hello() {
      console.log("Hello");
    }
    ```

    # Code block with language
    ```javascript
    const name = "John";
    console.log(name);
    ```

    # Indented code block (4 spaces)
        function hello() {
          console.log("Hello");
        }
<

Language identifiers~                              *markdown-code-languages*
>
    javascript, js
    typescript, ts
    python, py
    java
    go
    rust
    bash, sh
    sql
    html
    css
    json
    yaml
    xml
    markdown, md
<

==============================================================================
7. BLOCKQUOTES                                         *markdown-blockquotes*

Blockquote syntax~                              *markdown-blockquotes-syntax*
>
    > This is a blockquote.

    > Multi-line blockquote.
    > Second line.

    > Nested blockquote
    >> Nested level 2
    >>> Nested level 3

    > Blockquote with **formatting**
    > and `code`
<

==============================================================================
8. HORIZONTAL RULES                                             *markdown-hr*

Horizontal rule syntax~                                   *markdown-hr-syntax*
>
    ---
    ***
    ___
<

==============================================================================
9. TABLES                                                   *markdown-tables*

Table syntax~                                        *markdown-tables-syntax*
>
    # Basic table
    | Header 1 | Header 2 | Header 3 |
    |----------|----------|----------|
    | Cell 1   | Cell 2   | Cell 3   |
    | Cell 4   | Cell 5   | Cell 6   |

    # Alignment
    | Left | Center | Right |
    |:-----|:------:|------:|
    | L1   | C1     | R1    |
    | L2   | C2     | R2    |

    # Minimal syntax (pipes at edges optional)
    Header 1 | Header 2
    ---------|----------
    Cell 1   | Cell 2
    Cell 3   | Cell 4

    # With inline formatting
    | Name | Description | Status |
    |------|-------------|--------|
    | **Item 1** | `code` | ✓ |
    | *Item 2* | [link](url) | ✗ |
<

==============================================================================
10. TASK LISTS                                              *markdown-tasks*

Task list syntax~                                    *markdown-tasks-syntax*
>
    - [x] Completed task
    - [ ] Incomplete task
    - [ ] Another incomplete task
      - [x] Nested completed
      - [ ] Nested incomplete
<

==============================================================================
11. FOOTNOTES                                            *markdown-footnotes*

Footnote syntax~                                  *markdown-footnotes-syntax*
>
    Here's a sentence with a footnote[^1].

    Another reference[^note].

    [^1]: This is the footnote content.
    [^note]: This is another footnote.
<

==============================================================================
12. STRIKETHROUGH                                    *markdown-strikethrough*

Strikethrough syntax~                        *markdown-strikethrough-syntax*
>
    ~~This text is crossed out~~
<

==============================================================================
13. HTML                                                      *markdown-html*

HTML in Markdown~                                      *markdown-html-usage*
>
    You can use HTML directly in Markdown:

    <div align="center">
      <h1>Centered Title</h1>
      <p>Centered paragraph</p>
    </div>

    <details>
    <summary>Click to expand</summary>
    Hidden content here.
    </details>

    <kbd>Ctrl</kbd>+<kbd>C</kbd>

    <br>  <!-- Line break -->
    <hr>  <!-- Horizontal rule -->

    <table>
      <tr><td>Custom</td><td>Table</td></tr>
    </table>
<

==============================================================================
14. ESCAPING                                              *markdown-escaping*

Escape characters~                                 *markdown-escaping-chars*
>
    # Escape special characters with backslash
    \* Not italic \*
    \# Not a header
    \[Not a link\](url)
    \`Not code\`
<

Characters requiring escaping~                   *markdown-escaping-special*
>
    \ backslash
    ` backtick
    * asterisk
    _ underscore
    {} curly braces
    [] square brackets
    () parentheses
    # hash
    + plus
    - minus
    . dot
    ! exclamation
<

==============================================================================
15. GITHUB-FLAVORED MARKDOWN                               *markdown-github*

Username mentions~                              *markdown-github-mentions*
>
    @username
<

Issue/PR references~                          *markdown-github-references*
>
    #123
    owner/repo#123
<

SHA references~                                      *markdown-github-sha*
>
    a5c3785ed8d6a35868bc169f07e40e889087fd2e
    owner/repo@a5c3785
<

Syntax highlighting~                            *markdown-github-syntax*
>
    ```diff
    - removed line
    + added line
    ```
<

Emoji~                                              *markdown-github-emoji*
>
    :smile: :rocket: :heart:
    :+1: :-1: :thumbsup: :thumbsdown:
<

Automatic linking~                              *markdown-github-linking*
>
    http://example.com
    https://example.com
    ftp://example.com
<

Alerts~                                            *markdown-github-alerts*
>
    > [!NOTE]
    > Highlights information.

    > [!TIP]
    > Optional information.

    > [!IMPORTANT]
    > Crucial information.

    > [!WARNING]
    > Critical content.

    > [!CAUTION]
    > Negative consequences.
<

==============================================================================
16. BADGES                                                  *markdown-badges*

Shield.io badges~                                    *markdown-badges-shields*
>
    ![Build Status](https://img.shields.io/github/workflow/status/user/repo/CI)
    ![Coverage](https://img.shields.io/codecov/c/github/user/repo)
    ![Version](https://img.shields.io/npm/v/package-name)
    ![License](https://img.shields.io/github/license/user/repo)
    ![Downloads](https://img.shields.io/npm/dm/package-name)

    # Badge with link
    [![npm version](https://badge.fury.io/js/package.svg)](https://www.npmjs.com/package/package-name)

    # Custom badge
    ![Custom](https://img.shields.io/badge/custom-badge-blue)
    ![Status](https://img.shields.io/badge/status-active-success)
<

==============================================================================
17. COLLAPSIBLE SECTIONS                              *markdown-collapsible*

Collapsible syntax~                             *markdown-collapsible-syntax*
>
    <details>
    <summary>Click to expand</summary>

    ## Hidden Content

    This content is hidden until clicked.

    - Item 1
    - Item 2

    ```javascript
    console.log("Hidden code");
    ```

    </details>

    <details open>
    <summary>Expanded by default</summary>

    This is visible by default.

    </details>
<

==============================================================================
18. MATH                                                      *markdown-math*

Math syntax~                                            *markdown-math-syntax*
>
    # Inline math
    This is inline math: $E = mc^2$

    # Block math
    $$
    \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
    $$

    # LaTeX syntax
    $$
    \begin{aligned}
    f(x) &= x^2 + 2x + 1 \\
         &= (x + 1)^2
    \end{aligned}
    $$
<

==============================================================================
19. DIAGRAMS (MERMAID)                                     *markdown-mermaid*

Flowchart~                                         *markdown-mermaid-flowchart*
>
    ```mermaid
    graph TD
        A[Start] --> B{Decision}
        B -->|Yes| C[OK]
        B -->|No| D[End]
    ```
<

Sequence diagram~                                 *markdown-mermaid-sequence*
>
    ```mermaid
    sequenceDiagram
        Alice->>John: Hello John
        John-->>Alice: Hi Alice
    ```
<

Gantt chart~                                          *markdown-mermaid-gantt*
>
    ```mermaid
    gantt
        title Project Schedule
        dateFormat  YYYY-MM-DD
        section Tasks
        Task 1           :a1, 2024-01-01, 30d
        Task 2           :after a1, 20d
    ```
<

Class diagram~                                        *markdown-mermaid-class*
>
    ```mermaid
    classDiagram
        Animal <|-- Duck
        Animal <|-- Fish
        Animal : +int age
        Animal : +String gender
        Animal: +isMammal()
        class Duck{
            +String beakColor
            +swim()
        }
    ```
<

State diagram~                                        *markdown-mermaid-state*
>
    ```mermaid
    stateDiagram-v2
        [*] --> Still
        Still --> Moving
        Moving --> Still
        Moving --> [*]
    ```
<

Pie chart~                                              *markdown-mermaid-pie*
>
    ```mermaid
    pie title Pets
        "Dogs" : 386
        "Cats" : 85
        "Rats" : 15
    ```
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
