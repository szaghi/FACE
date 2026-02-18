---
title: Features
---

# Features

## A taste of FACE

```fortran
use face
print '(A)', colorize('Hello', color_fg='red')//colorize(' World', color_fg='blue', style='underline_on')
```

## API

FACE exposes only 3 procedures:

1. `colorize` — the main function
2. `colors_samples` — prints a sample of all available colors to standard output
3. `styles_samples` — prints a sample of all available styles to standard output

## Available Colors and Styles

![samples](../samples.png)
