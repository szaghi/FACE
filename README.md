# FACE — Fortran Ansi Colors and Styles Environment

A KISS pure Fortran library for easy *colorizing* and *stylizing* strings with ANSI escape codes.

- Pure Fortran (KISS), Fortran 2008+ standard compliant;
- Tiny — just one function covers everything;
- Free and Open Source, multi-licensed.

**[Documentation](https://szaghi.github.io/FACE/)** | **[API Reference](https://szaghi.github.io/FACE/api/)**

---

## Copyrights

FACE is distributed under a multi-licensing system:

- **FOSS projects**: [GPL v3](http://www.gnu.org/licenses/gpl-3.0.html)
- **Closed source / commercial**: [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause), [BSD 3-Clause](http://opensource.org/licenses/BSD-3-Clause), or [MIT](http://opensource.org/licenses/MIT)

Anyone interested in using, developing, or contributing to FACE is welcome — pick the license that best fits your needs.
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

> Colors and style definitions are case **insensitive**. No warning is returned for unrecognized values — the color or style is simply not applied.

## Available Colors and Styles

![samples](docs/samples.png)

---

## Install

### FPM

```bash
fpm build
fpm test
```

Or add FACE as a dependency in your `fpm.toml`:

```toml
[dependencies]
FACE = { git = "https://github.com/szaghi/FACE" }
```

### CMake

```bash
cmake -S . -B build
cmake --build build
cmake --install build
```

### Install script

FACE ships a bash script (`install.sh`, downloadable from the [latest release](https://github.com/szaghi/FACE/releases/latest)) that automates download and build:

```shell
install.sh --download git --build cmake
```

Supported download methods: `git`, `wget`. Supported build systems: `fobis`, `make`, `cmake`.
