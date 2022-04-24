##[

  The semantics used in parsing the configuration file are the following:

    The files must be in plain-text format.
    '#' at the beginning of a line in a configuration file means it is only a comment.
    Options are separated by spaces.
    All numbers can be either decimal or hexadecimal. A hexadecimal number must be preceded by '0x', and is case-insensitive. 


  Visit the official GRUB documentation for more information.

  https://www.gnu.org/software/grub/manual/grub/grub.html#Menu_002dspecific-commands
]##

type
  Menu * = ref object
    menuentry* : string ## menuentry title [--class=class …] [--users=users] [--unrestricted] [--hotkey=key] [--id=id] [arg …] { command; … }
      ## This defines a GRUB menu entry named title.
      ## When this entry is selected from the menu,
      ## GRUB will set the chosen environment variable to
      ## value of --id if --id is given, execute the list of
      ## commands given within braces, and
      ## if the last command in the list returned successfully and a
      ## kernel was loaded it will execute the boot command.
      ## The --class option may be used any number of times to
      ## group menu entries into classes.
      ## Menu themes may display different classes using different styles.
      ## The --users option grants specific users access to
      ## specific menu entries. See Security.
      ## The --unrestricted option grants all users access to
      ## specific menu entries. See Security.
      ## The --hotkey option associates a hotkey with a menu entry.
      ## key may be a single letter, or one of the
      ## aliases 'backspace', 'tab', or 'delete'.
      ## The --id may be used to associate unique identifier with a
      ## menu entry. id is string of ASCII aphanumeric characters,
      ## underscore and hyphen and should not start with a digit.
      ## All other arguments including title are passed as
      ## positional parameters when list of commands is
      ## executed with title always assigned to $1.
    submenu* : string ## submenu title [--class=class …] [--users=users] [--unrestricted] [--hotkey=key] [--id=id] { menu entries … }
      ## This defines a submenu.
      ## An entry called title will be added to the menu;
      ## when that entry is selected, a
      ## new menu will be displayed showing all the
      ## entries within this submenu.
      ## All options are the same as in the
      ## menuentry command (see menuentry).
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#menuentry