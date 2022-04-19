## https://www.gnu.org/software/grub/manual/grub/grub.html#Simple-configuration

type
  MkConfig * = ref object
    ## The file /etc/default/grub controls the operation of grub-mkconfig.
    ## It is sourced by a shell script, and
    ## so must be valid POSIX shell input;
    ## normally, it will just be a sequence of 'KEY=value' lines, but
    ## if the value contains spaces or other special characters
    ## then it must be quoted.
    ##
    ## For more detailed customisation of grub-mkconfig's output,
    ## you may edit the scripts in /etc/grub.d directly.
    ## /etc/grub.d/40_custom is particularly useful for
    ## adding entire custom menu entries;
    ## simply type the menu entries you want to
    ## add at the end of that file, making sure to
    ## leave at least the first two lines intact.
    default* : string ## GRUB_DEFAULT
      ## The default menu entry.
      ## This may be a number, in which case it identifies the Nth entry
      ## in the generated menu counted from zero,
      ## or the title of a menu entry,
      ## or the special string 'saved'.
      ## Using the id may be useful if you want to
      ## set a menu entry as the default
      ## even though there may be a variable number
      ## of entries before it.
    saveDefault* : string ## GRUB_SAVEDEFAULT
      ## If this option is set to 'true', then, when an entry is selected,
      ## save it as a new default entry for use by future runs of GRUB.
      ## This is only useful if 'GRUB_DEFAULT=saved';
      ## it is a separate option because 'GRUB_DEFAULT=saved' is useful
      ## without this option, in conjunction with grub-set-default.
      ## Unset by default. This option relies on the environment block,
      ## which may not be available in all situations (see Environment block).
    timeout* : string ## GRUB_TIMEOUT
      ## Boot the default entry this many seconds after the menu
      ## is displayed, unless a key is pressed.
      ## The default is '5'. Set to '0' to boot immediately
      ## without displaying the menu, or to '-1' to wait indefinitely.
      ## If 'GRUB_TIMEOUT_STYLE' is set to 'countdown' or 'hidden',
      ## the timeout is instead counted before the menu is displayed.
    timeoutStyle* : string ## GRUB_TIMEOUT_STYLE
      ## If this option is unset or set to 'menu',
      ## then GRUB will display the menu and then wait for
      ## the timeout set by 'GRUB_TIMEOUT'
      ## to expire before booting the default entry.
      ## Pressing a key interrupts the timeout.
      ## If this option is set to 'countdown' or 'hidden', then,
      ## before displaying the menu, GRUB will wait for the timeout
      ## set by 'GRUB_TIMEOUT' to expire. If ESC or F4 are pressed,
      ## or SHIFT is held down during that time,
      ## it will display the menu and wait for input.
      ## If a hotkey associated with a menu entry is pressed,
      ## it will boot the associated menu entry immediately.
      ## If the timeout expires before either of these happens,
      ## it will boot the default entry. In the 'countdown' case,
      ## it will show a one-line indication of the remaining time.
    defaultButton* : string ## GRUB_DEFAULT_BUTTON
    timeoutButton* : string ## GRUB_TIMEOUT_BUTTON
    timeoutStyleButton* : string ## GRUB_TIMEOUT_STYLE_BUTTON
    buttonCmosAddress* : string ## GRUB_BUTTON_CMOS_ADDRESS
      ## Variants of the corresponding variables without the '_BUTTON' suffix,
      ## used to support vendor-specific power buttons. See Vendor power-on keys. 
    distributor* : string ## GRUB_DISTRIBUTOR
      ## Set by distributors of GRUB to their identifying name.
      ## This is used to generate more informative menu entry titles. 
    terminalInput* : string ## GRUB_TERMINAL_INPUT
      ## Select the terminal input device.
      ## You may select multiple devices here,
      ## separated by spaces.Valid terminal input names
      ## depend on the platform, but may include 'console'
      ## (native platform console),
      ## 'serial' (serial terminal),
      ## 'serial_<port>'
      ## (serial terminal with explicit port selection),
      ## 'at_keyboard' (PC AT keyboard), or
      ## 'usb_keyboard' (USB keyboard using the HID Boot Protocol,
      ## for cases where the firmware does not handle this).
      ## The default is to use the platform's native terminal input.
    terminalOutput* : string ## GRUB_TERMINAL_OUTPUT
      ## Select the terminal output device.
      ## You may select multiple devices here, separated by spaces.
      ## Valid terminal output names depend on the platform,
      ## but may include 'console' (native platform console),
      ## 'serial' (serial terminal), 'serial_<port>'
      ## (serial terminal with explicit port selection),
      ## 'gfxterm' (graphics-mode output),
      ## 'vga_text' (VGA text output),
      ## 'mda_text' (MDA text output),
      ## 'morse' (Morse-coding using system beeper) or
      ## 'spkmodem' (simple data protocol using system speaker).
    terminal* : string ## GRUB_TERMINAL
      ## If this option is set, it overrides both
      ## 'GRUB_TERMINAL_INPUT' and 'GRUB_TERMINAL_OUTPUT'
      ## to the same value. 
    serialCommand* : string ## GRUB_SERIAL_COMMAND
      ## A command to configure the serial port
      ## when using the serial console.
      ## See serial. Defaults to 'serial'.
    cmdLineLinux* : string ## GRUB_CMDLINE_LINUX
      ## Command-line arguments to add to menu entries for the Linux kernel.
    cmdLineLinuxDefault* : string ## GRUB_CMDLINE_LINUX_DEFAULT
      ## Unless 'GRUB_DISABLE_RECOVERY' is set to 'true',
      ## two menu entries will be generated for each Linux kernel:
      ## one default entry and one entry for recovery mode.
      ## This option lists command-line arguments to
      ## add only to the default menu entry,
      ## after those listed in 'GRUB_CMDLINE_LINUX'.
    cmdLineNetBSD* : string ## GRUB_CMDLINE_NETBSD
    cmdLineNetBsdDefault* : string ## GRUB_CMDLINE_NETBSD_DEFAULT
      ## As 'GRUB_CMDLINE_LINUX' and 'GRUB_CMDLINE_LINUX_DEFAULT', but for NetBSD.
    cmdLineGnuMach* : string ## GRUB_CMDLINE_GNUMACH
      ## As 'GRUB_CMDLINE_LINUX', but for GNU Mach. 
    cmdLineXen* : string ## GRUB_CMDLINE_XEN
    cmdLineXenDefault* : string ## GRUB_CMDLINE_XEN_DEFAULT
      ## The values of these options are passed to
      ## Xen hypervisor Xen menu entries,
      ## for all respectively normal entries.
    cmdLineLinuxXenReplace* : string ## GRUB_CMDLINE_LINUX_XEN_REPLACE
    cmdLineLinuxXenReplaceDefault* : string ## GRUB_CMDLINE_LINUX_XEN_REPLACE_DEFAULT
      ## The values of these options replace the values of 'GRUB_CMDLINE_LINUX' and
      ## 'GRUB_CMDLINE_LINUX_DEFAULT' for Linux and Xen menu entries.
    earlyInitrdLinuxCustom* : string ## GRUB_EARLY_INITRD_LINUX_CUSTOM
    earlyInitrdLinuxStock* : string ## GRUB_EARLY_INITRD_LINUX_STOCK
      ## List of space-separated early initrd images to be loaded from '/boot'.
      ## This is for loading things like CPU microcode, firmware,
      ## ACPI tables, crypto keys, and so on.
      ## These early images will be loaded in the order declared, and
      ## all will be loaded before the actual functional initrd image.
      ## 'GRUB_EARLY_INITRD_LINUX_STOCK' is for your distribution to
      ## declare images that are provided by the distribution.
      ## It should not be modified without understanding the consequences.
      ## They will be loaded first.
      ## 'GRUB_EARLY_INITRD_LINUX_CUSTOM' is for your custom created images
    disableLinuxUUID* : string ## GRUB_DISABLE_LINUX_UUID
      ## Normally, grub-mkconfig will generate menu entries
      ## that use universally-unique identifiers (UUIDs) to
      ## identify the root filesystem to the Linux kernel,
      ## using a 'root=UUID=...' kernel parameter.
      ## This is usually more reliable, but in some cases
      ## it may not be appropriate.
      ## To disable the use of UUIDs, set this option to 'true'.
    disableLinuxPartUUID* : string ## GRUB_DISABLE_LINUX_PARTUUID
      ## If grub-mkconfig cannot identify the root filesystem via
      ## its universally-unique indentifier (UUID),
      ## grub-mkconfig can use the UUID of the partition containing the
      ## filesystem to identify the root filesystem to the
      ## Linux kernel via a 'root=PARTUUID=...' kernel parameter.
      ## This is not as reliable as using the filesystem UUID, but
      ## is more reliable than using the Linux device names.
      ## When 'GRUB_DISABLE_LINUX_PARTUUID' is set to 'false', the
      ## Linux kernel version must be
      ## 2.6.37 (3.10 for systems using the MSDOS partition scheme) or newer.
      ## This option defaults to 'true'.
      ## To enable the use of partition UUIDs, set this option to 'false'.
    disableRecovery* : string ## GRUB_DISABLE_RECOVERY
      ## If this option is set to 'true', disable the generation of recovery mode menu entries.
    disableUUID* : string ## GRUB_DISABLE_UUID
      ## Normally, grub-mkconfig will generate menu entries that use
      ## universally-unique identifiers (UUIDs) to identify various filesystems
      ## to search for files.
      ## This is usually more reliable, but in some cases it may not be appropriate.
      ## To disable this use of UUIDs, set this option to 'true'.
      ## Setting this option to 'true', will also set the options
      ## 'GRUB_DISABLE_LINUX_UUID' and 'GRUB_DISABLE_LINUX_PARTUUID' to 'true',
      ## unless they have been explicilty set to 'false'.
    videoBackend* : string ## GRUB_VIDEO_BACKEND
      ## If graphical video support is required,
      ## either because the 'gfxterm' graphical terminal is in use or
      ## because 'GRUB_GFXPAYLOAD_LINUX' is set, then
      ## grub-mkconfig will normally load all available GRUB video drivers and
      ## use the one most appropriate for your hardware.
      ## If you need to override this for some reason, then you can set this option.
      ## After grub-install has been run, the available video drivers are listed in /boot/grub/video.lst.
    gfxMode* : string ## GRUB_GFXMODE
      ## Set the resolution used on the 'gfxterm' graphical terminal.
      ## Note that you can only use modes which your graphics card
      ## supports via VESA BIOS Extensions (VBE), so
      ## for example native LCD panel resolutions may not be available.
      ## The default is 'auto', which tries to select a preferred resolution.
    background* : string ## GRUB_BACKGROUND
      ## Set a background image for use with the 'gfxterm' graphical terminal.
      ## The value of this option must be a file readable by GRUB at boot time, and
      ## it must end with .png, .tga, .jpg, or .jpeg.
      ## The image will be scaled if necessary to fit the screen.
    theme* : string ## GRUB_THEME
      ## Set a theme for use with the 'gfxterm' graphical terminal.
    gfxPayloadLinux* : string ## GRUB_GFXPAYLOAD_LINUX
      ## Set to 'text' to force the Linux kernel to boot in normal text mode,
      ## 'keep' to preserve the graphics mode set using 'GRUB_GFXMODE',
      ## 'widthxheight'['xdepth'] to set a particular graphics mode, or
      ## a sequence of these separated by commas or semicolons to
      ## try several modes in sequence. See gfxpayload.
      ## Depending on your kernel, your distribution, your graphics card, and
      ## the phase of the moon, note that using this option may cause
      ## GNU/Linux to suffer from various display problems,
      ## particularly during the early part of the boot sequence.
      ## If you have problems, set this option to 'text' and
      ## GRUB will tell Linux to boot in normal text mode.
    disableOsProber* : string ## GRUB_DISABLE_OS_PROBER
      ## The grub-mkconfig has a feature to use the external
      ## os-prober program to discover other operating systems
      ## installed on the same machine and
      ## generate appropriate menu entries for them.
      ## It is disabled by default since automatic and
      ## silent execution of os-prober, and
      ## creating boot entries based on that data,
      ## is a potential attack vector.
      ## Set this option to 'false' to
      ## enable this feature in the grub-mkconfig command.
    osProberSkipList* : string ## GRUB_OS_PROBER_SKIP_LIST
      ## List of space-separated FS UUIDs of
      ## filesystems to be ignored from os-prober output.
      ## For efi chainloaders it's <UUID>@<EFI FILE>
    disableSubmenu* : string ## GRUB_DISABLE_SUBMENU
      ## Normally, grub-mkconfig will generate top level menu entry
      ## for the kernel with highest version number and
      ## put all other found kernels or alternative menu entries
      ## for recovery mode in submenu.
      ## For entries returned by os-prober first entry will be
      ## put on top level and all others in submenu.
      ## If this option is set to 'true', flat menu with
      ## all entries on top level will be generated instead.
      ## Changing this option will require changing
      ## existing values of 'GRUB_DEFAULT', 'fallback' (see fallback) and
      ## 'default' (see default) environment variables
      ## as well as saved default entry using grub-set-default and
      ## value used with grub-reboot.
    enableCryptodisk* : string ## GRUB_ENABLE_CRYPTODISK
      ## If set to 'y', grub-mkconfig and grub-install will check for
      ## encrypted disks and
      ## generate additional commands needed to access them during boot.
      ## Note that in this case unattended boot is not possible because
      ## GRUB will wait for passphrase to unlock encrypted container.
    initTune* : string ## GRUB_INIT_TUNE
      ## Play a tune on the speaker when GRUB starts.
      ## This is particularly useful for users unable to see the screen.
      ## The value of this option is passed directly to play.
    badRAM* : string ## GRUB_BADRAM
      ## If this option is set, GRUB will issue a
      ## badram command to filter out specified regions of RAM.
    preloadModules* : string ## GRUB_PRELOAD_MODULES
      ## This option may be set to a list of GRUB module names separated by spaces.
      ## Each module will be loaded as early as possible, at the start of grub.cfg.
    ##
    ## The following options are still accepted for
    ## compatibility with existing configurations, but have better replacements
    ##
    hiddenTimeout* : string ## GRUB_HIDDEN_TIMEOUT
      ## Wait this many seconds before displaying the menu.
      ## If ESC or F4 are pressed, or
      ## SHIFT is held down during that time,
      ## display the menu and wait for input according to
      ## 'GRUB_TIMEOUT'.
      ## If a hotkey associated with a menu entry is pressed,
      ## boot the associated menu entry immediately.
      ## If the timeout expires before either of these happens,
      ## display the menu for the number of seconds
      ## specified in 'GRUB_TIMEOUT' before booting the default entry.
      ## If you set 'GRUB_HIDDEN_TIMEOUT', you should also set 'GRUB_TIMEOUT=0'
      ## so that the menu is not displayed at all unless ESC or F4 are pressed,
      ## or SHIFT is held down.
      ## This option is unset by default, and
      ## is deprecated in favour of the less confusing
      ## 'GRUB_TIMEOUT_STYLE=countdown' or 'GRUB_TIMEOUT_STYLE=hidden'.
    hiddenTimeoutQuiet* : string ## GRUB_HIDDEN_TIMEOUT_QUIET
      ## In conjunction with 'GRUB_HIDDEN_TIMEOUT', set this to 'true' to
      ## suppress the verbose countdown while waiting for a key to be pressed
      ## before displaying the menu.This option is unset by default, and
      ## is deprecated in favour of the less confusing 'GRUB_TIMEOUT_STYLE=countdown'.
    hiddenTimeoutButton* : string ## GRUB_HIDDEN_TIMEOUT_BUTTON
      ## Variant of 'GRUB_HIDDEN_TIMEOUT',
      ## used to support vendor-specific power buttons. See Vendor power-on keys.
      ## This option is unset by default, and
      ## is deprecated in favour of the less confusing
      ## 'GRUB_TIMEOUT_STYLE=countdown' or 'GRUB_TIMEOUT_STYLE=hidden'.



