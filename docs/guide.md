# Guide

## What is FACE?

**FACE** is a KISS pure Fortran library for easy *colorize* (and *stylize*) strings: FACE allows for easy handling of *Ansi Colors and Styles codes* providing a user-friendly Fortran *environment*... just one **function**.

- FACE is a pure Fortran (KISS) library;
- FACE is Fortran 2008+ standard compliant;
- FACE is tiny;
- FACE is a Free, Open Source Project.

## A taste of FACE

```fortran
use face
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue', style='underline_on')
```

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
print '(A)', colorize('suggestion: check you configuration', color_fg='blue')

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

![samples](./samples.png)

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

## Contributing & releasing

### Commit style

FACE uses [Conventional Commits](https://www.conventionalcommits.org/) so that `CHANGELOG.md` is generated automatically from the git log:

| Prefix | Purpose | Changelog section |
|--------|---------|-------------------|
| `feat:` | New feature or capability | New features |
| `fix:` | Bug fix | Bug fixes |
| `perf:` | Performance improvement | Performance |
| `refactor:` | Code restructuring | Refactoring |
| `docs:` | Documentation only | Documentation |
| `test:` | Tests | Testing |
| `build:` | Build system | Build system |
| `ci:` | CI/CD pipeline | CI/CD |
| `chore:` | Maintenance | Miscellaneous |

Append `!` for breaking changes (`feat!:`, `fix!:`). Reference issues with `#123` — they are auto-linked.

```
feat: add new color definition
fix: correct style code for bold (#42)
feat!: rename colorize to colorise
```

### Creating a release

Releases are fully automated via `scripts/bump.sh` and GitHub Actions. The only steps needed are:

```bash
# Install git-cliff once
npx git-cliff@latest

# Then, to release:
scripts/bump.sh patch   # v1.2.3 → v1.2.4
scripts/bump.sh minor   # v1.2.3 → v1.3.0
scripts/bump.sh major   # v1.2.3 → v2.0.0
scripts/bump.sh v2.1.0  # explicit version
```

`bump.sh` will ask for confirmation, then:

1. Regenerate `CHANGELOG.md` from the git log via [git-cliff](https://git-cliff.org/)
2. Commit with `chore(release): vX.Y.Z`
3. Create an annotated git tag
4. Push commit + tag

Pushing the tag triggers the GitHub Actions release workflow, which automatically:
- Runs the full test suite and uploads coverage to Codecov
- Builds this documentation site and deploys it to GitHub Pages
- Packages a versioned tarball `FACE-vX.Y.Z.tar.gz`
- Publishes a GitHub release with the changelog section as release notes

---

## Copyrights

FACE is distributed under a multi-licensing system:

- **FOSS projects**: [GPL v3](http://www.gnu.org/licenses/gpl-3.0.html)
- **Closed source / commercial**: [BSD 2-Clause](http://opensource.org/licenses/BSD-2-Clause), [BSD 3-Clause](http://opensource.org/licenses/BSD-3-Clause), or [MIT](http://opensource.org/licenses/MIT)

Anyone interested in using, developing, or contributing to FACE is welcome — pick the license that best fits your needs.
