---
title: Installation
---

# Installation

## One-line install

```bash
curl -fsSL https://github.com/szaghi/FACE/releases/latest/download/install.sh | bash
```

It installs the latest release into `~/.local` with the build system you choose among those FACE ships
(`--build fobis|fpm|cmake`: a menu asks when you do not say), the compiler you name (`--fc`, `--gnu`, `--intel`,
`--nvidia`), one install per compiler (`lib/face/<compiler>-<version>/`, `include/face/<compiler>-<version>/`), and
makes it usable through pkg-config (`pkg-config --cflags --libs face`, with `PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig`).
Pass options after `bash -s --`, e.g. `... | bash -s -- --build cmake --intel --prefix /opt/face`; `--help` lists them
all, `--uninstall` removes the install. The installer is FoBiS's
([One-line installer](https://szaghi.github.io/FoBiS/cookbook/installer)).

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
