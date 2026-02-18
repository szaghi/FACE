---
title: Usage
---

# Usage

## Quick example

```fortran
use face
character(len=:), allocatable :: error_message

error_message = colorize('error:', color_fg='red', style='underline_on')//' file not found!'

print '(A)', error_message
print '(A)', colorize('suggestion: check your configuration', color_fg='blue')

call colors_samples ! print samples of all colors available
call styles_samples ! print samples of all styles available
```

## colorize

`colorize` returns an allocatable character with the requested foreground color, background
color, and style. All arguments except `string` are optional.

```fortran
pure function colorize(string, color_fg, color_bg, style) result(colorized)
  character(len=*), intent(in)           :: string    ! Input string.
  character(len=*), intent(in), optional :: color_fg  ! Foreground color definition.
  character(len=*), intent(in), optional :: color_bg  ! Background color definition.
  character(len=*), intent(in), optional :: style     ! Style definition.
  character(len=:), allocatable          :: colorized ! Colorized string.
end function colorize
```

> Colors and style definitions are case **insensitive**. No warning is returned for
> unrecognized values — the color or style is simply not applied.
