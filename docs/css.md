*css.txt*  CSS Reference

==============================================================================
CONTENTS                                                        *css-contents*

1. Selectors ............................. |css-selectors|
2. Flexbox ............................... |css-flexbox|
3. Grid .................................. |css-grid|
4. Positioning ........................... |css-positioning|
5. Box Model ............................. |css-box-model|
6. Typography ............................ |css-typography|
7. Colors & Backgrounds .................. |css-colors|
8. Shadows & Effects ..................... |css-effects|
9. Transitions & Animations .............. |css-animations|
10. Transforms ........................... |css-transforms|
11. Media Queries ........................ |css-media|
12. CSS Variables ........................ |css-variables|
13. Pseudo-classes ....................... |css-pseudo|

==============================================================================
1. Selectors                                                *css-selectors*

Basic Selectors~                                         *css-selector-basic*
>
    /* Element */
    p { color: red; }

    /* Class */
    .container { width: 100%; }

    /* ID */
    #header { background: blue; }

    /* Universal */
    * { margin: 0; }

    /* Attribute */
    [type="text"] { border: 1px solid gray; }
    [href^="https"] { color: green; }
    [href$=".pdf"] { color: red; }
    [class*="btn"] { padding: 10px; }
<

Combinators~                                             *css-combinators*
>
    /* Descendant (space) */
    .parent .child { }

    /* Direct child (>) */
    .parent > .child { }

    /* Adjacent sibling (+) */
    h1 + p { }

    /* General sibling (~) */
    h1 ~ p { }
<

Pseudo-classes~                                          *css-pseudo-classes*
>
    /* Link states */
    a:hover { }
    a:active { }
    a:focus { }
    a:visited { }

    /* Form states */
    input:disabled { }
    input:enabled { }
    input:checked { }
    input:required { }
    input:optional { }
    input:valid { }
    input:invalid { }
    input:placeholder-shown { }

    /* Structural */
    li:first-child { }
    li:last-child { }
    li:nth-child(2) { }
    li:nth-child(odd) { }
    li:nth-child(even) { }
    li:nth-child(3n) { }
    li:nth-child(3n+1) { }
    li:nth-of-type(2) { }
    li:not(:last-child) { }
    li:only-child { }
    li:empty { }
<

Pseudo-elements~                                         *css-pseudo-elements*
>
    /* Before and after */
    .element::before {
      content: "→ ";
      display: inline-block;
    }

    .element::after {
      content: "";
      display: block;
    }

    /* Text selection */
    ::selection {
      background: yellow;
      color: black;
    }

    /* First letter/line */
    p::first-letter { font-size: 2em; }
    p::first-line { font-weight: bold; }

    /* Placeholder */
    input::placeholder {
      color: gray;
      opacity: 0.5;
    }
<

==============================================================================
2. Flexbox                                                      *css-flexbox*

Flex Container~                                          *css-flex-container*
>
    .container {
      display: flex;

      /* Direction */
      flex-direction: row;             /* Default */
      flex-direction: row-reverse;
      flex-direction: column;
      flex-direction: column-reverse;

      /* Wrap */
      flex-wrap: nowrap;               /* Default */
      flex-wrap: wrap;
      flex-wrap: wrap-reverse;

      /* Shorthand: direction wrap */
      flex-flow: row wrap;

      /* Main axis alignment (horizontal for row) */
      justify-content: flex-start;     /* Default */
      justify-content: flex-end;
      justify-content: center;
      justify-content: space-between;
      justify-content: space-around;
      justify-content: space-evenly;

      /* Cross axis alignment (vertical for row) */
      align-items: stretch;            /* Default */
      align-items: flex-start;
      align-items: flex-end;
      align-items: center;
      align-items: baseline;

      /* Multi-line alignment */
      align-content: stretch;
      align-content: flex-start;
      align-content: center;
      align-content: space-between;

      /* Gap between items */
      gap: 1rem;
      row-gap: 1rem;
      column-gap: 1rem;
    }
<

Flex Items~                                              *css-flex-items*
>
    .item {
      /* Order (default: 0) */
      order: 1;

      /* Grow factor (default: 0) */
      flex-grow: 1;                    /* Take available space */

      /* Shrink factor (default: 1) */
      flex-shrink: 0;                  /* Don't shrink */

      /* Base size (default: auto) */
      flex-basis: 200px;
      flex-basis: 50%;
      flex-basis: 0;

      /* Shorthand: grow shrink basis */
      flex: 1;                         /* 1 1 0% */
      flex: 0 0 200px;                 /* Fixed 200px */
      flex: 1 0 200px;                 /* Grow from 200px base */

      /* Self alignment */
      align-self: auto;
      align-self: flex-start;
      align-self: center;
      align-self: flex-end;
    }
<

Common Flex Patterns~                                   *css-flex-patterns*
>
    /* Center content */
    .center {
      display: flex;
      justify-content: center;
      align-items: center;
    }

    /* Space between */
    .space-between {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    /* Responsive cards */
    .cards {
      display: flex;
      flex-wrap: wrap;
      gap: 1rem;
    }

    .card {
      flex: 1 1 300px;                 /* Min 300px, grow to fill */
    }

    /* Push item to right */
    .nav-item:last-child {
      margin-left: auto;
    }
<

==============================================================================
3. Grid                                                          *css-grid*

Grid Container~                                          *css-grid-container*
>
    .grid {
      display: grid;

      /* Define columns */
      grid-template-columns: 200px 1fr 1fr;
      grid-template-columns: repeat(3, 1fr);
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      grid-template-columns: 1fr 2fr 1fr;

      /* Define rows */
      grid-template-rows: 100px auto 100px;
      grid-template-rows: repeat(3, 100px);
      grid-template-rows: auto 1fr auto;

      /* Gap */
      gap: 1rem;
      row-gap: 1rem;
      column-gap: 2rem;

      /* Item alignment in cell */
      justify-items: start;            /* Horizontal */
      justify-items: end;
      justify-items: center;
      justify-items: stretch;          /* Default */

      align-items: start;              /* Vertical */
      align-items: end;
      align-items: center;
      align-items: stretch;            /* Default */

      place-items: center;             /* align + justify shorthand */

      /* Grid alignment in container */
      justify-content: start;
      justify-content: center;
      justify-content: space-between;

      align-content: start;
      align-content: center;
      align-content: space-evenly;

      /* Auto sizing */
      grid-auto-columns: 1fr;
      grid-auto-rows: 100px;
      grid-auto-flow: row;             /* Default */
      grid-auto-flow: column;
      grid-auto-flow: dense;           /* Fill holes */
    }
<

Grid Items~                                              *css-grid-items*
>
    .item {
      /* Column placement */
      grid-column: 1 / 3;              /* Start at 1, end at 3 */
      grid-column: 1 / span 2;         /* Start at 1, span 2 columns */
      grid-column: 1 / -1;             /* Start to end */
      grid-column-start: 1;
      grid-column-end: 3;

      /* Row placement */
      grid-row: 1 / 3;
      grid-row: 1 / span 2;
      grid-row-start: 1;
      grid-row-end: 3;

      /* Shorthand: row-start / col-start / row-end / col-end */
      grid-area: 1 / 1 / 3 / 3;

      /* Self alignment */
      justify-self: start;
      justify-self: center;
      justify-self: end;
      justify-self: stretch;

      align-self: start;
      align-self: center;
      align-self: end;
      align-self: stretch;

      place-self: center;              /* align + justify */
    }
<

Named Grid Areas~                                        *css-grid-areas*
>
    .layout {
      display: grid;
      grid-template-areas:
        "header header header"
        "sidebar main main"
        "footer footer footer";
      grid-template-columns: 200px 1fr 1fr;
      grid-template-rows: auto 1fr auto;
      gap: 1rem;
    }

    .header { grid-area: header; }
    .sidebar { grid-area: sidebar; }
    .main { grid-area: main; }
    .footer { grid-area: footer; }

    /* Responsive with media query */
    @media (max-width: 768px) {
      .layout {
        grid-template-areas:
          "header"
          "main"
          "sidebar"
          "footer";
        grid-template-columns: 1fr;
      }
    }
<

Common Grid Patterns~                                   *css-grid-patterns*
>
    /* Responsive auto-fit grid */
    .responsive-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 1rem;
    }

    /* 12-column grid system */
    .twelve-col {
      display: grid;
      grid-template-columns: repeat(12, 1fr);
      gap: 1rem;
    }

    .span-6 { grid-column: span 6; }
    .span-4 { grid-column: span 4; }
    .span-3 { grid-column: span 3; }

    /* Holy grail layout */
    .holy-grail {
      display: grid;
      grid-template:
        "header" auto
        "nav" auto
        "main" 1fr
        "aside" auto
        "footer" auto / 1fr;
      min-height: 100vh;
    }

    @media (min-width: 768px) {
      .holy-grail {
        grid-template:
          "header header header" auto
          "nav main aside" 1fr
          "footer footer footer" auto / 200px 1fr 200px;
      }
    }
<

==============================================================================
4. Positioning                                              *css-positioning*

Position Types~                                          *css-position-types*
>
    .element {
      /* Static (default) - normal flow */
      position: static;

      /* Relative - offset from normal position */
      position: relative;
      top: 10px;                       /* Moves down */
      left: 20px;                      /* Moves right */

      /* Absolute - relative to nearest positioned ancestor */
      position: absolute;
      top: 0;
      right: 0;
      bottom: 0;
      left: 0;

      /* Fixed - relative to viewport */
      position: fixed;
      bottom: 20px;
      right: 20px;

      /* Sticky - switches between relative and fixed */
      position: sticky;
      top: 0;                          /* Sticks when scrolled to top */

      /* Stacking order */
      z-index: 10;
    }
<

Centering with Position~                                 *css-position-center*
>
    /* Center absolutely positioned element */
    .centered {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }

    /* Alternative with inset */
    .centered-alt {
      position: absolute;
      inset: 0;                        /* top right bottom left: 0 */
      margin: auto;
      width: 200px;                    /* Must have dimensions */
      height: 100px;
    }
<

==============================================================================
5. Box Model                                                *css-box-model*

Dimensions~                                              *css-dimensions*
>
    .box {
      /* Width & Height */
      width: 200px;
      height: 100px;
      min-width: 100px;
      max-width: 500px;
      min-height: 50px;
      max-height: 300px;

      /* Percentage */
      width: 100%;
      height: 50vh;                    /* Viewport height */

      /* Responsive */
      width: clamp(300px, 50%, 800px); /* Min, preferred, max */
    }
<

Padding & Margin~                                        *css-spacing*
>
    .box {
      /* Padding (inside) */
      padding: 10px;                   /* All sides */
      padding: 10px 20px;              /* Vertical horizontal */
      padding: 10px 20px 15px;         /* Top, horizontal, bottom */
      padding: 10px 20px 15px 25px;    /* Top, right, bottom, left */

      padding-top: 10px;
      padding-right: 20px;
      padding-bottom: 15px;
      padding-left: 25px;

      /* Margin (outside) - same syntax */
      margin: 10px;
      margin: 0 auto;                  /* Center horizontally */
      margin-top: 20px;
    }
<

Borders~                                                 *css-borders*
>
    .box {
      /* Shorthand */
      border: 1px solid #ccc;

      /* Individual properties */
      border-width: 1px;
      border-style: solid;
      border-style: dashed;
      border-style: dotted;
      border-style: double;
      border-style: none;
      border-color: #ccc;

      /* Individual sides */
      border-top: 1px solid #ccc;
      border-right: 2px dashed blue;
      border-bottom: 3px dotted red;
      border-left: 1px solid black;

      /* Border radius */
      border-radius: 5px;
      border-radius: 10px 20px;        /* Top-left/bottom-right, top-right/bottom-left */
      border-radius: 10px 20px 30px 40px;  /* TL, TR, BR, BL */
      border-radius: 50%;              /* Circle */

      /* Individual corners */
      border-top-left-radius: 10px;
      border-top-right-radius: 20px;
      border-bottom-right-radius: 30px;
      border-bottom-left-radius: 40px;
    }
<

Box Sizing~                                              *css-box-sizing*
>
    /* Content-box (default) - width/height = content only */
    .content-box {
      box-sizing: content-box;
      width: 200px;                    /* + padding + border */
      padding: 20px;
      border: 10px solid;              /* Total width: 260px */
    }

    /* Border-box - width/height = content + padding + border */
    .border-box {
      box-sizing: border-box;
      width: 200px;                    /* Includes padding + border */
      padding: 20px;
      border: 10px solid;              /* Total width: 200px */
    }

    /* Recommended global reset */
    * {
      box-sizing: border-box;
    }
<

Display~                                                 *css-display*
>
    .element {
      display: block;                  /* Full width, new line */
      display: inline;                 /* Flow with text */
      display: inline-block;           /* Flow with text, accepts width/height */
      display: none;                   /* Hidden, no space */
      display: flex;                   /* See |css-flexbox| */
      display: grid;                   /* See |css-grid| */
      display: inline-flex;
      display: inline-grid;

      /* Visibility (takes space) */
      visibility: visible;
      visibility: hidden;
    }
<

Overflow~                                                *css-overflow*
>
    .box {
      overflow: visible;               /* Default - content overflows */
      overflow: hidden;                /* Clip overflow */
      overflow: scroll;                /* Always show scrollbars */
      overflow: auto;                  /* Scrollbar when needed */

      /* Individual axes */
      overflow-x: hidden;
      overflow-y: scroll;
    }
<

==============================================================================
6. Typography                                              *css-typography*

Font Properties~                                         *css-font*
>
    .text {
      /* Font family */
      font-family: 'Helvetica', Arial, sans-serif;
      font-family: 'Georgia', serif;
      font-family: 'Courier New', monospace;

      /* Font size */
      font-size: 16px;
      font-size: 1rem;                 /* Relative to root */
      font-size: 1.5em;                /* Relative to parent */
      font-size: clamp(1rem, 2vw, 2rem);

      /* Font weight */
      font-weight: normal;             /* 400 */
      font-weight: bold;               /* 700 */
      font-weight: 100;                /* Thin */
      font-weight: 200;                /* Extra light */
      font-weight: 300;                /* Light */
      font-weight: 400;                /* Normal */
      font-weight: 500;                /* Medium */
      font-weight: 600;                /* Semi-bold */
      font-weight: 700;                /* Bold */
      font-weight: 800;                /* Extra bold */
      font-weight: 900;                /* Black */

      /* Font style */
      font-style: normal;
      font-style: italic;
      font-style: oblique;

      /* Line height */
      line-height: 1.5;                /* Unitless (recommended) */
      line-height: 24px;
      line-height: 1.5em;
    }
<

Text Properties~                                         *css-text*
>
    .text {
      /* Color */
      color: #333;
      color: currentColor;             /* Inherit current color */

      /* Alignment */
      text-align: left;
      text-align: center;
      text-align: right;
      text-align: justify;

      /* Decoration */
      text-decoration: none;
      text-decoration: underline;
      text-decoration: line-through;
      text-decoration: overline;
      text-decoration-color: red;
      text-decoration-style: solid;
      text-decoration-style: dashed;
      text-decoration-thickness: 2px;

      /* Transform */
      text-transform: none;
      text-transform: uppercase;
      text-transform: lowercase;
      text-transform: capitalize;

      /* Spacing */
      letter-spacing: 0.5px;
      letter-spacing: 0.05em;
      word-spacing: 2px;

      /* Indent */
      text-indent: 2em;
    }
<

Text Overflow~                                           *css-text-overflow*
>
    /* Single line truncate */
    .truncate {
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    /* Multi-line clamp (webkit) */
    .clamp {
      display: -webkit-box;
      -webkit-line-clamp: 3;
      -webkit-box-orient: vertical;
      overflow: hidden;
    }

    /* Modern line-clamp (limited support) */
    .clamp-modern {
      overflow: hidden;
      text-overflow: ellipsis;
      line-clamp: 3;
    }
<

White Space~                                             *css-white-space*
>
    .text {
      white-space: normal;             /* Wrap, collapse whitespace */
      white-space: nowrap;             /* No wrap, collapse whitespace */
      white-space: pre;                /* No wrap, preserve whitespace */
      white-space: pre-wrap;           /* Wrap, preserve whitespace */
      white-space: pre-line;           /* Wrap, preserve newlines */

      word-break: normal;
      word-break: break-all;           /* Break within words */
      word-break: keep-all;            /* Don't break CJK text */

      overflow-wrap: normal;
      overflow-wrap: break-word;       /* Break long words */
    }
<

==============================================================================
7. Colors & Backgrounds                                        *css-colors*

Color Formats~                                           *css-color-formats*
>
    .element {
      /* Hex */
      color: #333;
      color: #333333;
      color: #3338;                    /* With alpha */

      /* RGB */
      color: rgb(51, 51, 51);
      color: rgba(51, 51, 51, 0.5);

      /* HSL */
      color: hsl(0, 0%, 20%);
      color: hsla(0, 0%, 20%, 0.5);

      /* Modern functional notation */
      color: rgb(51 51 51 / 0.5);
      color: hsl(0 0% 20% / 0.5);

      /* Named colors */
      color: red;
      color: transparent;
      color: currentColor;
    }
<

Backgrounds~                                             *css-background*
>
    .element {
      background-color: #fff;

      /* Image */
      background-image: url('image.jpg');
      background-size: cover;
      background-size: contain;
      background-size: 100px 200px;
      background-size: 50% auto;

      background-position: center;
      background-position: top left;
      background-position: 50% 50%;
      background-position: 10px 20px;

      background-repeat: no-repeat;
      background-repeat: repeat;
      background-repeat: repeat-x;
      background-repeat: repeat-y;

      background-attachment: scroll;
      background-attachment: fixed;

      /* Shorthand: color image repeat position / size */
      background: #fff url('bg.jpg') no-repeat center / cover;

      /* Multiple backgrounds */
      background:
        url('front.png') no-repeat center,
        url('back.png') no-repeat center;
    }
<

Gradients~                                               *css-gradients*
>
    /* Linear gradient */
    background: linear-gradient(to right, #ff0000, #00ff00);
    background: linear-gradient(45deg, #ff0000, #00ff00);
    background: linear-gradient(to bottom, red, yellow, green);
    background: linear-gradient(to right, red 0%, yellow 50%, green 100%);

    /* Radial gradient */
    background: radial-gradient(circle, #ff0000, #00ff00);
    background: radial-gradient(ellipse at top, red, blue);
    background: radial-gradient(circle at 20% 50%, red, blue);

    /* Conic gradient */
    background: conic-gradient(red, yellow, green, blue, red);
    background: conic-gradient(from 45deg, red, yellow, green);

    /* Repeating gradients */
    background: repeating-linear-gradient(45deg, red 0px, blue 10px);
    background: repeating-radial-gradient(circle, red 0px, blue 20px);
<

==============================================================================
8. Shadows & Effects                                          *css-effects*

Box Shadow~                                              *css-box-shadow*
>
    .box {
      /* offset-x | offset-y | blur | spread | color */
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.2);
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);

      /* Inset shadow */
      box-shadow: inset 0 0 10px rgba(0, 0, 0, 0.5);

      /* Multiple shadows */
      box-shadow:
        0 2px 4px rgba(0, 0, 0, 0.1),
        0 8px 16px rgba(0, 0, 0, 0.1);

      /* Material design elevation */
      box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12),
                  0 1px 2px rgba(0, 0, 0, 0.24);
    }
<

Text Shadow~                                             *css-text-shadow*
>
    .text {
      /* offset-x | offset-y | blur | color */
      text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
      text-shadow: 2px 2px 4px #000;

      /* Multiple shadows */
      text-shadow:
        1px 1px 2px red,
        -1px -1px 2px blue;

      /* Glow effect */
      text-shadow: 0 0 10px rgba(255, 255, 255, 0.8);
    }
<

Opacity~                                                 *css-opacity*
>
    .element {
      opacity: 1;                      /* Fully opaque (default) */
      opacity: 0.5;                    /* 50% transparent */
      opacity: 0;                      /* Fully transparent */
    }
<

Filters~                                                 *css-filter*
>
    .image {
      /* Blur */
      filter: blur(5px);

      /* Brightness */
      filter: brightness(0.5);         /* 50% */
      filter: brightness(1.5);         /* 150% */

      /* Contrast */
      filter: contrast(200%);

      /* Grayscale */
      filter: grayscale(100%);
      filter: grayscale(0.5);          /* 50% gray */

      /* Hue rotation */
      filter: hue-rotate(90deg);

      /* Invert */
      filter: invert(100%);

      /* Saturate */
      filter: saturate(200%);

      /* Sepia */
      filter: sepia(100%);

      /* Drop shadow */
      filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));

      /* Multiple filters */
      filter: brightness(1.2) contrast(1.1) saturate(1.3);
    }
<

Backdrop Filter~                                         *css-backdrop-filter*
>
    .glass {
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(10px);
      backdrop-filter: brightness(1.5);
      backdrop-filter: blur(10px) brightness(1.2);
    }
<

==============================================================================
9. Transitions & Animations                                *css-animations*

Transitions~                                             *css-transition*
>
    .button {
      background: blue;
      transition: background 0.3s ease;
    }

    .button:hover {
      background: darkblue;
    }

    /* Multiple properties */
    .element {
      transition: background 0.3s ease,
                  transform 0.2s ease-out,
                  opacity 0.3s linear;
    }

    /* All properties */
    .element {
      transition: all 0.3s ease;
    }

    /* Individual properties */
    .element {
      transition-property: background, transform;
      transition-duration: 0.3s, 0.2s;
      transition-timing-function: ease, ease-out;
      transition-delay: 0s, 0.1s;
    }

    /* Timing functions */
    transition-timing-function: linear;
    transition-timing-function: ease;
    transition-timing-function: ease-in;
    transition-timing-function: ease-out;
    transition-timing-function: ease-in-out;
    transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
<

Keyframe Animations~                                     *css-keyframes*
>
    @keyframes slide-in {
      from {
        transform: translateX(-100%);
        opacity: 0;
      }
      to {
        transform: translateX(0);
        opacity: 1;
      }
    }

    /* With percentages */
    @keyframes bounce {
      0%, 100% {
        transform: translateY(0);
      }
      50% {
        transform: translateY(-20px);
      }
    }

    /* Apply animation */
    .element {
      animation: slide-in 0.5s ease-out;
    }
<

Animation Properties~                                    *css-animation-props*
>
    .element {
      /* Shorthand */
      animation: name duration timing-function delay iteration-count direction fill-mode;
      animation: slide-in 0.5s ease-out 0s 1 normal forwards;

      /* Individual properties */
      animation-name: slide-in;
      animation-duration: 0.5s;
      animation-timing-function: ease-out;
      animation-delay: 0s;
      animation-iteration-count: 1;
      animation-iteration-count: infinite;
      animation-direction: normal;
      animation-direction: reverse;
      animation-direction: alternate;
      animation-direction: alternate-reverse;
      animation-fill-mode: none;
      animation-fill-mode: forwards;   /* Keep end state */
      animation-fill-mode: backwards;  /* Apply start state during delay */
      animation-fill-mode: both;
      animation-play-state: running;
      animation-play-state: paused;

      /* Multiple animations */
      animation: fade-in 0.3s ease-out,
                 slide-up 0.5s ease-out 0.3s;
    }
<

Common Animations~                                       *css-animation-common*
>
    /* Fade in */
    @keyframes fade-in {
      from { opacity: 0; }
      to { opacity: 1; }
    }

    /* Slide up */
    @keyframes slide-up {
      from {
        transform: translateY(20px);
        opacity: 0;
      }
      to {
        transform: translateY(0);
        opacity: 1;
      }
    }

    /* Spin */
    @keyframes spin {
      from { transform: rotate(0deg); }
      to { transform: rotate(360deg); }
    }

    /* Pulse */
    @keyframes pulse {
      0%, 100% { transform: scale(1); }
      50% { transform: scale(1.05); }
    }
<

==============================================================================
10. Transforms                                             *css-transforms*

2D Transforms~                                           *css-transform-2d*
>
    .element {
      /* Translate (move) */
      transform: translate(50px, 100px);
      transform: translateX(50px);
      transform: translateY(100px);

      /* Scale */
      transform: scale(1.5);           /* 150% */
      transform: scale(2, 0.5);        /* X: 200%, Y: 50% */
      transform: scaleX(2);
      transform: scaleY(0.5);

      /* Rotate */
      transform: rotate(45deg);
      transform: rotate(-90deg);

      /* Skew */
      transform: skew(10deg, 20deg);
      transform: skewX(10deg);
      transform: skewY(20deg);

      /* Multiple transforms (order matters!) */
      transform: translate(50px, 100px) rotate(45deg) scale(1.2);
    }
<

3D Transforms~                                           *css-transform-3d*
>
    .element {
      /* Translate Z */
      transform: translateZ(50px);
      transform: translate3d(10px, 20px, 30px);

      /* Rotate 3D */
      transform: rotateX(45deg);
      transform: rotateY(45deg);
      transform: rotateZ(45deg);
      transform: rotate3d(1, 1, 0, 45deg);

      /* Scale Z */
      transform: scaleZ(2);
      transform: scale3d(1.5, 1.5, 2);

      /* Perspective */
      transform: perspective(500px) rotateY(45deg);
    }
<

Transform Origin~                                        *css-transform-origin*
>
    .element {
      /* Default is center (50% 50%) */
      transform-origin: center;
      transform-origin: top left;
      transform-origin: bottom right;
      transform-origin: 50% 50%;
      transform-origin: 0 0;           /* Top left */
      transform-origin: 100% 100%;     /* Bottom right */
      transform-origin: 20px 40px;

      /* With Z (3D) */
      transform-origin: 50% 50% 0;
    }
<

Perspective~                                             *css-perspective*
>
    /* On parent for children */
    .container {
      perspective: 1000px;
      perspective-origin: 50% 50%;
    }

    .child {
      transform: rotateY(45deg);
    }

    /* On element itself */
    .element {
      transform: perspective(500px) rotateY(45deg);
    }
<

==============================================================================
11. Media Queries                                              *css-media*

Breakpoints~                                             *css-breakpoints*
>
    /* Mobile first approach */
    .element {
      width: 100%;
    }

    /* Tablet (768px and up) */
    @media (min-width: 768px) {
      .element {
        width: 50%;
      }
    }

    /* Desktop (1024px and up) */
    @media (min-width: 1024px) {
      .element {
        width: 33.333%;
      }
    }

    /* Large desktop (1440px and up) */
    @media (min-width: 1440px) {
      .element {
        width: 25%;
      }
    }

    /* Max-width (desktop first) */
    @media (max-width: 767px) {
      .element {
        width: 100%;
      }
    }

    /* Range */
    @media (min-width: 768px) and (max-width: 1023px) {
      .element {
        width: 50%;
      }
    }
<

Media Features~                                          *css-media-features*
>
    /* Orientation */
    @media (orientation: portrait) { }
    @media (orientation: landscape) { }

    /* Aspect ratio */
    @media (aspect-ratio: 16/9) { }
    @media (min-aspect-ratio: 16/9) { }

    /* Color scheme */
    @media (prefers-color-scheme: dark) {
      :root {
        --bg: #000;
        --text: #fff;
      }
    }

    @media (prefers-color-scheme: light) {
      :root {
        --bg: #fff;
        --text: #000;
      }
    }

    /* Reduced motion */
    @media (prefers-reduced-motion: reduce) {
      * {
        animation: none !important;
        transition: none !important;
      }
    }

    /* Hover capability */
    @media (hover: hover) {
      .button:hover {
        background: blue;
      }
    }

    /* Print */
    @media print {
      .no-print {
        display: none;
      }
    }
<

Container Queries~                                       *css-container*
>
    .container {
      container-type: inline-size;
      container-name: card;
    }

    @container card (min-width: 400px) {
      .content {
        display: grid;
        grid-template-columns: 1fr 2fr;
      }
    }
<

==============================================================================
12. CSS Variables                                            *css-variables*

Defining Variables~                                      *css-var-define*
>
    :root {
      --primary-color: #007bff;
      --secondary-color: #6c757d;
      --spacing: 1rem;
      --spacing-lg: 2rem;
      --border-radius: 4px;
      --font-size: 16px;
      --transition: 0.3s ease;
    }

    /* Scoped to element */
    .dark-theme {
      --bg-color: #000;
      --text-color: #fff;
    }
<

Using Variables~                                         *css-var-use*
>
    .element {
      background: var(--primary-color);
      padding: var(--spacing);
      border-radius: var(--border-radius);

      /* Fallback value */
      color: var(--text-color, #333);

      /* Nested fallback */
      color: var(--user-color, var(--theme-color, #000));
    }
<

Calc with Variables~                                     *css-var-calc*
>
    .element {
      width: calc(100% - var(--spacing) * 2);
      margin: calc(var(--spacing) / 2);
      padding: calc(var(--spacing-lg) + 10px);
    }
<

JavaScript Integration~                                  *css-var-js*
>
    // Get variable
    const color = getComputedStyle(document.documentElement)
      .getPropertyValue('--primary-color');

    // Set variable
    document.documentElement.style
      .setProperty('--primary-color', '#ff0000');
<

Common Variable Patterns~                                *css-var-patterns*
>
    :root {
      /* Colors */
      --color-primary: #007bff;
      --color-secondary: #6c757d;
      --color-success: #28a745;
      --color-danger: #dc3545;
      --color-warning: #ffc107;
      --color-info: #17a2b8;

      /* Spacing scale */
      --space-xs: 0.25rem;
      --space-sm: 0.5rem;
      --space-md: 1rem;
      --space-lg: 2rem;
      --space-xl: 4rem;

      /* Font sizes */
      --text-xs: 0.75rem;
      --text-sm: 0.875rem;
      --text-base: 1rem;
      --text-lg: 1.125rem;
      --text-xl: 1.25rem;
      --text-2xl: 1.5rem;
      --text-3xl: 1.875rem;

      /* Z-index scale */
      --z-dropdown: 1000;
      --z-sticky: 1020;
      --z-fixed: 1030;
      --z-modal-backdrop: 1040;
      --z-modal: 1050;
      --z-popover: 1060;
      --z-tooltip: 1070;
    }
<

==============================================================================
13. Pseudo-classes                                              *css-pseudo*

See |css-pseudo-classes| and |css-pseudo-elements| above.

Additional Selectors~                                    *css-pseudo-advanced*
>
    /* Target */
    :target { }                        /* Element targeted by URL hash */

    /* Root */
    :root { }                          /* Document root (html) */

    /* Lang */
    :lang(en) { }

    /* Focus */
    :focus-visible { }                 /* Only keyboard focus */
    :focus-within { }                  /* Element or child has focus */

    /* State */
    :enabled { }
    :disabled { }
    :read-only { }
    :read-write { }
    :in-range { }
    :out-of-range { }

    /* Has (parent selector) */
    .parent:has(.child) { }            /* Parent that has child */
    .card:has(img) { }                 /* Card that contains image */

    /* Is */
    :is(h1, h2, h3) { }                /* Any of these */
    :is(.btn-primary, .btn-secondary) { }

    /* Where (same as :is but 0 specificity) */
    :where(h1, h2, h3) { }

    /* Not */
    :not(.excluded) { }
    :not(:first-child) { }
    li:not(:last-child) { }
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
