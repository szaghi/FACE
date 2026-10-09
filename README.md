# FACE

>#### Fortran Ansi Colors and Styles Environment
> A KISS pure Fortran 2008+ library for easy *colorizing* and *stylizing* strings with ANSI escape codes — one function, zero dependencies.

[![GitHub tag](https://img.shields.io/github/v/tag/szaghi/FACE)](https://github.com/szaghi/FACE/tags)
[![GitHub issues](https://img.shields.io/github/issues/szaghi/FACE)](https://github.com/szaghi/FACE/issues)
[![CI](https://github.com/szaghi/FACE/actions/workflows/ci.yml/badge.svg)](https://github.com/szaghi/FACE/actions/workflows/ci.yml)
[![coverage](https://img.shields.io/endpoint?url=https://szaghi.github.io/FACE/coverage.json)](https://github.com/szaghi/FACE/actions/workflows/ci.yml)

| 🎨 **Single Function API**<br>`colorize(string, color_fg, color_bg, style)` — one call does it all | 🌈 **Rich Color Support**<br>Named colors and 24-bit RGB (`#rrggbb`) — foreground and background | ✨ **Text Styles**<br>Bold, italic, underline, blink, and more standard ANSI styles | 🔤 **Unicode Ready**<br>Optional UCS4/UTF-8 character kind support via preprocessor |
|:---:|:---:|:---:|:---:|
| ⚡ **Pure Fortran 2008+**<br>No C, no external deps — tested with gfortran, ifx, lfortran, flang-new, nvfortran | 🔓 **Multi-licensed**<br>GPL v3 · BSD 2/3-Clause · MIT | 📦 **Multiple build systems**<br>fpm, FoBiS.py, CMake | 📖 **Documented & Tested**<br>API reference + full test suite for colors and styles |

For full documentation (guide, API reference, examples, etc.) see the [FACE website](https://szaghi.github.io/FACE/).

---

## Authors

- Stefano Zaghi — [@szaghi](https://github.com/szaghi)

Contributions are welcome — see the [Contributing](/guide/contributing) page.

## Copyrights

This project is distributed under a multi-licensing system:

- **FOSS projects**: [GPL v3](http://www.gnu.org/licenses/gpl-3.0.html)
- **Closed source / commercial**: [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause), [BSD 3-Clause](http://opensource.org/licenses/BSD-3-Clause), or [MIT](http://opensource.org/licenses/MIT)

> Anyone interested in using, developing, or contributing to this project is welcome — pick the license that best fits your needs.

---

## A taste of FACE

```fortran
use face
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue', style='underline_on')
```

---

## Usage

FACE exposes only 3 procedures:

1. `colorize` — the main function;
2. `colors_samples` — prints a sample of all available colors to standard output;
3. `styles_samples` — prints a sample of all available styles to standard output.

```fortran
use face
character(len=:), allocatable :: error_message

error_message = colorize('error:', color_fg='red', style='underline_on')//' file not found!'

print '(A)', error_message
print '(A)', colorize('suggestion: check your configuration', color_fg='blue')

call colors_samples ! print samples of all colors available
call styles_samples ! print samples of all styles available
```

### colorize

`colorize` returns an allocatable character with the requested foreground color, background color, and style. All arguments except `string` are optional.

```fortran
pure function colorize(string, color_fg, color_bg, style) result(colorized)
  character(len=*), intent(in)           :: string    ! Input string.
  character(len=*), intent(in), optional :: color_fg  ! Foreground color definition.
  character(len=*), intent(in), optional :: color_bg  ! Background color definition.
  character(len=*), intent(in), optional :: style     ! Style definition.
  character(len=:), allocatable          :: colorized ! Colorized string.
end function colorize
```

> Colors and style definitions are case **insensitive**. No warning is returned for unrecognized values (including a malformed `#rrggbb`) — the color or style is simply not applied.

## Available Colors and Styles

A color is either one of the names below (`red`, `green_intense`, ...) or a 24-bit RGB value
`#rrggbb`, written as the SGR sequence `ESC[38;2;r;g;bm` (foreground) or `ESC[48;2;r;g;bm`
(background). Most modern terminals support 24-bit color; a terminal that does not may show
an approximation or ignore it.

```fortran
print '(A)', colorize('188', color_fg='#2EF5C0')//colorize(' km/h', color_fg='#FFB000', color_bg='#101010')
```

![samples](docs/samples.png)

---

## Install

### FoBiS.py

**Standalone** — clone, build, and install in one command:

```bash
FoBiS.py install szaghi/FACE -mode static-gnu
FoBiS.py install szaghi/FACE -mode static-gnu --prefix /path/to/prefix
```

**As a project dependency** — declare PENF in your `fobos` and run `fetch`:

```ini
[dependencies]
deps_dir = src/third_party
FACE     = https://github.com/szaghi/FACE
```

```bash
FoBiS.py fetch           # fetch and build
FoBiS.py fetch --update  # re-fetch and rebuild
```

### fpm

```bash
fpm build
fpm test
```

For dependencies add to your `fpm.toml`:

```toml
[dependencies]
FACE = { git = "https://github.com/szaghi/FACE" }
```

### CMake

```bash
cmake -B build && cmake --build build
```

### Makefile

```bash
make              # static library
make TESTS=yes    # build and run tests
```

### Install script

FACE ships a bash script (`install.sh`, downloadable from the [latest release](https://github.com/szaghi/FACE/releases/latest)) that automates download and build:

```shell
install.sh --download git --build cmake
```

Supported download methods: `git`, `wget`. Supported build systems: `fobis`, `make`, `cmake`.
