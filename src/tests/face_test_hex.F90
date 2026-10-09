!< FACE test: 24-bit "#rrggbb" colours, checked byte by byte.
program face_test_hex
!< FACE test: 24-bit "#rrggbb" colours, checked byte by byte.
use face

implicit none

character(1), parameter :: E=achar(27) !< Escape.
logical                 :: passed      !< All checks passed.

passed = .true.
call check('fg hex',           colorize('x', color_fg='#2EF5C0'),   E//'[38;2;46;245;192mx'//E//'[0m')
call check('fg hex lowercase', colorize('x', color_fg='#2ef5c0'),   E//'[38;2;46;245;192mx'//E//'[0m')
call check('fg hex blanks',    colorize('x', color_fg=' #000000 '), E//'[38;2;0;0;0mx'//E//'[0m')
call check('bg hex',           colorize('x', color_bg='#FFB000'),   E//'[48;2;255;176;0mx'//E//'[0m')
call check('fg and bg hex',    colorize('x', color_fg='#FF0000', color_bg='#00FF00'), &
           E//'[48;2;0;255;0m'//E//'[38;2;255;0;0mx'//E//'[0m'//E//'[0m')
call check('fg name',          colorize('x', color_fg='red'),       E//'[31mx'//E//'[0m')
call check('bg name',          colorize('x', color_bg='Red'),       E//'[41mx'//E//'[0m')
call check('hex too short',    colorize('x', color_fg='#FFF'),      'x')
call check('hex too long',     colorize('x', color_fg='#FFFFFF0'),  'x')
call check('hex not a digit',  colorize('x', color_fg='#GG0000'),   'x')
call check('hex without #',    colorize('x', color_fg='2EF5C0'),    'x')
call check('unknown name',     colorize('x', color_fg='teal'),      'x')
#ifdef UCS4_SUPPORTED
call check('ucs4 fg hex', transcode(colorize(UCS4_'x', color_fg='#2EF5C0')), E//'[38;2;46;245;192mx'//E//'[0m')
#endif
#if defined ASCII_SUPPORTED && defined ASCII_NEQ_DEFAULT
call check('ascii bg hex', transcode(colorize(ASCII_'x', color_bg='#FFB000')), E//'[48;2;255;176;0mx'//E//'[0m')
#endif
if (.not.passed) error stop 1
print '(A)', 'face_test_hex: all checks passed'

contains
   subroutine check(what, got, expected)
   !< Compare a colorized string with the expected bytes.
   character(len=*), intent(in) :: what     !< What is checked.
   character(len=*), intent(in) :: got      !< Colorized string.
   character(len=*), intent(in) :: expected !< Expected bytes.

   if (got==expected .and. len(got)==len(expected)) return
   passed = .false.
   print '(A)', 'FAIL '//what//': got "'//visible(got)//'", expected "'//visible(expected)//'"'
   endsubroutine check

   pure function visible(string)
   !< Return the string with the escape character written as "^[".
   character(len=*), intent(in)  :: string  !< Input string.
   character(len=:), allocatable :: visible !< Visible string.
   integer                       :: c       !< Counter.

   visible = ''
   do c=1, len(string)
      if (string(c:c)==E) then
         visible = visible//'^['
      else
         visible = visible//string(c:c)
      endif
   enddo
   endfunction visible

   pure function transcode(string)
   !< Return a string of a non default kind as a default one, character by character (all of them are ASCII here).
   class(*), intent(in)          :: string    !< Input string.
   character(len=:), allocatable :: transcode !< Default kind string.
   integer                       :: c         !< Counter.

   transcode = ''
   select type(string)
#ifdef UCS4_SUPPORTED
   type is(character(len=*, kind=UCS4))
      do c=1, len(string)
         transcode = transcode//achar(iachar(string(c:c)))
      enddo
#endif
#if defined ASCII_SUPPORTED && defined ASCII_NEQ_DEFAULT
   type is(character(len=*, kind=ASCII))
      do c=1, len(string)
         transcode = transcode//achar(iachar(string(c:c)))
      enddo
#endif
   endselect
   endfunction transcode
endprogram face_test_hex
