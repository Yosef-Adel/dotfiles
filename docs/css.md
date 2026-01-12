# CSS Reference

Quick reference for CSS. Use `/` to search in vim.

## Table of Contents

- [Flexbox](#flexbox)
  - [Container Properties](#container-properties)
  - [Item Properties](#item-properties)
  - [Common Flexbox Patterns](#common-flexbox-patterns)
- [Grid](#grid)
  - [Container Properties](#container-properties-1)
  - [Item Properties](#item-properties-1)
  - [Named Grid Areas](#named-grid-areas)
  - [Common Grid Patterns](#common-grid-patterns)
- [Positioning](#positioning)
- [Box Model](#box-model)
- [Typography](#typography)
- [Colors & Backgrounds](#colors--backgrounds)
- [Shadows & Effects](#shadows--effects)
- [Transitions & Animations](#transitions--animations)
  - [Transitions](#transitions)
  - [Animations](#animations)
- [Transforms](#transforms)
- [Media Queries](#media-queries)
- [CSS Variables](#css-variables)
- [Pseudo-classes & Pseudo-elements](#pseudo-classes--pseudo-elements)

## Flexbox

### Container Properties
```css
.container {
  display: flex;

  /* Direction */
  flex-direction: row | row-reverse | column | column-reverse;

  /* Wrap */
  flex-wrap: nowrap | wrap | wrap-reverse;

  /* Shorthand for direction + wrap */
  flex-flow: row wrap;

  /* Main axis alignment */
  justify-content: flex-start | flex-end | center | space-between | space-around | space-evenly;

  /* Cross axis alignment */
  align-items: stretch | flex-start | flex-end | center | baseline;

  /* Multi-line alignment */
  align-content: stretch | flex-start | flex-end | center | space-between | space-around;

  /* Gap between items */
  gap: 1rem;
  row-gap: 1rem;
  column-gap: 1rem;
}
```

### Item Properties
```css
.item {
  /* Order (default: 0) */
  order: 1;

  /* Grow factor (default: 0) */
  flex-grow: 1;

  /* Shrink factor (default: 1) */
  flex-shrink: 0;

  /* Base size (default: auto) */
  flex-basis: 200px;

  /* Shorthand: grow shrink basis */
  flex: 1 0 200px;
  flex: 1; /* grow: 1, shrink: 1, basis: 0% */

  /* Self alignment */
  align-self: auto | flex-start | flex-end | center | baseline | stretch;
}
```

### Common Flexbox Patterns
```css
/* Center content */
.center {
  display: flex;
  justify-content: center;
  align-items: center;
}

/* Space between items */
.space-between {
  display: flex;
  justify-content: space-between;
}

/* Responsive flex wrap */
.flex-wrap {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
}

.flex-wrap > * {
  flex: 1 1 300px; /* Grow, don't shrink below 300px */
}
```

## Grid

### Container Properties
```css
.grid {
  display: grid;

  /* Define columns */
  grid-template-columns: 200px 1fr 1fr;
  grid-template-columns: repeat(3, 1fr);
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));

  /* Define rows */
  grid-template-rows: 100px auto 100px;
  grid-template-rows: repeat(3, 100px);

  /* Gap */
  gap: 1rem;
  row-gap: 1rem;
  column-gap: 1rem;

  /* Alignment */
  justify-items: start | end | center | stretch;
  align-items: start | end | center | stretch;
  place-items: center; /* align + justify shorthand */

  /* Content alignment */
  justify-content: start | end | center | space-between | space-around | space-evenly;
  align-content: start | end | center | space-between | space-around | space-evenly;

  /* Auto columns/rows */
  grid-auto-columns: 1fr;
  grid-auto-rows: 100px;
  grid-auto-flow: row | column | dense;
}
```

### Item Properties
```css
.item {
  /* Column placement */
  grid-column: 1 / 3; /* Start at 1, end at 3 */
  grid-column: 1 / span 2; /* Start at 1, span 2 columns */
  grid-column-start: 1;
  grid-column-end: 3;

  /* Row placement */
  grid-row: 1 / 3;
  grid-row: 1 / span 2;
  grid-row-start: 1;
  grid-row-end: 3;

  /* Shorthand */
  grid-area: 1 / 1 / 3 / 3; /* row-start / col-start / row-end / col-end */

  /* Self alignment */
  justify-self: start | end | center | stretch;
  align-self: start | end | center | stretch;
}
```

### Named Grid Areas
```css
.grid {
  display: grid;
  grid-template-areas:
    "header header header"
    "sidebar main main"
    "footer footer footer";
  grid-template-columns: 200px 1fr 1fr;
  grid-template-rows: auto 1fr auto;
}

.header { grid-area: header; }
.sidebar { grid-area: sidebar; }
.main { grid-area: main; }
.footer { grid-area: footer; }
```

### Common Grid Patterns
```css
/* Responsive grid */
.responsive-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1rem;
}

/* 12-column grid */
.twelve-col {
  display: grid;
  grid-template-columns: repeat(12, 1fr);
  gap: 1rem;
}

.span-6 { grid-column: span 6; }
.span-4 { grid-column: span 4; }
```

## Positioning

```css
.element {
  position: static | relative | absolute | fixed | sticky;

  /* Offsets (work with non-static positions) */
  top: 10px;
  right: 10px;
  bottom: 10px;
  left: 10px;

  /* Z-index (stacking order) */
  z-index: 10;
}

/* Relative: relative to normal position */
.relative {
  position: relative;
  top: 10px; /* Moves down 10px */
}

/* Absolute: relative to nearest positioned ancestor */
.absolute {
  position: absolute;
  top: 0;
  right: 0;
}

/* Fixed: relative to viewport */
.fixed {
  position: fixed;
  bottom: 20px;
  right: 20px;
}

/* Sticky: switches between relative and fixed */
.sticky {
  position: sticky;
  top: 0; /* Sticks when scrolled to top */
}
```

## Box Model

```css
.box {
  /* Width & Height */
  width: 200px;
  height: 100px;
  min-width: 100px;
  max-width: 500px;
  min-height: 50px;
  max-height: 300px;

  /* Padding */
  padding: 10px; /* All sides */
  padding: 10px 20px; /* Top/bottom, left/right */
  padding: 10px 20px 15px; /* Top, left/right, bottom */
  padding: 10px 20px 15px 25px; /* Top, right, bottom, left */
  padding-top: 10px;
  padding-right: 20px;
  padding-bottom: 15px;
  padding-left: 25px;

  /* Margin (same syntax as padding) */
  margin: 10px;
  margin: 0 auto; /* Center horizontally */

  /* Border */
  border: 1px solid #ccc;
  border-width: 1px;
  border-style: solid | dashed | dotted | double;
  border-color: #ccc;
  border-radius: 5px;

  /* Box sizing */
  box-sizing: content-box | border-box;
}
```

## Typography

```css
.text {
  /* Font */
  font-family: 'Helvetica', Arial, sans-serif;
  font-size: 16px;
  font-weight: normal | bold | 100-900;
  font-style: normal | italic;
  line-height: 1.5;

  /* Text */
  color: #333;
  text-align: left | center | right | justify;
  text-decoration: none | underline | line-through;
  text-transform: none | uppercase | lowercase | capitalize;
  letter-spacing: 0.5px;
  word-spacing: 2px;

  /* Overflow */
  white-space: normal | nowrap | pre | pre-wrap;
  overflow: visible | hidden | scroll | auto;
  text-overflow: clip | ellipsis;

  /* Truncate text */
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;

  /* Line clamp (webkit only) */
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
```

## Colors & Backgrounds

```css
.element {
  /* Colors */
  color: #333;
  color: rgb(51, 51, 51);
  color: rgba(51, 51, 51, 0.5);
  color: hsl(0, 0%, 20%);
  color: hsla(0, 0%, 20%, 0.5);

  /* Background */
  background-color: #fff;
  background-image: url('image.jpg');
  background-size: cover | contain | 100px 200px;
  background-position: center | top left | 50% 50%;
  background-repeat: no-repeat | repeat | repeat-x | repeat-y;
  background-attachment: scroll | fixed;

  /* Shorthand */
  background: #fff url('image.jpg') no-repeat center / cover;

  /* Gradient */
  background: linear-gradient(to right, #ff0000, #00ff00);
  background: linear-gradient(45deg, #ff0000, #00ff00);
  background: radial-gradient(circle, #ff0000, #00ff00);
}
```

## Shadows & Effects

```css
.element {
  /* Box shadow */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.5), inset 0 0 5px rgba(255, 255, 255, 0.2);

  /* Text shadow */
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);

  /* Opacity */
  opacity: 0.5;

  /* Filter */
  filter: blur(5px);
  filter: brightness(0.5);
  filter: contrast(200%);
  filter: grayscale(100%);
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.1));
}
```

## Transitions & Animations

### Transitions
```css
.button {
  background: blue;
  transition: background 0.3s ease;
}

.button:hover {
  background: darkblue;
}

/* Multiple properties */
.element {
  transition: background 0.3s ease, transform 0.2s ease-out;
}

/* All properties */
.element {
  transition: all 0.3s ease;
}

/* Timing functions */
transition-timing-function: linear | ease | ease-in | ease-out | ease-in-out | cubic-bezier();
```

### Animations
```css
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

.element {
  animation: slide-in 0.5s ease-out;
  animation-name: slide-in;
  animation-duration: 0.5s;
  animation-timing-function: ease-out;
  animation-delay: 0s;
  animation-iteration-count: 1 | infinite;
  animation-direction: normal | reverse | alternate;
  animation-fill-mode: none | forwards | backwards | both;
}
```

## Transforms

```css
.element {
  /* 2D Transforms */
  transform: translate(50px, 100px);
  transform: translateX(50px);
  transform: translateY(100px);
  transform: scale(1.5);
  transform: scaleX(2);
  transform: scaleY(0.5);
  transform: rotate(45deg);
  transform: skew(10deg, 20deg);

  /* Multiple transforms */
  transform: translate(50px, 100px) rotate(45deg) scale(1.2);

  /* 3D Transforms */
  transform: translateZ(50px);
  transform: rotateX(45deg);
  transform: rotateY(45deg);
  transform: rotateZ(45deg);

  /* Transform origin */
  transform-origin: center | top left | 50% 50%;
}
```

## Media Queries

```css
/* Mobile first approach */
.element {
  width: 100%;
}

/* Tablet */
@media (min-width: 768px) {
  .element {
    width: 50%;
  }
}

/* Desktop */
@media (min-width: 1024px) {
  .element {
    width: 33.333%;
  }
}

/* Other media features */
@media (max-width: 767px) { }
@media (orientation: portrait) { }
@media (orientation: landscape) { }
@media (prefers-color-scheme: dark) { }
@media print { }
```

## CSS Variables

```css
:root {
  --primary-color: #007bff;
  --secondary-color: #6c757d;
  --spacing: 1rem;
  --border-radius: 4px;
}

.element {
  background: var(--primary-color);
  padding: var(--spacing);
  border-radius: var(--border-radius);
}

/* Fallback value */
.element {
  color: var(--text-color, #333);
}

/* Calc with variables */
.element {
  width: calc(100% - var(--spacing) * 2);
}
```

## Pseudo-classes & Pseudo-elements

```css
/* Pseudo-classes */
a:hover { }
a:active { }
a:focus { }
a:visited { }

input:disabled { }
input:checked { }
input:required { }
input:valid { }
input:invalid { }

li:first-child { }
li:last-child { }
li:nth-child(2) { }
li:nth-child(odd) { }
li:nth-child(even) { }
li:nth-child(3n) { }
li:not(:last-child) { }

/* Pseudo-elements */
.element::before {
  content: "→ ";
}

.element::after {
  content: "";
  display: block;
}

.element::first-letter { }
.element::first-line { }
.element::selection { }
```
