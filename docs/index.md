---
layout: home

hero:
  name: FACE
  text: Fortran Ansi Colors and Styles Environment
  image:
    light: /logo.svg
    dark: /logo-dark.svg
    alt: FACE, the code column of colors_samples stamped as a column of seals
  tagline: A KISS pure Fortran library for easy colorizing and stylizing strings.
  actions:
    - theme: brand
      text: Guide
      link: /guide/
    - theme: alt
      text: API Reference
      link: /api/
    - theme: alt
      text: View on GitHub
      link: https://github.com/szaghi/FACE

features:
  - icon:
      light: /icons/colorize.svg
      dark: /icons/colorize-dark.svg
      width: 48
      height: 48
    title: Simple API
    details: "One function, colorize(string, color_fg, color_bg, style), covers everything."
    link: /guide/usage
    linkText: Usage
  - icon:
      light: /icons/foreground.svg
      dark: /icons/foreground-dark.svg
      width: 48
      height: 48
    title: Foreground colors
    details: "Named colors and their intense variants, or 24-bit RGB as #rrggbb, for the text itself."
  - icon:
      light: /icons/background.svg
      dark: /icons/background-dark.svg
      width: 48
      height: 48
    title: Background colors
    details: "The same names and RGB values, laid behind the text."
  - icon:
      light: /icons/styles.svg
      dark: /icons/styles-dark.svg
      width: 48
      height: 48
    title: Text styles
    details: "Bold, italics, underline, inverse, strikethrough, framed, encircled and overlined, each with its _off."
  - icon:
      light: /icons/ansi-codes.svg
      dark: /icons/ansi-codes-dark.svg
      width: 48
      height: 48
    title: Plain ANSI codes
    details: "Every color and style is a standard ANSI SGR sequence: 30–39 and 90–97 for the text, 40–49 and 100–107 behind it, 38;2 and 48;2 for #rrggbb."
  - icon:
      light: /icons/samples.svg
      dark: /icons/samples-dark.svg
      width: 48
      height: 48
    title: Samples included
    details: "call colors_samples and call styles_samples print every color and style with its code."
    link: /guide/features
    linkText: Features
  - icon:
      light: /icons/pure-fortran.svg
      dark: /icons/pure-fortran-dark.svg
      width: 48
      height: 48
    title: Pure Fortran
    details: "Fortran 2008+ standard compliant. No external dependencies."
    link: /guide/install
    linkText: Installation
  - icon:
      light: /icons/multi-licensed.svg
      dark: /icons/multi-licensed-dark.svg
      width: 48
      height: 48
    title: Free & Open Source
    details: "Multi-licensed: GPLv3 for FOSS projects, BSD 2/3-Clause or MIT for commercial use. Any contributor is welcome."
    link: /guide/contributing
    linkText: Contributing
---

## Quick start

```fortran
use face
character(len=:), allocatable :: error_message

error_message = colorize('error:', color_fg='red', style='underline_on')//' file not found!'

print '(A)', error_message
print '(A)', colorize('suggestion: check your configuration', color_fg='blue')

call colors_samples ! print samples of all colors available
call styles_samples ! print samples of all styles available
```

## Authors

- Stefano Zaghi — [@szaghi](https://github.com/szaghi)

Contributions are welcome — see the [Contributing](/guide/contributing) page.

## Copyrights

FACE is distributed under a multi-licensing system:

- **FOSS projects**: [GPL v3](http://www.gnu.org/licenses/gpl-3.0.html)
- **Closed source / commercial**: [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause), [BSD 3-Clause](http://opensource.org/licenses/BSD-3-Clause), or [MIT](http://opensource.org/licenses/MIT)

Anyone interested in using, developing, or contributing to FACE is welcome — pick the license that best fits your needs.
