##[

  These commands are usable in the command-line and in menu entries.


  Visit the official GRUB documentation for more information.

  https://www.gnu.org/software/grub/manual/grub/grub.html#Command_002dline-and-menu-entry-commands
]##

type
  Command * = ref object
    `[`* : string ## [ expression ]
      ## Evaluate expression and return zero exit status if result is true, non zero status otherwise.
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#test
    acpi* : string ## acpi
      ## Modern BIOS systems normally implement the Advanced Configuration and Power Interface (ACPI), and
      ## define various tables that describe the interface between an
      ## ACPI-compliant operating system and the firmware.
      ## In some cases, the tables provided by default only work well with
      ## certain operating systems, and it may be necessary to replace some of them.
      ## Normally, this command will replace the Root System Description Pointer (RSDP) in the
      ## Extended BIOS Data Area to point to the new tables.
      ## If the --no-ebda option is used, the new tables will be known only to GRUB, but
      ## may be used by GRUB's EFI emulation. Note: The command is not allowed when lockdown is enforced (see Lockdown).
      ## Otherwise an attacker can instruct the GRUB to load an SSDT table to overwrite the
      ## kernel lockdown configuration and later load and execute unsigned code.
    authenticate* : seq[string] ## authenticate [userlist]
      ## Check whether user is in userlist or listed in the value of variable 'superusers'.
      ## See see superusers for valid user list format.
      ## If 'superusers' is empty, this command returns true.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#superusers
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Security
    backgroundColor* : string ## background_color color
      ## Set background color for active terminal.
      ## For valid color specifications see see Colors.
      ## Background color can be changed only when
      ## using 'gfxterm' for terminal output.
      ## This command sets color of empty areas without text.
      ## Text background color is controlled by
      ## environment variables
      ## color_normal,
      ## color_highlight,
      ## menu_color_normal,
      ## menu_color_highlight.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Special-environment-variables
    backgroundImage* : string ## background_image [[--mode 'stretch'|'normal'] file]
      ## Load background image for active terminal from file.
      ## Image is stretched to fill up entire screen
      ## unless option --mode 'normal' is given.
      ## Without arguments remove currently loaded background image.
      ## Background image can be changed only
      ## when using 'gfxterm' for terminal output. 
    badRAM* : string ## badram addr,mask[,addr,mask...]
      ## This command notifies the memory manager that
      ## specified regions of RAM ought to be filtered out (usually, because they're damaged).
      ## This remains in effect after a payload kernel has been loaded by GRUB,
      ## as long as the loaded kernel obtains its memory map from GRUB.
      ## Kernels that support this include Linux, GNU Mach,
      ## the kernel of FreeBSD and Multiboot kernels in general.
      ## Syntax is the same as provided by the Memtest86+ utility:
      ## a list of address/mask pairs. Given a page-aligned address and
      ## a base address / mask pair, if all the bits of the page-aligned address that
      ## are enabled by the mask match with the base address,
      ## it means this page is to be filtered.
      ## This syntax makes it easy to represent patterns that are
      ## often result of memory damage,
      ## due to physical distribution of memory cells.
      ## The command is similar to cutmem command.
      ## Note: The command is not allowed when lockdown is enforced (see Lockdown).
      ## This prevents removing EFI memory regions to potentially subvert the
      ## security mechanisms provided by the UEFI secure boot.
    blocklist* : string ## blocklist file
      ## Print a block list (see Block list syntax) for file.
    boot* : string ## boot
      ## Boot the OS or chain-loader which has been loaded.
      ## Only necessary if running the fully interactive command-line
      ## (it is implicit at the end of a menu entry).
    cat* : string ## cat [--dos] file
      ## If the --dos option is used,
      ## then carriage return / new line pairs will be
      ## displayed as a simple new line.
      ## Otherwise, the carriage return will be
      ## displayed as a control character ('<d>') to
      ## make it easier to see when boot problems are caused by a
      ## file formatted using DOS-style line endings.
    chainloader* : string ## chainloader [--force] file
      ## Load file as a chain-loader.
      ## Like any other file loaded by the filesystem code,
      ## it can use the blocklist notation (see Block list syntax) to
      ## grab the first sector of the current partition with '+1'.
      ## If you specify the option --force, then load file forcibly,
      ## whether it has a correct signature or not.
      ## This is required when you want to load a
      ## defective boot loader, such as SCO UnixWare 7.1.
    clear* : string ## clear
      ## Clear the screen.
    cmosclean* : string ## cmosclean byte:bit
      ## Clear value of bit in CMOS at location byte:bit.
      ## This command is available only on platforms that support CMOS.
    cmosdump* : string ## CMOS contents
      ## Dump full CMOS contents as hexadecimal values.
      ## This command is available only on platforms that support CMOS.
    cmostest* : string ## cmostest byte:bit
      ## Test value of bit in CMOS at location byte:bit.
      ## Exit status is zero if bit is set, non zero otherwise.
      ## This command is available only on platforms that support CMOS.
    cmp* : string ## cmp file1 file2
      ## Compare the file file1 with the file file2. If they differ in size,
      ## print the sizes like this:Differ in size:
      ## 0x1234 [foo], 0x4321 [bar]
      ## If the sizes are equal but the bytes at an offset differ, then
      ## print the bytes like this:
      ## Differ at the offset 777:
      ## 0xbe [foo], 0xef [bar]
      ## If they are completely identical, nothing will be printed.
    configfile* : string ## configfile file
      ## Load file as a configuration file.
      ## If file defines any menu entries,
      ## then show a menu containing them immediately.
      ## Any environment variable changes made by the
      ## commands in file will not be preserved after configfile returns.
    cpuid* : string ## cpuid [-l] [-p]
      ## Check for CPU features.
      ## This command is only available on x86 systems.
      ## With the -l option, return true if the CPU
      ## supports long mode (64-bit).
      ## With the -p option, return true if the CPU
      ## supports Physical Address Extension (PAE).
      ## If invoked without options, this command
      ## currently behaves as if it had been invoked with -l.
      ## This may change in the future.
    crc* : string ## crc arg …
      ## Alias for hashsum --hash crc32 arg …. See command hashsum (see hashsum) for full description. 
    cryptomount* : string ## cryptomount device|-u uuid|-a|-b
      ## Setup access to encrypted device.
      ## If necessary, passphrase is requested interactively.
      ## Option device configures specific grub device (see Naming convention);
      ## option -u uuid configures device with specified uuid;
      ## option -a configures all detected encrypted devices;
      ## option -b configures all geli containers that have boot flag set.
      ## GRUB suports devices encrypted using LUKS, LUKS2 and geli.
      ## Note that necessary modules (luks, luks2 and geli) have to be
      ## loaded manually before this command can be used. For LUKS2 only the
      ## PBKDF2 key derivation function is supported, as Argon2 is not yet supported.
      ## Also, note that, unlike filesystem UUIDs, UUIDs for
      ## encrypted devices must be specified without dash separators.
    cutmem* : string ## cutmem from[K|M|G] to[K|M|G]
      ## Remove any memory regions in specified range.
      ## This command notifies the memory manager that specified regions of
      ## RAM ought to be filtered out.
      ## This remains in effect after a payload kernel has been loaded by GRUB,
      ## as long as the loaded kernel obtains its memory map from GRUB.
      ## Kernels that support this include Linux, GNU Mach, the
      ## kernel of FreeBSD and Multiboot kernels in general.
      ## The command is similar to badram command.Note:
      ## The command is not allowed when lockdown is enforced (see Lockdown).
      ## This prevents removing EFI memory regions to potentially subvert the
      ## security mechanisms provided by the UEFI secure boot.
    date* : string ## date [[year-]month-day] [hour:minute[:second]]
      ## With no arguments, print the current date and time.
      ## Otherwise, take the current date and time,
      ## change any elements specified as arguments, and
      ## set the result as the new date and time. For example,
      ## 'date 01-01' will set the current month and day to January 1,
      ## but leave the year, hour, minute, and second unchanged.
    devicetree* : string ## devicetree file
      ## Load a device tree blob (.dtb) from a filesystem, for
      ## later use by a Linux kernel.
      ## Does not perform merging with any device tree supplied by firmware, but
      ## rather replaces it completely.
      ## Note: The command is not allowed when lockdown is enforced (see Lockdown).
      ## This is done to prevent subverting various security mechanisms.
    distrust* : string ## distrust pubkey_id
      ## Remove public key pubkey_id from GRUB's keyring of trusted keys.
      ## pubkey_id is the last four bytes (eight hexadecimal digits) of the
      ## GPG v4 key id, which is also the output of list_trusted (see list_trusted).
      ## Outside of GRUB, the key id can be obtained using gpg --fingerprint).
      ## These keys are used to validate signatures when environment variable
      ## check_signatures is set to enforce (see check_signatures), and
      ## by some invocations of verify_detached (see verify_detached).
      ## See Using digital signatures, for more information. 
    drivemap* : string ## drivemap -l|-r|[-s] from_drive to_drive
      ## Without options, map the drive from_drive to the drive to_drive.
      ## This is necessary when you chain-load some operating systems,
      ## such as DOS, if such an OS resides at a non-first drive.
      ## For convenience, any partition suffix on the drive is ignored, so
      ## you can safely use ${root} as a drive specification.With the -s option,
      ## perform the reverse mapping as well,
      ## swapping the two drives.
      ## With the -l option, list the current mappings.
      ## With the -r option, reset all mappings to the default values.
    `echo`* : string ## echo [-n] [-e] string …
      ## Display the requested text and, unless the -n option is used, a
      ## trailing new line.
      ## If there is more than one string,
      ## they are separated by spaces in the output.
      ## As usual in GRUB commands, variables may be substituted using '${var}'.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#echo
    eval* : string ## eval string ...
      ## Concatenate arguments together using single space as
      ## separator and evaluate result as sequence of GRUB commands.
    `export`* : string ## export envvar
      ## Export the environment variable envvar.
      ## Exported variables are visible to
      ## subsidiary configuration files loaded using configfile.
    `false`* : string ## false
      ## Do nothing, unsuccessfully.
      ## This is mainly useful in control constructs such as if and while (see Shell-like scripting).
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Shell_002dlike-scripting
    gettext* : string ## gettext string
      ## Translate string into the current language.
      ## The current language code is stored in the
      ## 'lang' variable in GRUB's environment (see lang).
      ## Translation files in MO format are read from 'locale_dir' (see locale_dir),
      ## usually `/boot/grub/locale`.
    gptsync* : string ## gptsync device [partition[+/-[type]]] …
      ## Disks using the GUID Partition Table (GPT) also have a
      ## legacy Master Boot Record (MBR) partition table for compatibility with the
      ## BIOS and with older operating systems.
      ## The legacy MBR can only represent a limited subset of
      ## GPT partition entries.This command populates the
      ## legacy MBR with the specified partition entries on device.
      ## Up to three partitions may be used.
      ## type is an MBR partition type code;
      ## prefix with '0x' if you want to enter this in hexadecimal.
      ## The separator between partition and
      ## type may be '+' to make the partition active, or
      ## '-' to make it inactive; only one partition may be active.
      ## If both the separator and type are omitted,
      ## then the partition will be inactive. 
    halt* : string ## halt --no-apm
      ## The command halts the computer.
      ## If the --no-apm option is specified,
      ## no APM BIOS call is performed.
      ## Otherwise, the computer is shut down using APM.
    hashsum* : string ## hashsum --hash hash --keep-going --uncompress --check file [--prefix dir]|file …
      ## Compute or verify file hashes.
      ## Hash type is selected with option --hash.
      ## Supported hashes are:
      ## 'adler32',
      ## 'crc64',
      ## 'crc32',
      ## 'crc32rfc1510',
      ## 'crc24rfc2440',
      ## 'md4',
      ## 'md5',
      ## 'ripemd160',
      ## 'sha1',
      ## 'sha224',
      ## 'sha256',
      ## 'sha512',
      ## 'sha384',
      ## 'tiger192',
      ## 'tiger',
      ## 'tiger2',
      ## 'whirlpool'.
      ## Option --uncompress uncompresses files before computing hash.
      ## When list of files is given,
      ## hash of each file is computed and printed,
      ## followed by file name, each file on a new line.
      ## When option --check is given,
      ## it points to a file that contains list of
      ## hash name pairs in the same format as used by UNIX md5sum command.
      ## Option --prefix may be used to give directory where files are located.
      ## Hash verification stops after the first mismatch was
      ## found unless option --keep-going was given.
      ## The exit code $? is set to 0 if hash verification is successful.
      ## If it fails, $? is set to a nonzero value.
    help* : string ## help [pattern …]
      ## Display helpful information about builtin commands.
      ## If you do not specify pattern,
      ## this command shows short descriptions of all available commands.
      ## If you specify any patterns,
      ## it displays longer information about each of the
      ## commands whose names begin with those patterns.
    initrd* : string ## initrd file [file …]
      ## Load, in order, all initial ramdisks for a Linux kernel image, and
      ## set the appropriate parameters in the Linux setup area in memory.
      ## This may only be used after the linux command (see linux) has been run.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#GNU_002fLinux
    initrd16* : string ## initrd16 file [file …]
      ## Load, in order, all initial ramdisks for a
      ## Linux kernel image to be booted in 16-bit mode, and
      ## set the appropriate parameters in the Linux setup area in memory.
      ## This may only be used after the linux16 command (see linux16) has been run.
      ## See also GNU/Linux.
      ## This command is only available on x86 systems.
    insmod* : string ## insmod module
      ## Insert the dynamic GRUB module called module.
    keystatus* : string ## keystatus [--shift] [--ctrl] [--alt]
      ## Return true if the Shift, Control, or Alt modifier keys are held down,
      ## as requested by options.
      ## This is useful in scripting, to
      ## allow some user control over behaviour without having to wait for a keypress.
      ## Checking key modifier status is only supported on some platforms.
      ## If invoked without any options, the
      ## keystatus command returns true if and
      ## only if checking key modifier status is supported.
    linux* : string ## linux file …
      ## Load a Linux kernel image from file.
      ## The rest of the line is passed verbatim as the kernel command-line.
      ## Any initrd must be reloaded after using this command (see initrd).
      ## On x86 systems, the kernel will be booted using the 32-bit boot protocol.
      ## Note that this means that the 'vga=' boot option will not work;
      ## if you want to set a special video mode,
      ## you will need to use GRUB commands such as
      ## 'set gfxpayload=1024x768' or 'set gfxpayload=keep'
      ## (to keep the same mode as used in GRUB) instead.
      ## GRUB can automatically detect some uses of 'vga=' and
      ## translate them to appropriate settings of 'gfxpayload'.
      ## The linux16 command (see linux16) avoids this restriction.
    linux16* : string ## linux16 file …
      ## Load a Linux kernel image from file in 16-bit mode.
      ## The rest of the line is passed verbatim as the kernel command-line.
      ## Any initrd must be reloaded after using this command (see initrd16).
      ## The kernel will be booted using the traditional 16-bit boot protocol.
      ## As well as bypassing problems with 'vga=' described in linux, this
      ## permits booting some other programs that implement the Linux boot protocol for the
      ## sake of convenience.
      ## This command is only available on x86 systems.
    listEnv* : string ## list_env [--file file]
      ## List all variables in the environment block file.
      ## The --file option overrides the default location of the environment block.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Environment-block
    listTrusted* : string ## list_trusted
      ## List all public keys trusted by GRUB for validating signatures.
      ## The output is in GPG's v4 key fingerprint format (i.e., the output of gpg --fingerprint).
      ## The least significant four bytes (last eight hexadecimal digits)
      ## can be used as an argument to distrust (see distrust).
      ## See Using digital signatures, for more information about uses for these keys.
    loadEnv* : string ## load_env [--file file] [--skip-sig] [whitelisted_variable_name] …
      ## Load all variables from the environment block file into the environment.
      ## See Environment block.
      ## The --file option overrides the default location of the environment block.
      ## The --skip-sig option skips signature checking even when the value of
      ## environment variable check_signatures is set to enforce (see check_signatures).
      ## If one or more variable names are provided as arguments,
      ## they are interpreted as a whitelist of variables to load from the environment block file.
      ## Variables set in the file but not present in the whitelist are ignored.
      ## The --skip-sig option should be used with care, and
      ## should always be used in concert with a whitelist of acceptable variables
      ## whose values should be set.
      ## Failure to employ a carefully constructed whitelist could result in reading a
      ## malicious value into critical environment variables from the file,
      ## such as setting check_signatures=no, modifying prefix to boot from an
      ## unexpected location or not at all, etc.
      ## When used with care, --skip-sig and the whitelist enable an administrator to
      ## configure a system to boot only signed configurations, but to
      ## allow the user to select from among multiple configurations, and to
      ## enable 'one-shot' boot attempts and 'savedefault' behavior.
      ## See Using digital signatures, for more information.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Using-digital-signatures
    loadfont* : string ## loadfont file …
      ## Load specified font files.
      ## Unless absolute pathname is given,
      ## file is assumed to be in directory '$prefix/fonts'
      ## with suffix '.pf2' appended.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Theme-file-format
    loopback* : string ## loopback [-d] device file
      ## Make the device named device correspond to the contents of the filesystem image in file.
      ## With the -d option, delete a device previously created using this command. 
    ls* : string ## ls [arg …]
      ## With no arguments, print all devices known to GRUB.
      ## If the argument is a device name enclosed in parentheses (see Device syntax), then
      ## print the name of the filesystem of that device.
      ## If the argument is a directory given as an absolute file name
      ## (see File name syntax), then
      ## list the contents of that directory.
    lsfonts* : string ## lsfonts
      ## List loaded fonts.
    lsmod* : string ## lsmod
      ## Show list of loaded modules. 
    md5sum* : string ## md5sum arg …
      ## Alias for hashsum --hash md5 arg …. See command hashsum (see hashsum) for full description.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#hashsum
    module* : string ## module [--nounzip] file [arguments]
      ## Load a module for multiboot kernel image.
      ## The rest of the line is passed verbatim as the module command line.
    multiboot* : string ## multiboot [--quirk-bad-kludge] [--quirk-modules-after-kernel] file …
      ## Load a multiboot kernel image from file.
      ## The rest of the line is passed verbatim as the kernel command-line.
      ## Any module must be reloaded after using this command (see module).
      ## Some kernels have known problems.
      ## You need to specify --quirk-* for those.
      ## --quirk-bad-kludge is a problem seen in several products that
      ## they include loading kludge information with invalid data in ELF file.
      ## GRUB prior to 0.97 and some custom builds preferred
      ## ELF information while 0.97 and GRUB 2 use kludge.
      ## Use this option to ignore kludge.
      ## Known affected systems:
      ## old Solaris,
      ## SkyOS.
      ## --quirk-modules-after-kernel is needed for kernels which load at
      ## relatively high address e.g. 16MiB mark and
      ## can't cope with modules stuffed between 1MiB mark and
      ## beginning of the kernel.
      ## Known afftected systems:
      ## VMWare.
    nativedisk* : string ## nativedisk
      ## Switch from firmware disk drivers to native ones.
      ## Really useful only on platforms where both firmware and
      ## native disk drives are available.
      ## Currently i386-pc, i386-efi, i386-ieee1275 and x86_64-efi.
    normal* : string ## normal [file]
      ## Enter normal mode and display the GRUB menu.
      ## In normal mode, commands, filesystem modules, and
      ## cryptography modules are automatically loaded, and
      ## the full GRUB script parser is available.
      ## Other modules may be explicitly loaded using insmod (see insmod).
      ## If a file is given, then commands will be read from that file.
      ## Otherwise, they will be read from $prefix/grub.cfg if it exists.
      ## normal may be called from within normal mode,
      ## creating a nested environment.
      ## It is more usual to use configfile (see configfile) for this.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#configfile
    normalExit* : string ## normal_exit
      ## Exit normal mode (see normal).
      ## If this instance of normal mode was not
      ## nested within another one, then return to rescue mode.
    parttool* : string ## parttool partition commands
      ## Make various modifications to partition table entries.
      ##
      ## Each command is either a boolean option,
      ## in which case it must be followed with '+' or '-'
      ## (with no intervening space) to enable or disable that option, or
      ## else it takes a value in the form
      ## 'command=value'.
      ##
      ## Currently, parttool is only useful on DOS partition tables
      ## (also known as Master Boot Record, or MBR).
      ## On these partition tables, the following commands are available:
      ## 'boot' (boolean)
      ##   When enabled, this makes the selected partition be the
      ##   active (bootable) partition on its disk,
      ##   clearing the active flag on all other partitions.
      ##   This command is limited to primary partitions.
      ## 'type' (value)Change the type of an existing partition.
      ##   The value must be a number in the range 0-0xFF
      ##   (prefix with '0x' to enter it in hexadecimal).
      ## 'hidden' (boolean)When enabled, this
      ##   hides the selected partition by setting the
      ##   hidden bit in its partition type code;
      ##   when disabled, unhides the selected partition by
      ##   clearing this bit. This is useful only when bootingDOS or
      ##   Windows and multiple primary FAT partitions exist in one disk.
      ##   See also DOS/Windows.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#DOS_002fWindows
    passwordPbkdf2* : string ## password_pbkdf2 user hashed-password
      ## Define a user named user with password hash hashed-password.
      ## Use grub-mkpasswd-pbkdf2 (see Invoking grub-mkpasswd-pbkdf2) to
      ## generate password hashes.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Invoking-grub_002dmkpasswd_002dpbkdf2
    play* : string ## play file | tempo [pitch1 duration1] [pitch2 duration2] …
      ## If the argument is a file name (see File name syntax),
      ## play the tune recorded in it.
      ## The file format is first the tempo as an unsigned 32bit little-endian number, then
      ## pairs of unsigned 16bit little-endian numbers for pitch and duration pairs.
      ## If the arguments are a series of numbers, play the inline tune.
      ## The tempo is the base for all note durations.
      ## 60 gives a 1-second base, 120 gives a half-second base, etc.
      ## Pitches are Hz. Set pitch to 0 to produce a rest.
    probe* : string ## probe [--set var] --driver|--partmap|--fs|--fs-uuid|--label|--part-uuid device
      ## Retrieve device information.
      ## If option --set is given, assign result to variable var,
      ## otherwise print information on the screen.
      ## The option --part-uuid is currently only implemented for
      ## MSDOS and GPT formatted disks. 
    rdmsr* : string ## rdmsr 0xADDR [-v VARNAME]
      ## Read a model-specific register at address 0xADDR.
      ## If the parameter -v is used and an
      ## environment variable VARNAME is given, set
      ## that environment variable to the value that was read.
      ## Please note that on SMP systems, reading from a MSR that has a
      ## scope per hardware thread,
      ## implies that the value that is returned only applies to the
      ## particular cpu/core/thread that runs the command. Also,
      ## if you specify a reserved or unimplemented MSR address,
      ## it will cause a general protection exception
      ## (which is not currently being handled) and
      ## the system will reboot.
    read* : string ## read [var]
      ## Read a line of input from the user.
      ## If an environment variable var is given,
      ## set that environment variable to the line of
      ## input that was read, with no terminating newline.
    reboot* : string ## reboot
      ## Reboot the computer.
    regexp* : string ## regexp [--set [number:]var] regexp string
      ## Test if regular expression regexp matches string.
      ## Supported regular expressions are
      ## POSIX.2 Extended Regular Expressions.
      ## If option --set is given,
      ## store numberth matched subexpression in variable var.
      ## Subexpressions are numbered in order of their
      ## opening parentheses starting from '1'.
      ## number defaults to '1'.
    rmmod* : string ## rmmod module
      ## Remove a loaded module
    saveEnv* : string ## save_env [--file file] var …
      ## Save the named variables from the environment to the environment block file.
      ## The --file option overrides the default location of the environment block.
      ## This command will operate successfully even when
      ## environment variable check_signatures is set to enforce
      ## (see check_signatures), since it writes to disk and does not
      ## alter the behavior of GRUB based on any contents of
      ## disk that have been read.
      ## It is possible to modify a digitally signed environment block file from
      ## within GRUB using this command, such that its signature will no longer be
      ## valid on subsequent boots.
      ## Care should be taken in such advanced configurations to
      ## avoid rendering the system unbootable.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Using-digital-signatures
    search* : string ## search [--file|--label|--fs-uuid] [--set [var]] [--no-floppy] name
      ## Search devices by file (-f, --file),
      ## filesystem label (-l, --label), or
      ## filesystem UUID (-u, --fs-uuid).
      ## If the --set option is used, the
      ## first device found is set as the
      ## value of environment variable var.
      ## The default variable is 'root'.
      ## The --no-floppy option prevents searching floppy devices,
      ## which can be slow.
      ## The 'search.file',
      ## 'search.fs_label', and
      ## 'search.fs_uuid'
      ## commands are aliases for
      ## 'search --file',
      ## 'search --label', and
      ## 'search --fs-uuid' respectively. 
    sendkey* : string ## sendkey [--num|--caps|--scroll|--insert|--pause|--left-shift|--right-shift|--sysrq|--numkey|--capskey|--scrollkey|--insertkey|--left-alt|--right-alt|--left-ctrl|--right-ctrl 'on'|'off']… [no-led] keystroke
      ## Insert keystrokes into the keyboard buffer when booting.
      ## Sometimes an operating system or chainloaded boot loader requires particular keys to be pressed:
      ## for example, one might need to press a particular key to
      ## enter "safe mode", or when
      ## chainloading another boot loader one might
      ## send keystrokes to it to navigate its menu.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#sendkey
    `set`* : string ## set [envvar=value]
      ## Set the environment variable envvar to value.
      ## If invoked with no arguments,
      ## print all environment variables with their values.
    sha1sum* : string ## sha1sum arg …
      ## Alias for hashsum --hash sha1 arg ….
      ## See command hashsum (see hashsum) for full description.
    sha256sum* : string ## sha256sum arg …
      ## Alias for hashsum --hash sha256 arg ….
      ## See command hashsum (see hashsum) for full description.
    sha512sum* : string ## sha512sum arg …
      ## Alias for hashsum --hash sha512 arg …. See command hashsum (see hashsum) for full description. 
    sleep* : string ## sleep [--verbose] [--interruptible] count
      ## Sleep for count seconds.
      ## If option --interruptible is given,
      ## allow pressing ESC, F4 or holding down SHIFT to interrupt sleep.
      ## With --verbose show countdown of remaining seconds.
      ## Exit code is set to 0 if timeout expired and to
      ## 1 if timeout was interrupted using any of the mentioned keys.
    smbios* : string ## smbios [--type type] [--handle handle] [--match match] (--get-byte | --get-word | --get-dword | --get-qword | --get-string | --get-uuid) offset [--set variable]
      ## Retrieve SMBIOS information.
      ## The smbios command returns the value of a field in an SMBIOS structure.
      ## The following options determine which structure to select.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#smbios
    source* : string ## source file
      ## Read file as a configuration file,
      ## as if its contents had been incorporated directly into the sourcing file.
      ## Unlike configfile (see configfile), this executes the
      ## contents of file without changing context:
      ## any environment variable changes made by the commands in
      ## file will be preserved after source returns, and
      ## the menu will not be shown immediately.
    test* : string ## test `expression`
      ## Evaluate expression and return zero exit status if result is true, non zero status otherwise.
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#test
    `true`* : string ## true
      ## Do nothing, successfully.
      ## This is mainly useful in control constructs such as if and while (see Shell-like scripting).
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Shell_002dlike-scripting
    trust* : string ## trust [--skip-sig] pubkey_file
      ## Read public key from pubkey_file and
      ## add it to GRUB's internal list of trusted public keys.
      ## These keys are used to validate digital signatures when
      ## environment variable check_signatures is set to enforce.
      ## Note that if check_signatures is set to enforce when trust executes, then
      ## pubkey_file must itself be properly signed.
      ## The --skip-sig option can be used to disable signature-checking when
      ## reading pubkey_file itself.
      ## It is expected that --skip-sig is useful for testing and
      ## manual booting.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Using-digital-signatures
    unset* : string ## unset envvar
      ## Unset the environment variable envvar.
    verifyDetached* : string ## verify_detached [--skip-sig] file signature_file [pubkey_file]
      ## Verifies a GPG-style detached signature,
      ## where the signed file is file, and the
      ## signature itself is in file signature_file.
      ## Optionally, a specific public key to use can be
      ## specified using pubkey_file.
      ## When environment variable check_signatures is set to enforce, then
      ## pubkey_file must itself be properly signed by an already-trusted key.
      ## An unsigned pubkey_file can be loaded by specifying --skip-sig.
      ## If pubkey_file is omitted, then public keys from GRUB's trusted keys
      ## (see list_trusted, see trust, and see distrust) are tried.
      ## Exit code $? is set to 0 if the signature validates successfully.
      ## If validation fails, it is set to a non-zero value.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Using-digital-signatures
    videoinfo* : string ## videoinfo [[WxH]xD]
      ## List available video modes. If resolution is given, show only matching modes.
    wrmsr* : string ## wrmsr 0xADDR 0xVALUE
      ## Write a 0xVALUE to a model-specific register at address 0xADDR.
      ## Please note that on SMP systems, writing to a MSR that has a
      ## scope per hardware thread, implies that the
      ## value that is written only applies to the
      ## particular cpu/core/thread that runs the command.
      ## Also, if you specify a reserved or unimplemented MSR address,
      ## it will cause a general protection exception
      ## (which is not currently being handled) and the
      ## system will reboot.Note: The command is not
      ## allowed when lockdown is enforced (see Lockdown).
      ## This is done to prevent subverting various security mechanisms.
      ##
      ## https://www.gnu.org/software/grub/manual/grub/grub.html#Lockdown
    xenHypervisor* : string ## xen_hypervisor file [arguments] …
      ## Load a Xen hypervisor binary from file.
      ## The rest of the line is passed verbatim as the kernel command-line.
      ## Any other binaries must be reloaded after using this command.
      ## This command is only available on AArch64 systems.
    xenModule* : string ## xen_module [--nounzip] file [arguments]
      ## Load a module for xen hypervisor at the booting process of xen.
      ## The rest of the line is passed verbatim as the module command line.
      ## Modules should be loaded in the following order:
      ##   - dom0 kernel image
      ##   - dom0 ramdisk if present
      ##   - XSM policy if present
      ## This command is only available on AArch64 systems.