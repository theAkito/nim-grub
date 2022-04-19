##[

  The program grub-mkconfig (see Invoking grub-mkconfig) generates grub.cfg files suitable for most cases.
  It is suitable for use when upgrading a distribution, and will discover available kernels and attempt to
  generate menu entries for them.grub-mkconfig does have some limitations.
  While adding extra custom menu entries to the end of the list can be done by editing /etc/grub.d/40_custom or
  creating /boot/grub/custom.cfg, changing the order of menu entries or changing their titles
  may require making complex changes to shell scripts stored in /etc/grub.d/. This may be improved in the future.
  In the meantime, those who feel that it would be easier to write grub.cfg directly are encouraged to
  do so (see Booting, and Shell-like scripting), and
  to disable any system provided by their distribution to automatically run grub-mkconfig.


  Visit the official GRUB documentation for more information.

  https://www.gnu.org/software/grub/manual/grub/grub.html#Simple-configuration
]##

type
  MkConfig * = ref object
    ## The file `/etc/default/grub` controls the operation of `grub-mkconfig`.
    ## It is sourced by a shell script, and
    ## so must be valid POSIX shell input;
    ## normally, it will just be a sequence of 'KEY=value' lines, but
    ## if the value contains spaces or other special characters
    ## then it must be quoted.
    ##
    ## For more detailed customisation of `grub-mkconfig`'s output,
    ## you may edit the scripts in /etc/grub.d directly.
    ## `/etc/grub.d/40_custom` is particularly useful for
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
    saveDefault* : bool ## GRUB_SAVEDEFAULT
      ## If this option is set to 'true', then, when an entry is selected,
      ## save it as a new default entry for use by future runs of GRUB.
      ## This is only useful if 'GRUB_DEFAULT=saved';
      ## it is a separate option because 'GRUB_DEFAULT=saved' is useful
      ## without this option, in conjunction with grub-set-default.
      ## Unset by default. This option relies on the environment block,
      ## which may not be available in all situations (see Environment block).
    timeout* : int ## GRUB_TIMEOUT
      ## Boot the default entry this many seconds after the menu
      ## is displayed, unless a key is pressed.
      ## The default is '5'. Set to '0' to boot immediately
      ## without displaying the menu, or to '-1' to wait indefinitely.
      ## If 'GRUB_TIMEOUT_STYLE' is set to 'countdown' or 'hidden',
      ## the timeout is instead counted before the menu is displayed.
    timeoutStyle* : string ## GRUB_TIMEOUT_STYLE #TODO: ENUM
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
      ## used to support vendor-specific power buttons.
      ## See Vendor power-on keys.
    distributor* : string ## GRUB_DISTRIBUTOR
      ## Set by distributors of GRUB to their identifying name.
      ## This is used to generate more informative menu entry titles. 
    terminalInput* : seq[string] ## GRUB_TERMINAL_INPUT #TODO: ENUM
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
    terminalOutput* : seq[string] ## GRUB_TERMINAL_OUTPUT #TODO: ENUM
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
    terminal* : string ## GRUB_TERMINAL #TODO: ENUM
      ## If this option is set, it overrides both
      ## 'GRUB_TERMINAL_INPUT' and 'GRUB_TERMINAL_OUTPUT'
      ## to the same value. 
    serialCommand* : string ## GRUB_SERIAL_COMMAND
      ## A command to configure the serial port
      ## when using the serial console.
      ## See serial. Defaults to 'serial'.
    cmdLineLinux* : seq[string] ## GRUB_CMDLINE_LINUX
      ## Command-line arguments to add to menu entries for the Linux kernel.
    cmdLineLinuxDefault* : seq[string] ## GRUB_CMDLINE_LINUX_DEFAULT
      ## Unless 'GRUB_DISABLE_RECOVERY' is set to 'true',
      ## two menu entries will be generated for each Linux kernel:
      ## one default entry and one entry for recovery mode.
      ## This option lists command-line arguments to
      ## add only to the default menu entry,
      ## after those listed in 'GRUB_CMDLINE_LINUX'.
    cmdLineNetBSD* : seq[string] ## GRUB_CMDLINE_NETBSD
    cmdLineNetBsdDefault* : seq[string] ## GRUB_CMDLINE_NETBSD_DEFAULT
      ## As 'GRUB_CMDLINE_LINUX' and 'GRUB_CMDLINE_LINUX_DEFAULT', but for NetBSD.
    cmdLineGnuMach* : seq[string] ## GRUB_CMDLINE_GNUMACH
      ## As 'GRUB_CMDLINE_LINUX', but for GNU Mach. 
    cmdLineXen* : seq[string] ## GRUB_CMDLINE_XEN
    cmdLineXenDefault* : seq[string] ## GRUB_CMDLINE_XEN_DEFAULT
      ## The values of these options are passed to
      ## Xen hypervisor Xen menu entries,
      ## for all respectively normal entries.
    cmdLineLinuxXenReplace* : seq[string] ## GRUB_CMDLINE_LINUX_XEN_REPLACE
    cmdLineLinuxXenReplaceDefault* : seq[string] ## GRUB_CMDLINE_LINUX_XEN_REPLACE_DEFAULT
      ## The values of these options replace the values of 'GRUB_CMDLINE_LINUX' and
      ## 'GRUB_CMDLINE_LINUX_DEFAULT' for Linux and Xen menu entries.
    earlyInitrdLinuxCustom* : seq[string] ## GRUB_EARLY_INITRD_LINUX_CUSTOM
    earlyInitrdLinuxStock* : seq[string] ## GRUB_EARLY_INITRD_LINUX_STOCK
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
    disableLinuxUUID* : bool ## GRUB_DISABLE_LINUX_UUID
      ## Normally, grub-mkconfig will generate menu entries
      ## that use universally-unique identifiers (UUIDs) to
      ## identify the root filesystem to the Linux kernel,
      ## using a 'root=UUID=...' kernel parameter.
      ## This is usually more reliable, but in some cases
      ## it may not be appropriate.
      ## To disable the use of UUIDs, set this option to 'true'.
    disableLinuxPartUUID* : bool ## GRUB_DISABLE_LINUX_PARTUUID
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
    disableRecovery* : bool ## GRUB_DISABLE_RECOVERY
      ## If this option is set to 'true', disable the generation of recovery mode menu entries.
    disableUUID* : bool ## GRUB_DISABLE_UUID
      ## Normally, grub-mkconfig will generate menu entries that use
      ## universally-unique identifiers (UUIDs) to identify various filesystems
      ## to search for files.
      ## This is usually more reliable, but in some cases it may not be appropriate.
      ## To disable this use of UUIDs, set this option to 'true'.
      ## Setting this option to 'true', will also set the options
      ## 'GRUB_DISABLE_LINUX_UUID' and 'GRUB_DISABLE_LINUX_PARTUUID' to 'true',
      ## unless they have been explicilty set to 'false'.
    videoBackend* : seq[string] ## GRUB_VIDEO_BACKEND
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
      ##
      ## If this variable is set, it sets the resolution used on the 'gfxterm' graphical terminal.
      ## Note that you can only use modes which your graphics card supports via VESA BIOS Extensions (VBE), so
      ## for example native LCD panel resolutions may not be available. The default is 'auto',
      ## which selects a platform-specific default that should look reasonable.
      ## Supported modes can be listed by 'videoinfo' command in GRUB.
      ## The resolution may be specified as a sequence of one or more modes,
      ## separated by commas (',') or semicolons (';');
      ## each will be tried in turn until one is found.
      ## Each mode should be either 'auto', 'widthxheight', or 'widthxheightxdepth'.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#gfxmode
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
      ##
      ## If this variable is set,
      ## it controls the video mode in which the Linux kernel starts up,
      ## replacing the 'vga=' boot option (see linux).
      ## It may be set to 'text' to force the Linux kernel to
      ## boot in normal text mode,
      ## 'keep' to preserve the graphics mode set using 'gfxmode', or
      ## any of the permitted values for 'gfxmode' to set a
      ## particular graphics mode (see gfxmode).Depending on your kernel,
      ## your distribution, your graphics card, and
      ## the phase of the moon, note that using this option may cause
      ## GNU/Linux to suffer from various display problems,
      ## particularly during the early part of the boot sequence.
      ## If you have problems, set this variable to 'text' and
      ## GRUB will tell Linux to boot in normal text mode.
      ## The default is platform-specific.
      ## On platforms with a native text mode
      ## (such as PC BIOS platforms), the default is 'text'.
      ## Otherwise the default may be 'auto' or a specific video mode.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#gfxpayload
    disableOsProber* : bool ## GRUB_DISABLE_OS_PROBER
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
    osProberSkipList* : seq[string] ## GRUB_OS_PROBER_SKIP_LIST
      ## List of space-separated FS UUIDs of
      ## filesystems to be ignored from os-prober output.
      ## For efi chainloaders it's <UUID>@<EFI FILE>
    disableSubmenu* : bool ## GRUB_DISABLE_SUBMENU
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
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#fallback
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#default
    enableCryptodisk* : char ## GRUB_ENABLE_CRYPTODISK
      ## If set to 'y', grub-mkconfig and grub-install will check for
      ## encrypted disks and
      ## generate additional commands needed to access them during boot.
      ## Note that in this case unattended boot is not possible because
      ## GRUB will wait for passphrase to unlock encrypted container.
    initTune* : string ## GRUB_INIT_TUNE
      ## Play a tune on the speaker when GRUB starts.
      ## This is particularly useful for users unable to see the screen.
      ## The value of this option is passed directly to play.
      ##
      ## If the argument is a file name (see File name syntax),
      ## play the tune recorded in it.
      ## The file format is first the tempo as an
      ## unsigned 32bit little-endian number, then
      ## pairs of unsigned 16bit little-endian numbers for pitch and
      ## duration pairs.
      ## If the arguments are a series of numbers,
      ## play the inline tune.
      ## The tempo is the base for all note durations.
      ## 60 gives a 1-second base, 120 gives a half-second base, etc.
      ## Pitches are Hz.
      ## Set pitch to 0 to produce a rest.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#play
    badRAM* : seq[string] ## GRUB_BADRAM
      ## If this option is set, GRUB will issue a
      ## badram command to filter out specified regions of RAM.
      ##
      ## This command notifies the memory manager that
      ## specified regions of RAM ought to be filtered out
      ## (usually, because they're damaged).
      ## This remains in effect after a payload kernel has been
      ## loaded by GRUB, as long as the loaded kernel obtains
      ## its memory map from GRUB. Kernels that support this include Linux,
      ## GNU Mach, the kernel of FreeBSD and Multiboot kernels in general.
      ## Syntax is the same as provided by the Memtest86+ utility:
      ## a list of address/mask pairs.
      ## Given a page-aligned address and a base address / mask pair,
      ## if all the bits of the page-aligned address that are
      ## enabled by the mask match with the base address,
      ## it means this page is to be filtered.
      ## This syntax makes it easy to represent patterns that are
      ## often result of memory damage,
      ## due to physical distribution of memory cells.
      ## The command is similar to cutmem command.
      ## Note: The command is not allowed when lockdown is
      ## enforced (see Lockdown).
      ## This prevents removing EFI memory regions to
      ## potentially subvert the security mechanisms
      ## provided by the UEFI secure boot.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#badram
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Lockdown
    preloadModules* : seq[string] ## GRUB_PRELOAD_MODULES
      ## This option may be set to a list of GRUB module names separated by spaces.
      ## Each module will be loaded as early as possible, at the start of grub.cfg.
    ##################################################
    ## The following options are still accepted for ##
    ## compatibility with existing configurations,  ##
    ## but have better replacements.                ##
    ##################################################
    hiddenTimeout* : int ## GRUB_HIDDEN_TIMEOUT
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
    hiddenTimeoutQuiet* : bool ## GRUB_HIDDEN_TIMEOUT_QUIET
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
      ##
      ## Some laptop vendors provide an additional power-on button which
      ## boots another OS. GRUB supports such buttons with the
      ## 'GRUB_TIMEOUT_BUTTON',
      ## 'GRUB_TIMEOUT_STYLE_BUTTON',
      ## 'GRUB_DEFAULT_BUTTON', and
      ## 'GRUB_BUTTON_CMOS_ADDRESS'
      ## variables in default/grub (see Simple configuration).
      ## 'GRUB_TIMEOUT_BUTTON',
      ## 'GRUB_TIMEOUT_STYLE_BUTTON', and
      ## 'GRUB_DEFAULT_BUTTON' are used instead of the
      ## corresponding variables without the '_BUTTON' suffix when
      ## powered on using the special button.
      ## 'GRUB_BUTTON_CMOS_ADDRESS' is vendor-specific and
      ## partially model-specific.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Vendor-power_002don-keys