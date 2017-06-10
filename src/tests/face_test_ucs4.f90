!< FACE test.
program face_test_ucs4
!< FACE test.
use face

implicit none

print '(A)', colorize('Hello', color_fg='blue')//colorize(UCS4_' ÜÇŞ4', color_fg='red')//colorize(' World', color_fg='blue')
endprogram face_test_ucs4
