*html.txt*  HTML Reference

==============================================================================
CONTENTS                                                        *html-contents*

1. Document Structure .................... |html-document|
2. Meta Tags ............................. |html-meta|
3. Text Content .......................... |html-text|
   3.1 Headings .......................... |html-headings|
   3.2 Paragraphs & Text ................. |html-paragraphs|
   3.3 Lists ............................. |html-lists|
4. Links & Media ......................... |html-links-media|
   4.1 Links ............................. |html-links|
   4.2 Images ............................ |html-images|
   4.3 Video ............................. |html-video|
   4.4 Audio ............................. |html-audio|
5. Forms ................................. |html-forms|
   5.1 Basic Form ........................ |html-basic-form|
   5.2 Input Types ....................... |html-input-types|
   5.3 Form Attributes ................... |html-form-attributes|
6. Tables ................................ |html-tables|
7. Semantic HTML ......................... |html-semantic|
8. Interactive Elements .................. |html-interactive|
9. Embedded Content ...................... |html-embedded|
10. HTML Entities ........................ |html-entities|
11. Accessibility (ARIA) ................. |html-aria|

==============================================================================
1. DOCUMENT STRUCTURE                                          *html-document*

Basic HTML5 document template~
>
    &lt;!DOCTYPE html&gt;
    &lt;html lang="en"&gt;
    &lt;head&gt;
      &lt;meta charset="UTF-8"&gt;
      &lt;meta name="viewport" content="width=device-width, initial-scale=1.0"&gt;
      &lt;title&gt;Page Title&lt;/title&gt;
      &lt;link rel="stylesheet" href="styles.css"&gt;
    &lt;/head&gt;
    &lt;body&gt;
      &lt;!-- Content goes here --&gt;
      &lt;script src="script.js"&gt;&lt;/script&gt;
    &lt;/body&gt;
    &lt;/html&gt;
<

Note: Always declare &lt;!DOCTYPE html&gt; for HTML5.
The lang attribute on &lt;html&gt; helps accessibility tools and search engines.

==============================================================================
2. META TAGS                                                       *html-meta*

Character Encoding & Viewport~                        *html-meta-basic*
>
    &lt;meta charset="UTF-8"&gt;
    &lt;meta name="viewport" content="width=device-width, initial-scale=1.0"&gt;
<

SEO Meta Tags~                                              *html-meta-seo*
>
    &lt;meta name="description" content="Page description for search engines"&gt;
    &lt;meta name="keywords" content="keyword1, keyword2, keyword3"&gt;
    &lt;meta name="author" content="Author Name"&gt;
<

Open Graph (Social Media)~                           *html-meta-opengraph*
>
    &lt;meta property="og:title" content="Page Title"&gt;
    &lt;meta property="og:description" content="Page description"&gt;
    &lt;meta property="og:image" content="https://example.com/image.jpg"&gt;
    &lt;meta property="og:url" content="https://example.com"&gt;
<

Twitter Card~                                          *html-meta-twitter*
>
    &lt;meta name="twitter:card" content="summary_large_image"&gt;
    &lt;meta name="twitter:title" content="Page Title"&gt;
    &lt;meta name="twitter:description" content="Page description"&gt;
    &lt;meta name="twitter:image" content="https://example.com/image.jpg"&gt;
<

Favicon~                                               *html-meta-favicon*
>
    &lt;link rel="icon" href="/favicon.ico"&gt;
    &lt;link rel="apple-touch-icon" href="/apple-touch-icon.png"&gt;
<

==============================================================================
3. TEXT CONTENT                                                   *html-text*

------------------------------------------------------------------------------
3.1 HEADINGS                                                  *html-headings*

HTML provides six levels of headings (h1-h6)~
>
    &lt;h1&gt;Main Heading&lt;/h1&gt;
    &lt;h2&gt;Section Heading&lt;/h2&gt;
    &lt;h3&gt;Subsection Heading&lt;/h3&gt;
    &lt;h4&gt;Minor Heading&lt;/h4&gt;
    &lt;h5&gt;Small Heading&lt;/h5&gt;
    &lt;h6&gt;Smallest Heading&lt;/h6&gt;
<

Note: Use only one &lt;h1&gt; per page for proper SEO and accessibility.

------------------------------------------------------------------------------
3.2 PARAGRAPHS & TEXT                                       *html-paragraphs*

Paragraphs and Line Breaks~                        *html-paragraph-basic*
>
    &lt;p&gt;This is a paragraph of text.&lt;/p&gt;

    &lt;p&gt;Line 1&lt;br&gt;Line 2&lt;/p&gt;

    &lt;hr&gt;  &lt;!-- Horizontal rule --&gt;
<

Text Formatting~                                       *html-text-format*
>
    &lt;strong&gt;Bold text (important)&lt;/strong&gt;
    &lt;b&gt;Bold text (stylistic)&lt;/b&gt;
    &lt;em&gt;Italic text (emphasis)&lt;/em&gt;
    &lt;i&gt;Italic text (stylistic)&lt;/i&gt;
    &lt;mark&gt;Highlighted text&lt;/mark&gt;
    &lt;small&gt;Small text&lt;/small&gt;
    &lt;del&gt;Deleted text&lt;/del&gt;
    &lt;ins&gt;Inserted text&lt;/ins&gt;
    &lt;sub&gt;Subscript&lt;/sub&gt;
    &lt;sup&gt;Superscript&lt;/sup&gt;
<

Note: Prefer semantic tags (&lt;strong&gt;, &lt;em&gt;) over stylistic (&lt;b&gt;, &lt;i&gt;).

Code Elements~                                            *html-text-code*
>
    &lt;code&gt;inline code&lt;/code&gt;

    &lt;pre&gt;&lt;code&gt;
      preformatted code block
      with preserved whitespace
    &lt;/code&gt;&lt;/pre&gt;
<

Quotes~                                                  *html-text-quotes*
>
    &lt;blockquote cite="https://example.com"&gt;
      Block quote with citation
    &lt;/blockquote&gt;

    &lt;q&gt;Inline quote&lt;/q&gt;
<

Abbreviation~                                             *html-text-abbr*
>
    &lt;abbr title="HyperText Markup Language"&gt;HTML&lt;/abbr&gt;
<

------------------------------------------------------------------------------
3.3 LISTS                                                       *html-lists*

Unordered List~                                        *html-list-unordered*
>
    &lt;ul&gt;
      &lt;li&gt;Item 1&lt;/li&gt;
      &lt;li&gt;Item 2&lt;/li&gt;
      &lt;li&gt;Item 3&lt;/li&gt;
    &lt;/ul&gt;
<

Ordered List~                                            *html-list-ordered*
>
    &lt;ol&gt;
      &lt;li&gt;First item&lt;/li&gt;
      &lt;li&gt;Second item&lt;/li&gt;
      &lt;li&gt;Third item&lt;/li&gt;
    &lt;/ol&gt;

    &lt;!-- Custom start number --&gt;
    &lt;ol start="5"&gt;
      &lt;li&gt;Fifth item&lt;/li&gt;
      &lt;li&gt;Sixth item&lt;/li&gt;
    &lt;/ol&gt;
<

Description List~                                   *html-list-description*
>
    &lt;dl&gt;
      &lt;dt&gt;Term 1&lt;/dt&gt;
      &lt;dd&gt;Definition 1&lt;/dd&gt;
      &lt;dt&gt;Term 2&lt;/dt&gt;
      &lt;dd&gt;Definition 2&lt;/dd&gt;
    &lt;/dl&gt;
<

==============================================================================
4. LINKS & MEDIA                                            *html-links-media*

------------------------------------------------------------------------------
4.1 LINKS                                                       *html-links*

Basic Links~                                            *html-links-basic*
>
    &lt;a href="https://example.com"&gt;Link text&lt;/a&gt;

    &lt;!-- Link in new tab --&gt;
    &lt;a href="https://example.com" target="_blank" rel="noopener noreferrer"&gt;
      External link
    &lt;/a&gt;
<

Note: Always use rel="noopener noreferrer" with target="_blank" for security.

Special Links~                                        *html-links-special*
>
    &lt;!-- Email link --&gt;
    &lt;a href="mailto:email@example.com"&gt;Send email&lt;/a&gt;

    &lt;!-- Phone link --&gt;
    &lt;a href="tel:+1234567890"&gt;Call us&lt;/a&gt;

    &lt;!-- Anchor link (same page) --&gt;
    &lt;a href="#section-id"&gt;Jump to section&lt;/a&gt;

    &lt;!-- Download link --&gt;
    &lt;a href="/files/document.pdf" download&gt;Download PDF&lt;/a&gt;
<

------------------------------------------------------------------------------
4.2 IMAGES                                                     *html-images*

Basic Image~                                           *html-images-basic*
>
    &lt;img src="image.jpg" alt="Description of image"&gt;
<

Note: The alt attribute is required for accessibility.

Responsive Images~                                *html-images-responsive*
>
    &lt;img
      src="image-small.jpg"
      srcset="image-small.jpg 500w,
              image-medium.jpg 1000w,
              image-large.jpg 1500w"
      sizes="(max-width: 600px) 500px,
             (max-width: 1200px) 1000px,
             1500px"
      alt="Description"&gt;
<

Picture Element (Art Direction)~                   *html-images-picture*
>
    &lt;picture&gt;
      &lt;source media="(min-width: 1200px)" srcset="large.jpg"&gt;
      &lt;source media="(min-width: 600px)" srcset="medium.jpg"&gt;
      &lt;img src="small.jpg" alt="Description"&gt;
    &lt;/picture&gt;
<

Image with Caption~                                 *html-images-caption*
>
    &lt;figure&gt;
      &lt;img src="image.jpg" alt="Description"&gt;
      &lt;figcaption&gt;Image caption&lt;/figcaption&gt;
    &lt;/figure&gt;
<

------------------------------------------------------------------------------
4.3 VIDEO                                                       *html-video*

Basic Video~                                            *html-video-basic*
>
    &lt;video src="video.mp4" controls&gt;&lt;/video&gt;
<

Video with Multiple Sources~                        *html-video-sources*
>
    &lt;video controls width="640" height="360"&gt;
      &lt;source src="video.mp4" type="video/mp4"&gt;
      &lt;source src="video.webm" type="video/webm"&gt;
      Your browser doesn't support video.
    &lt;/video&gt;
<

Video Attributes~                                 *html-video-attributes*
>
    &lt;video
      src="video.mp4"
      controls
      autoplay
      muted
      loop
      poster="thumbnail.jpg"&gt;
    &lt;/video&gt;
<

Attributes:
  controls      Show playback controls
  autoplay      Start automatically (requires muted)
  muted         Mute audio
  loop          Repeat playback
  poster        Thumbnail image before play

------------------------------------------------------------------------------
4.4 AUDIO                                                       *html-audio*

Basic Audio~                                            *html-audio-basic*
>
    &lt;audio src="audio.mp3" controls&gt;&lt;/audio&gt;
<

Audio with Multiple Sources~                        *html-audio-sources*
>
    &lt;audio controls&gt;
      &lt;source src="audio.mp3" type="audio/mpeg"&gt;
      &lt;source src="audio.ogg" type="audio/ogg"&gt;
      Your browser doesn't support audio.
    &lt;/audio&gt;
<

==============================================================================
5. FORMS                                                          *html-forms*

------------------------------------------------------------------------------
5.1 BASIC FORM                                              *html-basic-form*

Simple form structure~
>
    &lt;form action="/submit" method="POST"&gt;
      &lt;label for="name"&gt;Name:&lt;/label&gt;
      &lt;input type="text" id="name" name="name" required&gt;

      &lt;label for="email"&gt;Email:&lt;/label&gt;
      &lt;input type="email" id="email" name="email" required&gt;

      &lt;button type="submit"&gt;Submit&lt;/button&gt;
    &lt;/form&gt;
<

Note: Always associate labels with inputs using for/id attributes.

------------------------------------------------------------------------------
5.2 INPUT TYPES                                           *html-input-types*

Text Inputs~                                          *html-input-text*
>
    &lt;input type="text" placeholder="Text"&gt;
    &lt;input type="email" placeholder="email@example.com"&gt;
    &lt;input type="password" placeholder="Password"&gt;
    &lt;input type="tel" placeholder="Phone number"&gt;
    &lt;input type="url" placeholder="https://example.com"&gt;
    &lt;input type="search" placeholder="Search"&gt;
<

Number Inputs~                                      *html-input-number*
>
    &lt;input type="number" min="0" max="100" step="1"&gt;
    &lt;input type="range" min="0" max="100" value="50"&gt;
<

Date and Time~                                      *html-input-datetime*
>
    &lt;input type="date"&gt;
    &lt;input type="time"&gt;
    &lt;input type="datetime-local"&gt;
    &lt;input type="month"&gt;
    &lt;input type="week"&gt;
<

Selection Inputs~                                *html-input-selection*
>
    &lt;input type="checkbox" id="check" name="check"&gt;
    &lt;label for="check"&gt;Checkbox&lt;/label&gt;

    &lt;input type="radio" id="option1" name="group" value="1"&gt;
    &lt;label for="option1"&gt;Option 1&lt;/label&gt;
    &lt;input type="radio" id="option2" name="group" value="2"&gt;
    &lt;label for="option2"&gt;Option 2&lt;/label&gt;
<

Note: Radio buttons with the same name form a mutually exclusive group.

File Upload~                                          *html-input-file*
>
    &lt;input type="file" accept="image/*"&gt;
    &lt;input type="file" multiple&gt;
<

Other Input Types~                                   *html-input-other*
>
    &lt;input type="hidden" name="id" value="123"&gt;
    &lt;input type="color" value="#ff0000"&gt;
<

Textarea~                                              *html-textarea*
>
    &lt;textarea rows="4" cols="50" placeholder="Enter text"&gt;&lt;/textarea&gt;
<

Select Dropdown~                                         *html-select*
>
    &lt;select name="country"&gt;
      &lt;option value=""&gt;Select a country&lt;/option&gt;
      &lt;option value="us"&gt;United States&lt;/option&gt;
      &lt;option value="uk"&gt;United Kingdom&lt;/option&gt;
      &lt;option value="ca"&gt;Canada&lt;/option&gt;
    &lt;/select&gt;

    &lt;!-- Multiple select --&gt;
    &lt;select name="skills" multiple&gt;
      &lt;option value="html"&gt;HTML&lt;/option&gt;
      &lt;option value="css"&gt;CSS&lt;/option&gt;
      &lt;option value="js"&gt;JavaScript&lt;/option&gt;
    &lt;/select&gt;
<

Datalist (Autocomplete)~                                *html-datalist*
>
    &lt;input list="browsers" name="browser"&gt;
    &lt;datalist id="browsers"&gt;
      &lt;option value="Chrome"&gt;
      &lt;option value="Firefox"&gt;
      &lt;option value="Safari"&gt;
    &lt;/datalist&gt;
<

------------------------------------------------------------------------------
5.3 FORM ATTRIBUTES                                   *html-form-attributes*

Validation Attributes~                           *html-form-validation*
>
    &lt;!-- Required field --&gt;
    &lt;input type="text" required&gt;

    &lt;!-- Pattern validation --&gt;
    &lt;input type="text" pattern="[A-Za-z]{3,}" title="At least 3 letters"&gt;

    &lt;!-- Min/max length --&gt;
    &lt;input type="text" minlength="3" maxlength="10"&gt;
<

State Attributes~                                   *html-form-state*
>
    &lt;input type="text" disabled&gt;
    &lt;input type="text" readonly value="Cannot edit"&gt;
    &lt;input type="text" autofocus&gt;
<

Autocomplete~                                    *html-form-autocomplete*
>
    &lt;input type="text" autocomplete="name"&gt;
    &lt;input type="email" autocomplete="email"&gt;
<

Fieldset (Grouping)~                                *html-fieldset*
>
    &lt;fieldset&gt;
      &lt;legend&gt;Personal Information&lt;/legend&gt;
      &lt;input type="text" name="name"&gt;
      &lt;input type="email" name="email"&gt;
    &lt;/fieldset&gt;
<

==============================================================================
6. TABLES                                                       *html-tables*

Basic Table Structure~                                *html-tables-basic*
>
    &lt;table&gt;
      &lt;thead&gt;
        &lt;tr&gt;
          &lt;th&gt;Header 1&lt;/th&gt;
          &lt;th&gt;Header 2&lt;/th&gt;
          &lt;th&gt;Header 3&lt;/th&gt;
        &lt;/tr&gt;
      &lt;/thead&gt;
      &lt;tbody&gt;
        &lt;tr&gt;
          &lt;td&gt;Row 1, Col 1&lt;/td&gt;
          &lt;td&gt;Row 1, Col 2&lt;/td&gt;
          &lt;td&gt;Row 1, Col 3&lt;/td&gt;
        &lt;/tr&gt;
        &lt;tr&gt;
          &lt;td&gt;Row 2, Col 1&lt;/td&gt;
          &lt;td&gt;Row 2, Col 2&lt;/td&gt;
          &lt;td&gt;Row 2, Col 3&lt;/td&gt;
        &lt;/tr&gt;
      &lt;/tbody&gt;
      &lt;tfoot&gt;
        &lt;tr&gt;
          &lt;td colspan="3"&gt;Footer&lt;/td&gt;
        &lt;/tr&gt;
      &lt;/tfoot&gt;
    &lt;/table&gt;
<

Cell Spanning~                                      *html-tables-spanning*
>
    &lt;table&gt;
      &lt;tr&gt;
        &lt;td colspan="2"&gt;Spans 2 columns&lt;/td&gt;
      &lt;/tr&gt;
      &lt;tr&gt;
        &lt;td rowspan="2"&gt;Spans 2 rows&lt;/td&gt;
        &lt;td&gt;Normal cell&lt;/td&gt;
      &lt;/tr&gt;
      &lt;tr&gt;
        &lt;td&gt;Normal cell&lt;/td&gt;
      &lt;/tr&gt;
    &lt;/table&gt;
<

==============================================================================
7. SEMANTIC HTML                                              *html-semantic*

Page Structure~                                     *html-semantic-page*
>
    &lt;header&gt;
      &lt;nav&gt;
        &lt;ul&gt;
          &lt;li&gt;&lt;a href="/"&gt;Home&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href="/about"&gt;About&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
      &lt;/nav&gt;
    &lt;/header&gt;

    &lt;main&gt;
      &lt;article&gt;
        &lt;header&gt;
          &lt;h1&gt;Article Title&lt;/h1&gt;
          &lt;p&gt;By Author Name&lt;/p&gt;
          &lt;time datetime="2024-01-15"&gt;January 15, 2024&lt;/time&gt;
        &lt;/header&gt;

        &lt;section&gt;
          &lt;h2&gt;Section Title&lt;/h2&gt;
          &lt;p&gt;Section content...&lt;/p&gt;
        &lt;/section&gt;

        &lt;aside&gt;
          Related information or sidebar
        &lt;/aside&gt;
      &lt;/article&gt;
    &lt;/main&gt;

    &lt;footer&gt;
      &lt;p&gt;&amp;copy; 2024 Company Name&lt;/p&gt;
    &lt;/footer&gt;
<

Semantic Elements:                                  *html-semantic-elements*
  &lt;header&gt;     Page or section header
  &lt;nav&gt;        Navigation links
  &lt;main&gt;       Main content (one per page)
  &lt;article&gt;    Self-contained content
  &lt;section&gt;    Thematic grouping
  &lt;aside&gt;      Tangential content
  &lt;footer&gt;     Page or section footer
  &lt;time&gt;       Date/time with datetime attribute

==============================================================================
8. INTERACTIVE ELEMENTS                                   *html-interactive*

Details/Summary (Collapsible)~                        *html-details*
>
    &lt;details&gt;
      &lt;summary&gt;Click to expand&lt;/summary&gt;
      &lt;p&gt;Hidden content that appears when expanded&lt;/p&gt;
    &lt;/details&gt;
<

Dialog (Modal)~                                           *html-dialog*
>
    &lt;dialog id="myDialog"&gt;
      &lt;h2&gt;Dialog Title&lt;/h2&gt;
      &lt;p&gt;Dialog content&lt;/p&gt;
      &lt;button onclick="document.getElementById('myDialog').close()"&gt;
        Close
      &lt;/button&gt;
    &lt;/dialog&gt;

    &lt;button onclick="document.getElementById('myDialog').showModal()"&gt;
      Open Dialog
    &lt;/button&gt;
<

Progress Bar~                                            *html-progress*
>
    &lt;progress value="70" max="100"&gt;70%&lt;/progress&gt;
<

Meter~                                                      *html-meter*
>
    &lt;meter value="0.6" min="0" max="1"&gt;60%&lt;/meter&gt;
<

Note: Use &lt;progress&gt; for tasks in progress, &lt;meter&gt; for measurements.

==============================================================================
9. EMBEDDED CONTENT                                          *html-embedded*

Iframe~                                                    *html-iframe*
>
    &lt;iframe
      src="https://example.com"
      width="600"
      height="400"
      title="Iframe title"&gt;
    &lt;/iframe&gt;
<

Note: Always include a title attribute for accessibility.

Embed~                                                      *html-embed*
>
    &lt;embed
      src="document.pdf"
      type="application/pdf"
      width="600"
      height="400"&gt;
<

Object~                                                    *html-object*
>
    &lt;object
      data="document.pdf"
      type="application/pdf"
      width="600"
      height="400"&gt;
      &lt;p&gt;PDF cannot be displayed&lt;/p&gt;
    &lt;/object&gt;
<

==============================================================================
10. HTML ENTITIES                                            *html-entities*

Common Entities~                                    *html-entities-common*
>
    &amp;lt;      &lt;!-- &lt; --&gt;
    &amp;gt;      &lt;!-- &gt; --&gt;
    &amp;amp;     &lt;!-- &amp; --&gt;
    &amp;quot;    &lt;!-- " --&gt;
    &amp;apos;    &lt;!-- ' --&gt;
    &amp;nbsp;    &lt;!-- non-breaking space --&gt;
<

Special Characters~                               *html-entities-special*
>
    &amp;copy;    &lt;!-- © --&gt;
    &amp;reg;     &lt;!-- ® --&gt;
    &amp;trade;   &lt;!-- ™ --&gt;
    &amp;euro;    &lt;!-- € --&gt;
    &amp;pound;   &lt;!-- £ --&gt;
    &amp;yen;     &lt;!-- ¥ --&gt;
<

==============================================================================
11. ACCESSIBILITY (ARIA)                                         *html-aria*

Landmarks~                                              *html-aria-landmarks*
>
    &lt;nav role="navigation" aria-label="Main navigation"&gt;&lt;/nav&gt;
    &lt;main role="main"&gt;&lt;/main&gt;
    &lt;aside role="complementary"&gt;&lt;/aside&gt;
<

ARIA Attributes~                                      *html-aria-attributes*
>
    &lt;button aria-label="Close dialog"&gt;×&lt;/button&gt;
    &lt;div aria-hidden="true"&gt;Decorative content&lt;/div&gt;
    &lt;input type="text" aria-required="true" aria-invalid="false"&gt;
    &lt;div role="alert" aria-live="polite"&gt;Status message&lt;/div&gt;
<

Common ARIA Attributes:                               *html-aria-common*
  aria-label           Accessible name for element
  aria-hidden          Hide element from screen readers
  aria-required        Mark field as required
  aria-invalid         Mark field as having validation error
  aria-live            Announce dynamic content changes
  aria-expanded        Collapsible element state
  aria-pressed         Toggle button state

Screen Reader Only Text~                                 *html-aria-sr-only*
>
    &lt;span class="sr-only"&gt;Text only for screen readers&lt;/span&gt;
<

CSS for sr-only class:
>
    .sr-only {
      position: absolute;
      width: 1px;
      height: 1px;
      padding: 0;
      margin: -1px;
      overflow: hidden;
      clip: rect(0, 0, 0, 0);
      white-space: nowrap;
      border-width: 0;
    }
<

Skip Links~                                             *html-aria-skip*
>
    &lt;a href="#main-content" class="skip-link"&gt;Skip to main content&lt;/a&gt;
<

Note: Skip links help keyboard users navigate directly to main content.

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
