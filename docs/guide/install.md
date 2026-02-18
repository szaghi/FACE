---
title: Installation
---

# Installation

## Option 1 — fpm (recommended)

With [Fortran Package Manager](https://fpm.fortran-lang.org) no manual setup is needed.

```bash
fpm build
fpm test
```

Or add FACE as a dependency in your `fpm.toml`:

```toml
[dependencies]
FACE = { git = "https://github.com/szaghi/FACE" }
```

## Option 2 — CMake

```bash
cmake -S . -B build
cmake --build build
cmake --install build
```

## Option 3 — Install script

FACE ships a bash script (`install.sh`, downloadable from the
[latest release](https://github.com/szaghi/FACE/releases/latest)) that automates
download and build:

```shell
install.sh --download git --build cmake
```

Supported download methods: `git`, `wget`. Supported build systems: `fobis`, `make`, `cmake`.
