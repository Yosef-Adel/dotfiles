*colors.txt*  Color Codes Reference

==============================================================================
CONTENTS                                                      *colors-contents*

1. Named CSS Colors ...................... |colors-named|
2. Hex Color Format ...................... |colors-hex|
3. RGB Format ............................ |colors-rgb|
4. HSL Format ............................ |colors-hsl|
5. Common UI Colors ...................... |colors-ui|
6. Material Design ....................... |colors-material|
7. Tailwind Palette ...................... |colors-tailwind|
8. Web Safe Colors ....................... |colors-web-safe|
9. Gradients ............................. |colors-gradients|
10. Opacity/Alpha ........................ |colors-opacity|
11. Color Conversions .................... |colors-conversions|
12. Common Palettes ...................... |colors-palettes|
13. Semantic Colors ...................... |colors-semantic|
14. Terminal Colors ...................... |colors-terminal|
15. Accessibility ........................ |colors-accessibility|

==============================================================================
1. NAMED CSS COLORS                                            *colors-named*

Basic colors~                                           *colors-named-basic*
>
    black       #000000
    white       #FFFFFF
    red         #FF0000
    green       #008000
    blue        #0000FF
    yellow      #FFFF00
    cyan        #00FFFF
    magenta     #FF00FF
<

Grays~                                                  *colors-named-grays*
>
    gray        #808080
    silver      #C0C0C0
    darkgray    #A9A9A9
    lightgray   #D3D3D3
<

Extended colors~                                     *colors-named-extended*
>
    maroon      #800000
    olive       #808000
    lime        #00FF00
    aqua        #00FFFF
    teal        #008080
    navy        #000080
    purple      #800080
    fuchsia     #FF00FF
<

==============================================================================
2. HEX COLOR FORMAT                                              *colors-hex*

Format~                                                   *colors-hex-format*
>
    #RRGGBB
    #RGB (shorthand)

    #FF0000  Red
    #00FF00  Green
    #0000FF  Blue

    #F00     Red (shorthand)
    #0F0     Green (shorthand)
    #00F     Blue (shorthand)
<

With alpha~                                               *colors-hex-alpha*
>
    #RRGGBBAA (with alpha)

    #FF0000FF  Red, fully opaque
    #FF000080  Red, 50% transparent
<

==============================================================================
3. RGB FORMAT                                                    *colors-rgb*

Syntax~                                                   *colors-rgb-syntax*
>
    rgb(red, green, blue)
    rgba(red, green, blue, alpha)

    /* Values: 0-255 */
    rgb(255, 0, 0)        Red
    rgb(0, 255, 0)        Green
    rgb(0, 0, 255)        Blue
    rgb(128, 128, 128)    Gray
<

With alpha~                                               *colors-rgb-alpha*
>
    /* Alpha: 0.0-1.0 */
    rgba(255, 0, 0, 1.0)    Red, opaque
    rgba(255, 0, 0, 0.5)    Red, 50% transparent
    rgba(0, 0, 0, 0.5)      Black, 50% transparent
<

==============================================================================
4. HSL FORMAT                                                    *colors-hsl*

Syntax~                                                   *colors-hsl-syntax*
>
    hsl(hue, saturation%, lightness%)
    hsla(hue, saturation%, lightness%, alpha)
<

Hue values~                                                 *colors-hsl-hue*
>
    /* Hue: 0-360 degrees */
    hsl(0, 100%, 50%)      Red
    hsl(120, 100%, 50%)    Green
    hsl(240, 100%, 50%)    Blue
<

Saturation~                                          *colors-hsl-saturation*
>
    /* Saturation: 0-100% */
    hsl(0, 0%, 50%)        Gray
    hsl(0, 50%, 50%)       Desaturated red
    hsl(0, 100%, 50%)      Pure red
<

Lightness~                                            *colors-hsl-lightness*
>
    /* Lightness: 0-100% */
    hsl(0, 100%, 0%)       Black
    hsl(0, 100%, 50%)      Red
    hsl(0, 100%, 100%)     White
<

With alpha~                                               *colors-hsl-alpha*
>
    /* With alpha */
    hsla(0, 100%, 50%, 0.5)  Red, 50% transparent
<

==============================================================================
5. COMMON UI COLORS                                               *colors-ui*

Common UI color scheme~                                      *colors-ui-common*
>
    Primary Blue:       #007BFF
    Success Green:      #28A745
    Warning Yellow:     #FFC107
    Danger Red:         #DC3545
    Info Blue:          #17A2B8

    Dark Background:    #212529
    Light Background:   #F8F9FA
<

==============================================================================
6. MATERIAL DESIGN                                          *colors-material*

Material Design palette~                             *colors-material-palette*
>
    Red:          #F44336
    Pink:         #E91E63
    Purple:       #9C27B0
    Deep Purple:  #673AB7
    Indigo:       #3F51B5
    Blue:         #2196F3
    Light Blue:   #03A9F4
    Cyan:         #00BCD4
    Teal:         #009688
    Green:        #4CAF50
    Light Green:  #8BC34A
    Lime:         #CDDC39
    Yellow:       #FFEB3B
    Amber:        #FFC107
    Orange:       #FF9800
    Deep Orange:  #FF5722
    Brown:        #795548
    Grey:         #9E9E9E
    Blue Grey:    #607D8B
<

==============================================================================
7. TAILWIND PALETTE                                          *colors-tailwind*

Gray scale~                                          *colors-tailwind-gray*
>
    Gray:
      50:  #F9FAFB
      100: #F3F4F6
      200: #E5E7EB
      300: #D1D5DB
      400: #9CA3AF
      500: #6B7280
      600: #4B5563
      700: #374151
      800: #1F2937
      900: #111827
<

Primary colors~                                     *colors-tailwind-primary*
>
    Red:
      500: #EF4444
      600: #DC2626

    Green:
      500: #10B981
      600: #059669

    Blue:
      500: #3B82F6
      600: #2563EB

    Yellow:
      500: #F59E0B
      600: #D97706

    Purple:
      500: #8B5CF6
      600: #7C3AED

    Pink:
      500: #EC4899
      600: #DB2777
<

==============================================================================
8. WEB SAFE COLORS                                          *colors-web-safe*

Web safe colors~                                      *colors-web-safe-info*
>
    216 web-safe colors (combinations of 00, 33, 66, 99, CC, FF)

    #000000  #000033  #000066  #000099  #0000CC  #0000FF
    #003300  #003333  #003366  #003399  #0033CC  #0033FF
    ...
    #FFFFFF
<

==============================================================================
9. GRADIENTS                                                *colors-gradients*

Linear gradients~                                   *colors-gradients-linear*
>
    /* Linear gradient */
    background: linear-gradient(to right, #ff0000, #00ff00);
    background: linear-gradient(45deg, #ff0000, #00ff00);
    background: linear-gradient(to bottom, #ff0000, #ffff00, #00ff00);
<

Radial gradients~                                   *colors-gradients-radial*
>
    /* Radial gradient */
    background: radial-gradient(circle, #ff0000, #0000ff);
<

Multiple stops~                                      *colors-gradients-stops*
>
    /* Multiple stops */
    background: linear-gradient(
      to right,
      #ff0000 0%,
      #ffff00 50%,
      #00ff00 100%
    );
<

==============================================================================
10. OPACITY/ALPHA                                            *colors-opacity*

Hex with alpha~                                       *colors-opacity-hex*
>
    #FF0000FF  100% opaque
    #FF0000CC  80% opaque
    #FF000099  60% opaque
    #FF000066  40% opaque
    #FF000033  20% opaque
    #FF000000  Fully transparent
<

RGBA~                                                    *colors-opacity-rgba*
>
    rgba(255, 0, 0, 1.0)   100%
    rgba(255, 0, 0, 0.8)   80%
    rgba(255, 0, 0, 0.6)   60%
    rgba(255, 0, 0, 0.4)   40%
    rgba(255, 0, 0, 0.2)   20%
    rgba(255, 0, 0, 0.0)   0%
<

Separate opacity property~                        *colors-opacity-property*
>
    color: #FF0000;
    opacity: 0.5;
<

==============================================================================
11. COLOR CONVERSIONS                                    *colors-conversions*

Hex to RGB~                                         *colors-conversions-hex*
>
    // Hex to RGB
    function hexToRgb(hex) {
      const r = parseInt(hex.slice(1, 3), 16);
      const g = parseInt(hex.slice(3, 5), 16);
      const b = parseInt(hex.slice(5, 7), 16);
      return { r, g, b };
    }
<

RGB to Hex~                                         *colors-conversions-rgb*
>
    // RGB to Hex
    function rgbToHex(r, g, b) {
      return '#' + [r, g, b].map(x => {
        const hex = x.toString(16);
        return hex.length === 1 ? '0' + hex : hex;
      }).join('');
    }
<

RGB to HSL~                                         *colors-conversions-hsl*
>
    // RGB to HSL
    function rgbToHsl(r, g, b) {
      r /= 255;
      g /= 255;
      b /= 255;
      const max = Math.max(r, g, b);
      const min = Math.min(r, g, b);
      let h, s, l = (max + min) / 2;

      if (max === min) {
        h = s = 0;
      } else {
        const d = max - min;
        s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
        switch (max) {
          case r: h = (g - b) / d + (g < b ? 6 : 0); break;
          case g: h = (b - r) / d + 2; break;
          case b: h = (r - g) / d + 4; break;
        }
        h /= 6;
      }

      return {
        h: Math.round(h * 360),
        s: Math.round(s * 100),
        l: Math.round(l * 100)
      };
    }
<

==============================================================================
12. COMMON PALETTES                                          *colors-palettes*

Palette types~                                        *colors-palettes-types*
>
    Monochromatic:
        Shades of single color

    Complementary:
        Opposite on color wheel (Red/Green, Blue/Orange)

    Analogous:
        Adjacent on color wheel (Red/Orange/Yellow)

    Triadic:
        Evenly spaced (Red/Yellow/Blue)

    Split-Complementary:
        Base + two adjacent to complement
<

==============================================================================
13. SEMANTIC COLORS                                          *colors-semantic*

Semantic color scheme~                              *colors-semantic-scheme*
>
    Primary:    Brand color
    Secondary:  Supporting brand color
    Success:    #28A745 (green)
    Info:       #17A2B8 (blue)
    Warning:    #FFC107 (yellow/orange)
    Danger:     #DC3545 (red)
    Light:      #F8F9FA
    Dark:       #343A40
    Muted:      #6C757D
<

==============================================================================
14. TERMINAL COLORS                                          *colors-terminal*

ANSI color codes~                                     *colors-terminal-ansi*
>
    Black:      0;30    1;30 (bright)
    Red:        0;31    1;31
    Green:      0;32    1;32
    Yellow:     0;33    1;33
    Blue:       0;34    1;34
    Magenta:    0;35    1;35
    Cyan:       0;36    1;36
    White:      0;37    1;37

    Background: Add 10 to code (40-47)
<

Bash examples~                                        *colors-terminal-bash*
>
    # Bash colors
    echo -e "\033[31mRed text\033[0m"
    echo -e "\033[1;31mBright red\033[0m"
    echo -e "\033[42mGreen background\033[0m"
<

==============================================================================
15. ACCESSIBILITY                                        *colors-accessibility*

WCAG contrast ratios~                          *colors-accessibility-wcag*
>
    WCAG AA Contrast Ratios:
    Normal text: 4.5:1
    Large text:  3:1

    WCAG AAA Contrast Ratios:
    Normal text: 7:1
    Large text:  4.5:1
<

Good combinations~                         *colors-accessibility-combinations*
>
    - Black (#000000) on White (#FFFFFF): 21:1
    - Blue (#0000FF) on White (#FFFFFF): 8.59:1
    - Gray (#767676) on White (#FFFFFF): 4.54:1 (AA)
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
