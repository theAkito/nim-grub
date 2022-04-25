##[

  Commands usable anywhere in the menu and in the command-line. 


  Visit the official GRUB documentation for more information.

  https://www.gnu.org/software/grub/manual/grub/grub.html#General-commands
]##

type
  MiscCommand * = ref object
    serial* : string ## serial [--unit=unit] [--port=port] [--speed=speed] [--word=word] [--parity=parity] [--stop=stop]
      ## Initialize a serial device. unit is a number in the range 0-3
      ## specifying which serial port to use; default is 0,
      ## which corresponds to the port often called COM1.
      ## port is the I/O port where the UART is to be found;
      ## if specified it takes precedence over unit.
      ## speed is the transmission speed; default is 9600.
      ## word and stop are the number of data bits and stop bits.
      ## Data bits must be in the range 5-8 and stop bits must be 1 or 2.
      ## Default is 8 data bits and one stop bit. parity is one of
      ## 'no', 'odd', 'even' and defaults to 'no'.
      ## The serial port is not used as a communication channel unless the
      ## terminal_input or terminal_output command is used
      ## (see terminal_input, see terminal_output).
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#terminal_005finput
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#terminal_005foutput
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Serial-terminal
    terminal_input* : string ## terminal_input [--append|--remove] [terminal1] [terminal2] …
      ##     List or select an input terminal.
      ## With no arguments, list the active and available input terminals.
      ## With --append, add the named terminals to the list of active input terminals; any of these may be used to provide input to GRUB.
      ## With --remove, remove the named terminals from the active list.
      ## With no options but a list of terminal names, make only the listed terminal names active.
    terminal_output* : string ## terminal_output [--append|--remove] [terminal1] [terminal2] …
      ## List or select an output terminal.
      ## With no arguments, list the active and
      ## available output terminals.
      ## With --append, add the named terminals to the
      ## list of active output terminals;
      ## all of these will receive output from GRUB.
      ## With --remove, remove the
      ## named terminals from the active list.
      ## With no options but a list of terminal names,
      ## make only the listed terminal names active.
    terminfo* : string ## terminfo [-a|-u|-v] [-g WxH] [term] [type]
      ## Define the capabilities of your terminal by giving the name of an entry in the terminfo database, which should correspond roughly to a 'TERM' environment variable in Unix.
      ## The currently available terminal types are
      ## 'vt100',
      ## 'vt100-color',
      ## 'ieee1275', and
      ## 'dumb'.
      ## If you need other terminal types,
      ## please contact us to discuss the best way to
      ## include support for these in GRUB.
      ## The -a (--ascii),
      ## -u (--utf8), and
      ## -v (--visual-utf8) options control
      ## how non-ASCII text is displayed.
      ## -a specifies an ASCII-only terminal;
      ## -u specifies logically-ordered UTF-8; and
      ## -v specifies "visually-ordered UTF-8"
      ## (in other words, arranged such that a
      ## terminal emulator without bidirectional
      ## text support will display right-to-left text
      ## in the proper order;
      ## this is not really proper UTF-8, but a workaround).
      ## The -g (--geometry) can be used to
      ## specify terminal geometry.
      ## If no option or terminal type is specified, the
      ## current terminal type is printed. 