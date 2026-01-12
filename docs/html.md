# HTML Reference

Quick reference for HTML. Use `/` to search in vim.

## Table of Contents

- [Document Structure](#document-structure)
- [Meta Tags](#meta-tags)
- [Text Content](#text-content)
  - [Headings](#headings)
  - [Paragraphs & Text](#paragraphs--text)
  - [Lists](#lists)
- [Links & Media](#links--media)
  - [Links](#links)
  - [Images](#images)
  - [Video](#video)
  - [Audio](#audio)
- [Forms](#forms)
  - [Basic Form](#basic-form)
  - [Input Types](#input-types)
  - [Form Attributes](#form-attributes)
- [Tables](#tables)
- [Semantic HTML](#semantic-html)
- [Interactive Elements](#interactive-elements)
- [Embedded Content](#embedded-content)
- [HTML Entities](#html-entities)
- [Accessibility (ARIA)](#accessibility-aria)

## Document Structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Page Title</title>
  <link rel="stylesheet" href="styles.css">
</head>
<body>
  <!-- Content goes here -->
  <script src="script.js"></script>
</body>
</html>
```

## Meta Tags

```html
<!-- Character encoding -->
<meta charset="UTF-8">

<!-- Responsive viewport -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- SEO -->
<meta name="description" content="Page description for search engines">
<meta name="keywords" content="keyword1, keyword2, keyword3">
<meta name="author" content="Author Name">

<!-- Open Graph (Social Media) -->
<meta property="og:title" content="Page Title">
<meta property="og:description" content="Page description">
<meta property="og:image" content="https://example.com/image.jpg">
<meta property="og:url" content="https://example.com">

<!-- Twitter Card -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Page Title">
<meta name="twitter:description" content="Page description">
<meta name="twitter:image" content="https://example.com/image.jpg">

<!-- Favicon -->
<link rel="icon" href="/favicon.ico">
<link rel="apple-touch-icon" href="/apple-touch-icon.png">
```

## Text Content

### Headings

```html
<h1>Main Heading</h1>
<h2>Section Heading</h2>
<h3>Subsection Heading</h3>
<h4>Minor Heading</h4>
<h5>Small Heading</h5>
<h6>Smallest Heading</h6>
```

### Paragraphs & Text

```html
<!-- Paragraph -->
<p>This is a paragraph of text.</p>

<!-- Line break -->
<p>Line 1<br>Line 2</p>

<!-- Horizontal rule -->
<hr>

<!-- Text formatting -->
<strong>Bold text (important)</strong>
<b>Bold text (stylistic)</b>
<em>Italic text (emphasis)</em>
<i>Italic text (stylistic)</i>
<mark>Highlighted text</mark>
<small>Small text</small>
<del>Deleted text</del>
<ins>Inserted text</ins>
<sub>Subscript</sub>
<sup>Superscript</sup>

<!-- Code -->
<code>inline code</code>
<pre><code>
  preformatted code block
  with preserved whitespace
</code></pre>

<!-- Quotes -->
<blockquote cite="https://example.com">
  Block quote with citation
</blockquote>
<q>Inline quote</q>

<!-- Abbreviation -->
<abbr title="HyperText Markup Language">HTML</abbr>
```

### Lists

```html
<!-- Unordered list -->
<ul>
  <li>Item 1</li>
  <li>Item 2</li>
  <li>Item 3</li>
</ul>

<!-- Ordered list -->
<ol>
  <li>First item</li>
  <li>Second item</li>
  <li>Third item</li>
</ol>

<!-- Ordered list with custom start -->
<ol start="5">
  <li>Fifth item</li>
  <li>Sixth item</li>
</ol>

<!-- Description list -->
<dl>
  <dt>Term 1</dt>
  <dd>Definition 1</dd>
  <dt>Term 2</dt>
  <dd>Definition 2</dd>
</dl>
```

## Links & Media

### Links

```html
<!-- Basic link -->
<a href="https://example.com">Link text</a>

<!-- Link in new tab -->
<a href="https://example.com" target="_blank" rel="noopener noreferrer">
  External link
</a>

<!-- Email link -->
<a href="mailto:email@example.com">Send email</a>

<!-- Phone link -->
<a href="tel:+1234567890">Call us</a>

<!-- Anchor link (same page) -->
<a href="#section-id">Jump to section</a>

<!-- Download link -->
<a href="/files/document.pdf" download>Download PDF</a>
```

### Images

```html
<!-- Basic image -->
<img src="image.jpg" alt="Description of image">

<!-- Responsive image -->
<img
  src="image-small.jpg"
  srcset="image-small.jpg 500w, image-medium.jpg 1000w, image-large.jpg 1500w"
  sizes="(max-width: 600px) 500px, (max-width: 1200px) 1000px, 1500px"
  alt="Description">

<!-- Picture element (art direction) -->
<picture>
  <source media="(min-width: 1200px)" srcset="large.jpg">
  <source media="(min-width: 600px)" srcset="medium.jpg">
  <img src="small.jpg" alt="Description">
</picture>

<!-- Image with figure caption -->
<figure>
  <img src="image.jpg" alt="Description">
  <figcaption>Image caption</figcaption>
</figure>
```

### Video

```html
<!-- Basic video -->
<video src="video.mp4" controls></video>

<!-- Video with multiple sources -->
<video controls width="640" height="360">
  <source src="video.mp4" type="video/mp4">
  <source src="video.webm" type="video/webm">
  Your browser doesn't support video.
</video>

<!-- Video attributes -->
<video
  src="video.mp4"
  controls
  autoplay
  muted
  loop
  poster="thumbnail.jpg">
</video>
```

### Audio

```html
<!-- Basic audio -->
<audio src="audio.mp3" controls></audio>

<!-- Audio with multiple sources -->
<audio controls>
  <source src="audio.mp3" type="audio/mpeg">
  <source src="audio.ogg" type="audio/ogg">
  Your browser doesn't support audio.
</audio>
```

## Forms

### Basic Form

```html
<form action="/submit" method="POST">
  <label for="name">Name:</label>
  <input type="text" id="name" name="name" required>

  <label for="email">Email:</label>
  <input type="email" id="email" name="email" required>

  <button type="submit">Submit</button>
</form>
```

### Input Types

```html
<!-- Text inputs -->
<input type="text" placeholder="Text">
<input type="email" placeholder="email@example.com">
<input type="password" placeholder="Password">
<input type="tel" placeholder="Phone number">
<input type="url" placeholder="https://example.com">
<input type="search" placeholder="Search">

<!-- Number inputs -->
<input type="number" min="0" max="100" step="1">
<input type="range" min="0" max="100" value="50">

<!-- Date and time -->
<input type="date">
<input type="time">
<input type="datetime-local">
<input type="month">
<input type="week">

<!-- Selection -->
<input type="checkbox" id="check" name="check">
<label for="check">Checkbox</label>

<input type="radio" id="option1" name="group" value="1">
<label for="option1">Option 1</label>
<input type="radio" id="option2" name="group" value="2">
<label for="option2">Option 2</label>

<!-- File upload -->
<input type="file" accept="image/*">
<input type="file" multiple>

<!-- Hidden -->
<input type="hidden" name="id" value="123">

<!-- Color picker -->
<input type="color" value="#ff0000">

<!-- Textarea -->
<textarea rows="4" cols="50" placeholder="Enter text"></textarea>

<!-- Select dropdown -->
<select name="country">
  <option value="">Select a country</option>
  <option value="us">United States</option>
  <option value="uk">United Kingdom</option>
  <option value="ca">Canada</option>
</select>

<!-- Multiple select -->
<select name="skills" multiple>
  <option value="html">HTML</option>
  <option value="css">CSS</option>
  <option value="js">JavaScript</option>
</select>

<!-- Datalist (autocomplete) -->
<input list="browsers" name="browser">
<datalist id="browsers">
  <option value="Chrome">
  <option value="Firefox">
  <option value="Safari">
</datalist>
```

### Form Attributes

```html
<!-- Required field -->
<input type="text" required>

<!-- Pattern validation -->
<input type="text" pattern="[A-Za-z]{3,}" title="At least 3 letters">

<!-- Min/max length -->
<input type="text" minlength="3" maxlength="10">

<!-- Disabled -->
<input type="text" disabled>

<!-- Readonly -->
<input type="text" readonly value="Cannot edit">

<!-- Autofocus -->
<input type="text" autofocus>

<!-- Autocomplete -->
<input type="text" autocomplete="name">
<input type="email" autocomplete="email">

<!-- Fieldset (grouping) -->
<fieldset>
  <legend>Personal Information</legend>
  <input type="text" name="name">
  <input type="email" name="email">
</fieldset>
```

## Tables

```html
<!-- Basic table -->
<table>
  <thead>
    <tr>
      <th>Header 1</th>
      <th>Header 2</th>
      <th>Header 3</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Row 1, Col 1</td>
      <td>Row 1, Col 2</td>
      <td>Row 1, Col 3</td>
    </tr>
    <tr>
      <td>Row 2, Col 1</td>
      <td>Row 2, Col 2</td>
      <td>Row 2, Col 3</td>
    </tr>
  </tbody>
  <tfoot>
    <tr>
      <td colspan="3">Footer</td>
    </tr>
  </tfoot>
</table>

<!-- Cell spanning -->
<table>
  <tr>
    <td colspan="2">Spans 2 columns</td>
  </tr>
  <tr>
    <td rowspan="2">Spans 2 rows</td>
    <td>Normal cell</td>
  </tr>
  <tr>
    <td>Normal cell</td>
  </tr>
</table>
```

## Semantic HTML

```html
<!-- Page structure -->
<header>
  <nav>
    <ul>
      <li><a href="/">Home</a></li>
      <li><a href="/about">About</a></li>
    </ul>
  </nav>
</header>

<main>
  <article>
    <header>
      <h1>Article Title</h1>
      <p>By Author Name</p>
      <time datetime="2024-01-15">January 15, 2024</time>
    </header>

    <section>
      <h2>Section Title</h2>
      <p>Section content...</p>
    </section>

    <aside>
      Related information or sidebar
    </aside>
  </article>
</main>

<footer>
  <p>&copy; 2024 Company Name</p>
</footer>
```

## Interactive Elements

```html
<!-- Details/Summary (collapsible) -->
<details>
  <summary>Click to expand</summary>
  <p>Hidden content that appears when expanded</p>
</details>

<!-- Dialog (modal) -->
<dialog id="myDialog">
  <h2>Dialog Title</h2>
  <p>Dialog content</p>
  <button onclick="document.getElementById('myDialog').close()">Close</button>
</dialog>
<button onclick="document.getElementById('myDialog').showModal()">Open Dialog</button>

<!-- Progress bar -->
<progress value="70" max="100">70%</progress>

<!-- Meter -->
<meter value="0.6" min="0" max="1">60%</meter>
```

## Embedded Content

```html
<!-- Iframe -->
<iframe
  src="https://example.com"
  width="600"
  height="400"
  title="Iframe title">
</iframe>

<!-- Embed -->
<embed src="document.pdf" type="application/pdf" width="600" height="400">

<!-- Object -->
<object data="document.pdf" type="application/pdf" width="600" height="400">
  <p>PDF cannot be displayed</p>
</object>
```

## HTML Entities

```html
<!-- Common entities -->
&lt;     <!-- < -->
&gt;     <!-- > -->
&amp;    <!-- & -->
&quot;   <!-- " -->
&apos;   <!-- ' -->
&nbsp;   <!-- non-breaking space -->
&copy;   <!-- © -->
&reg;    <!-- ® -->
&trade;  <!-- ™ -->
&euro;   <!-- € -->
&pound;  <!-- £-->
&yen;    <!-- ¥ -->
```

## Accessibility (ARIA)

```html
<!-- Landmarks -->
<nav role="navigation" aria-label="Main navigation"></nav>
<main role="main"></main>
<aside role="complementary"></aside>

<!-- ARIA attributes -->
<button aria-label="Close dialog">×</button>
<div aria-hidden="true">Decorative content</div>
<input type="text" aria-required="true" aria-invalid="false">
<div role="alert" aria-live="polite">Status message</div>

<!-- Screen reader only text -->
<span class="sr-only">Text only for screen readers</span>

<!-- Skip links -->
<a href="#main-content" class="skip-link">Skip to main content</a>
```
