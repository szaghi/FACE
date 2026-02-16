# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

FACE (Fortran Ansi Colors and Styles Environment) is a pure Fortran library for colorizing and stylizing strings with ANSI escape codes. The core API is a single function `colorize(string, color_fg, color_bg, style)` defined in `src/lib/face.F90`.

## Build Systems

The project supports three build systems:

### FPM (primary)
```bash
fpm build
fpm test
fpm test --profile debug
fpm test --profile release
fpm test --test-name face_test_basic  # run single test
```

### CMake
```bash
cmake -S . -B build -DBUILD_TESTING=TRUE
cmake --build build
ctest --test-dir build
ctest --test-dir build -R face_test_basic  # run single test
```

### FoBiS.py (legacy)
```bash
FoBiS.py build -mode tests-gnu
FoBiS.py build -mode tests-gnu-debug
```

## Source Structure

- `src/lib/face.F90` — entire library in one file; uses C preprocessor (`#ifdef`) for conditional compilation of ASCII and UCS4 character kind support
- `src/tests/` — four test programs: `face_test_basic`, `face_test_colors`, `face_test_styles`, `face_test_ucs4`

## Preprocessor / Character Kinds

The library conditionally compiles based on compiler support detected at configure time:
- `ascii_supported` — ASCII character kind available
- `ascii_neq_default` — ASCII kind differs from default kind
- `ucs4_supported` — UCS4/Unicode character kind available

The test `face_test_ucs4.F90` (capital `.F90`) is preprocessed; lowercase `.f90` files are not.

## Coding Conventions (from CONTRIBUTING.md)

- Fortran 2008+ standard; explicit typing required (`implicit none`)
- 2-space indentation
- KISS principles; avoid over-engineering
- All public API symbols must work with `use face` (single module)

## CI

- `.github/workflows/ci.yml` — builds, tests coverage (gcov), generates Ford docs, deploys to GitHub Pages
- `.github/workflows/ci-conda.yml` — matrix testing across Linux/macOS/Windows with gfortran, ifx, lfortran, flang-new, nvfortran (both fpm and cmake)
- `.github/workflows/install.yml` — tests cmake install script and fpm build

## Documentation

Ford-based API docs are generated from `doc/` and published to GitHub Pages. The `docs/` directory is for a new VitePress-based documentation site (migration in progress using `scripts/migrate_to_formal.sh` and `formal-ford2vitepress`).
