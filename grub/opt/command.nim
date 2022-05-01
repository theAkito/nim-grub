##[

  These commands are usable in the command-line and in menu entries.


  Visit the official GRUB documentation for more information.

  https://www.gnu.org/software/grub/manual/grub/grub.html#Command_002dline-and-menu-entry-commands
]##

import
  kind/commandtype,
  std/[
    options,
    strtabs,
    tables
  ]

const
  ## Actual command names, as identified by GRUB2.
  nameAcpi = "acpi"
  nameAuthenticate = "authenticate"
  nameBackgroundColor = "background_color"
  nameBackgroundImage = "background_image"
  nameBadRAM = "badram"
  nameBlocklist = "blocklist"
  nameBoot = "boot"
  nameCat = "cat"
  nameChainloader = "chainloader"
  nameClear = "clear"
  nameCmosClean = "cmosclean"
  nameCmosDump = "cmosdump"
  nameCmosTest = "cmostest"
  nameCmp = "cmp"
  nameConfigFile = "configfile"
  nameCpuID = "cpuid"
  nameCRC = "crc"
  nameCryptoMount = "cryptomount"
  nameCutmem = "cutmem"
  nameDate = "date"
  nameDeviceTree = "devicetree"
  nameDistrust = "distrust"
  nameDriveMap = "drivemap"
  nameEcho = "echo"
  nameEval = "eval"
  nameExport = "export"
  nameFalse = "false"
  nameGetText = "gettext"
  nameGptSync = "gptsync"
  nameHalt = "halt"
  nameHashsum = "hashsum"
  nameHelp = "help"
  nameInitRD = "initrd"
  nameInitRD16 = "initrd16"
  nameInsmod = "insmod"
  nameKeyStatus = "keystatus"
  nameLinux = "linux"
  nameLinux16 = "linux16"
  nameListENV = "list_env"
  nameListTrusted = "list_trusted"
  nameLoadENV = "load_env"
  nameLoadFont = "loadfont"
  nameLoopback = "loopback"
  nameLs = "ls"
  nameListFonts = "lsfonts"
  nameListMod = "lsmod"
  nameMD5sum = "md5sum"
  nameModule = "module "
  nameMultiboot = "bamultibootckground_color"
  nameNativeDisk = "nativedisk"
  nameNormal = "normal"
  nameNormalExit = "normal_exit"
  namePartTool = "parttool"
  namePassword = "password"
  namePasswordPbkdf2 = "password_pbkdf2"
  namePlay = "play"
  nameProbe = "probe"
  nameRdmsr = "rdmsr"
  nameRead = "read"
  nameReboot = "reboot"
  nameRegexp = "regexp"
  nameRmmod = "rmmod"
  nameSaveENV = "save_env"
  nameSearch = "search"
  nameSendKey = "sendkey"
  nameSet = "set"
  nameSha1sum = "sha1sum"
  nameSha256sum = "sha256sum"
  nameSha512sum = "sha512sum"
  nameSleep = "sleep"
  nameSmBios = "smbios"
  nameSource = "source"
  nameTest = "test"
  nameTrue = "true"
  nameTrust = "trust"
  nameUnset = "unset"
  nameVerifyDetached = "verify_detached"
  nameVideoInfo = "videoinfo"
  nameWrmsr = "wrmsr"
  nameXenHypervisor = "xen_hypervisor"
  nameXenModule = "xen_module"

type
  Command          * = ref object of RootObj
    name           * : string ## Actual command name, as identified by GRUB2.
  Acpi             * = ref object of Command
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
  Authenticate     * = ref object of Command
    ## Check whether user is in userlist or listed in the value of variable 'superusers'.
    ## See see superusers for valid user list format.
    ## If 'superusers' is empty, this command returns true.
    ##
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#superusers
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#Security
    userlist       * : seq[string]
  BackgroundColor  * = ref object of Command
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
    color          * : string
  BackgroundImage  * = ref object of Command
    ## Load background image for active terminal from file.
    ## Image is stretched to fill up entire screen
    ## unless option --mode 'normal' is given.
    ## Without arguments remove currently loaded background image.
    ## Background image can be changed only
    ## when using 'gfxterm' for terminal output.
    mode           * : Option[BackgroundImageMode]
    file           * : Option[string]
  BadRAM           * = ref object of Command
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
    addrToMask     * : StringTableRef
  Blocklist        * = ref object of Command
    ## Print a block list (see Block list syntax) for file.
    file           * : string
  Boot             * = ref object of Command
    ## Boot the OS or chain-loader which has been loaded.
    ## Only necessary if running the fully interactive command-line
    ## (it is implicit at the end of a menu entry).
  Cat              * = ref object of Command
    ## If the --dos option is used,
    ## then carriage return / new line pairs will be
    ## displayed as a simple new line.
    ## Otherwise, the carriage return will be
    ## displayed as a control character ('<d>') to
    ## make it easier to see when boot problems are caused by a
    ## file formatted using DOS-style line endings.
    dos            * : Option[bool]
    file           * : string
  Chainloader      * = ref object of Command
    ## Load file as a chain-loader.
    ## Like any other file loaded by the filesystem code,
    ## it can use the blocklist notation (see Block list syntax) to
    ## grab the first sector of the current partition with '+1'.
    ## If you specify the option --force, then load file forcibly,
    ## whether it has a correct signature or not.
    ## This is required when you want to load a
    ## defective boot loader, such as SCO UnixWare 7.1.
    force          * : Option[bool]
    file           * : string
  Clear            * = ref object of Command
    ## Clear the screen.
  CmosClean        * = ref object of Command
    ## Clear value of bit in CMOS at location byte:bit.
    ## This command is available only on platforms that support CMOS.
    byte           * : byte
    bit            * : byte
  CmosDump         * = ref object of Command
    ## Dump full CMOS contents as hexadecimal values.
    ## This command is available only on platforms that support CMOS.
  CmosTest         * = ref object of Command
    ## Test value of bit in CMOS at location byte:bit.
    ## Exit status is zero if bit is set, non zero otherwise.
    ## This command is available only on platforms that support CMOS.
    byte           * : byte
    bit            * : byte
  Cmp              * = ref object of Command
    ## Compare the file file1 with the file file2. If they differ in size,
    ## print the sizes like this:Differ in size:
    ## 0x1234 [foo], 0x4321 [bar]
    ## If the sizes are equal but the bytes at an offset differ, then
    ## print the bytes like this:
    ## Differ at the offset 777:
    ## 0xbe [foo], 0xef [bar]
    ## If they are completely identical, string will be printed.
    file1          * : string
    file2          * : string
  ConfigFile       * = ref object of Command
    ## Load file as a configuration file.
    ## If file defines any menu entries,
    ## then show a menu containing them immediately.
    ## Any environment variable changes made by the
    ## commands in file will not be preserved after configfile returns.
    file           * : string
  CpuID            * = ref object of Command
    ## Check for CPU features.
    ## This command is only available on x86 systems.
    ## With the -l option, return true if the CPU
    ## supports long mode (64-bit).
    ## With the -p option, return true if the CPU
    ## supports Physical Address Extension (PAE).
    ## If invoked without options, this command
    ## currently behaves as if it had been invoked with -l.
    ## This may change in the future.
    long           * : Option[bool]
    pae            * : Option[bool]
  CRC              * = ref object of Command
    ## Alias for hashsum --hash crc32 arg …. See command hashsum (see hashsum) for full description.
    #TODO
  CryptoMount      * = ref object of Command
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
    device         * : Option[string]
    uuid           * : Option[string]
    all            * : Option[bool]
    boot           * : Option[bool]
  Cutmem           * = ref object of Command
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
    #TODO
  Date             * = ref object of Command
    ## With no arguments, print the current date and time.
    ## Otherwise, take the current date and time,
    ## change any elements specified as arguments, and
    ## set the result as the new date and time. For example,
    ## 'date 01-01' will set the current month and day to January 1,
    ## but leave the year, hour, minute, and second unchanged.
    year           * : Option[int]
    month          * : Option[int]
    day            * : Option[int]
    hour           * : Option[int]
    minute         * : Option[int]
    second         * : Option[int]
  DeviceTree       * = ref object of Command
    ## Load a device tree blob (.dtb) from a filesystem, for
    ## later use by a Linux kernel.
    ## Does not perform merging with any device tree supplied by firmware, but
    ## rather replaces it completely.
    ## Note: The command is not allowed when lockdown is enforced (see Lockdown).
    ## This is done to prevent subverting various security mechanisms.
    file           * : string
  Distrust         * = ref object of Command
    ## Remove public key pubkey_id from GRUB's keyring of trusted keys.
    ## pubkey_id is the last four bytes (eight hexadecimal digits) of the
    ## GPG v4 key id, which is also the output of list_trusted (see list_trusted).
    ## Outside of GRUB, the key id can be obtained using gpg --fingerprint).
    ## These keys are used to validate signatures when environment variable
    ## check_signatures is set to enforce (see check_signatures), and
    ## by some invocations of verify_detached (see verify_detached).
    ## See Using digital signatures, for more information.
    pubkeyID       * : string
  DriveMap         * = ref object of Command
    ## Without options, map the drive from_drive to the drive to_drive.
    ## This is necessary when you chain-load some operating systems,
    ## such as DOS, if such an OS resides at a non-first drive.
    ## For convenience, any partition suffix on the drive is ignored, so
    ## you can safely use ${root} as a drive specification.With the -s option,
    ## perform the reverse mapping as well,
    ## swapping the two drives.
    ## With the -l option, list the current mappings.
    ## With the -r option, reset all mappings to the default values.
    fromDrive      * : Option[string]
    toDrive        * : Option[string]
    list           * : Option[bool]
    swap           * : Option[bool]
    reset          * : Option[bool]
  Echo             * = ref object of Command
    ## Display the requested text and, unless the -n option is used, a
    ## trailing new line.
    ## If there is more than one string,
    ## they are separated by spaces in the output.
    ## As usual in GRUB commands, variables may be substituted using '${var}'.
    ##
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#echo
    content        * : Option[string]
    enableEscapes  * : Option[bool]
    noNewline      * : Option[bool]
  Eval             * = ref object of Command
    ## Concatenate arguments together using single space as
    ## separator and evaluate result as sequence of GRUB commands.
    commands       * : seq[Command]
  Export           * = ref object of Command
    ## Export the environment variable envvar.
    ## Exported variables are visible to
    ## subsidiary configuration files loaded using configfile.
    env            * : string
  False            * = ref object of Command
    ## Do string, unsuccessfully.
    ## This is mainly useful in control constructs such as if and while (see Shell-like scripting).
    ##
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#Shell_002dlike-scripting
  GetText          * = ref object of Command
    ## Translate string into the current language.
    ## The current language code is stored in the
    ## 'lang' variable in GRUB's environment (see lang).
    ## Translation files in MO format are read from 'locale_dir' (see locale_dir),
    ## usually `/boot/grub/locale`.
    content        * : string
  GptSync          * = ref object of Command
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
    device         * : Option[string]
    partType       * : Option[Table[string, GptSyncStatus]] # Contains up to three entries.
  Halt             * = ref object of Command
    ## The command halts the computer.
    ## If the --no-apm option is specified,
    ## no APM BIOS call is performed.
    ## Otherwise, the computer is shut down using APM.
    noAPM          * : Option[bool]
  Hashsum          * = ref object of Command
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
    file           * : Option[seq[string]]
    hash           * : Option[HashType]
    check          * : Option[string]
    dir            * : Option[string]
    keepGoing      * : Option[bool]
    uncompress     * : Option[bool]
  Help             * = ref object of Command
    ## Display helpful information about builtin commands.
    ## If you do not specify pattern,
    ## this command shows short descriptions of all available commands.
    ## If you specify any patterns,
    ## it displays longer information about each of the
    ## commands whose names begin with those patterns.
    pattern        * : Option[Command] # Applies command's name.
  InitRD             * = ref object of Command
    ## Load, in order, all initial ramdisks for a Linux kernel image, and
    ## set the appropriate parameters in the Linux setup area in memory.
    ## This may only be used after the linux command (see linux) has been run.
    ##
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#GNU_002fLinux
    files          * : Option[seq[string]]
  InitRD16         * = ref object of Command
    ## Load, in order, all initial ramdisks for a
    ## Linux kernel image to be booted in 16-bit mode, and
    ## set the appropriate parameters in the Linux setup area in memory.
    ## This may only be used after the linux16 command (see linux16) has been run.
    ## See also GNU/Linux.
    ## This command is only available on x86 systems.
    files          * : Option[seq[string]]
  Insmod           * = ref object of Command
    ## Insert the dynamic GRUB module called module.
  KeyStatus        * = ref object of Command
    ## Return true if the Shift, Control, or Alt modifier keys are held down,
    ## as requested by options.
    ## This is useful in scripting, to
    ## allow some user control over behaviour without having to wait for a keypress.
    ## Checking key modifier status is only supported on some platforms.
    ## If invoked without any options, the
    ## keystatus command returns true if and
    ## only if checking key modifier status is supported.
    shift          * : Option[bool]
    ctrl           * : Option[bool]
    alt            * : Option[bool]
  Linux            * = ref object of Command
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
    file           * : string
    kernelCmd      * : Option[seq[string]]
  Linux16          * = ref object of Command
    ## Load a Linux kernel image from file in 16-bit mode.
    ## The rest of the line is passed verbatim as the kernel command-line.
    ## Any initrd must be reloaded after using this command (see initrd16).
    ## The kernel will be booted using the traditional 16-bit boot protocol.
    ## As well as bypassing problems with 'vga=' described in linux, this
    ## permits booting some other programs that implement the Linux boot protocol for the
    ## sake of convenience.
    ## This command is only available on x86 systems.
    file           * : string
    kernelCmd      * : Option[seq[string]]
  ListENV          * = ref object of Command
    ## List all variables in the environment block file.
    ## The --file option overrides the default location of the environment block.
    ##
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#Environment-block
    file           * : Option[string]
  ListTrusted      * = ref object of Command
    ## List all public keys trusted by GRUB for validating signatures.
    ## The output is in GPG's v4 key fingerprint format (i.e., the output of gpg --fingerprint).
    ## The least significant four bytes (last eight hexadecimal digits)
    ## can be used as an argument to distrust (see distrust).
    ## See Using digital signatures, for more information about uses for these keys.
  LoadENV          * = ref object of Command
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
    file           * : Option[string]
    skipSig        * : Option[bool]
    whitelist      * : Option[seq[string]]
  LoadFont         * = ref object of Command
    ## Load specified font files.
    ## Unless absolute pathname is given,
    ## file is assumed to be in directory '$prefix/fonts'
    ## with suffix '.pf2' appended.
    ##
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#Theme-file-format
    files          * : Option[seq[string]]
  Loopback         * = ref object of Command
    ## Make the device named device correspond to the contents of the filesystem image in file.
    ## With the -d option, delete a device previously created using this command.
    device         * : string
    file           * : Option[string]
    delete         * : Option[bool]
  Ls               * = ref object of Command
    ## With no arguments, print all devices known to GRUB.
    ## If the argument is a device name enclosed in parentheses (see Device syntax), then
    ## print the name of the filesystem of that device.
    ## If the argument is a directory given as an absolute file name
    ## (see File name syntax), then
    ## list the contents of that directory.
    arguments      * : Option[seq[string]]
  ListFonts        * = ref object of Command
    ## List loaded fonts.
  LsFonts          * = ListFonts
    ## List loaded fonts.
  ListMod          * = ref object of Command
    ## Show list of loaded modules.
  LsMod            * = ListMod
    ## Show list of loaded modules.
  MD5sum           * = ref object of Command
    ## Alias for hashsum --hash md5 arg …. See command hashsum (see hashsum) for full description.
    ##
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#hashsum
    #TODO
  Module           * = ref object of Command
    ## Load a module for multiboot kernel image.
    ## The rest of the line is passed verbatim as the module command line.
    file           * : string
    nounzip        * : Option[bool]
    moduleCmd      * : Option[seq[string]]
  Multiboot        * = ref object of Command
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
    file           * : string
    quirkBadKludge * : Option[bool]
    quirkKernel    * : Option[bool]
    kernelCmd      * : Option[seq[string]]
  NativeDisk       * = ref object of Command
    ## Switch from firmware disk drivers to native ones.
    ## Really useful only on platforms where both firmware and
    ## native disk drives are available.
    ## Currently i386-pc, i386-efi, i386-ieee1275 and x86_64-efi.
  Normal           * = ref object of Command
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
    file           * : Option[string]
  NormalExit       * = ref object of Command
    ## Exit normal mode (see normal).
    ## If this instance of normal mode was not
    ## nested within another one, then return to rescue mode.
  PartTool         * = ref object of Command
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
    partition      * : string
    commands       * : Table[PartToolCommand, string]
  Password         * = ref object of Command
    ## Define a user named user with password clear-password.
    user           * : string
    clearPassword  * : string
  PasswordPbkdf2   * = ref object of Command
    ## Define a user named user with password hash hashed-password.
    ## Use grub-mkpasswd-pbkdf2 (see Invoking grub-mkpasswd-pbkdf2) to
    ## generate password hashes.
    ##
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#Invoking-grub_002dmkpasswd_002dpbkdf2
    user           * : string
    hashedPassword * : string
  Play             * = ref object of Command
    ## If the argument is a file name (see File name syntax),
    ## play the tune recorded in it.
    ## The file format is first the tempo as an unsigned 32bit little-endian number, then
    ## pairs of unsigned 16bit little-endian numbers for pitch and duration pairs.
    ## If the arguments are a series of numbers, play the inline tune.
    ## The tempo is the base for all note durations.
    ## 60 gives a 1-second base, 120 gives a half-second base, etc.
    ## Pitches are Hz. Set pitch to 0 to produce a rest.
    file           * : Option[string]
    tempo          * : string
    pitchToDuration* : Option[StringTableRef]
    inlineTune     * : Option[seq[string]]
  Probe            * = ref object of Command
    ## Retrieve device information.
    ## If option --set is given, assign result to variable var,
    ## otherwise print information on the screen.
    ## The option --part-uuid is currently only implemented for
    ## MSDOS and GPT formatted disks.
    set            * : Option[string]
    driver         * : Option[bool]
    partmap        * : Option[bool]
    fs             * : Option[bool]
    fsUUID         * : Option[bool]
    partUUID       * : Option[bool]
    label          * : Option[bool]
  Rdmsr            * = ref object of Command
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
    address        * : Option[string]
    variable       * : Option[string]
  Read             * = ref object of Command
    ## Read a line of input from the user.
    ## If an environment variable var is given,
    ## set that environment variable to the line of
    ## input that was read, with no terminating newline.
    variable       * : Option[string]
  Reboot           * = ref object of Command
    ## Reboot the computer.
  Regexp           * = ref object of Command
    ## Test if regular expression regexp matches string.
    ## Supported regular expressions are
    ## POSIX.2 Extended Regular Expressions.
    ## If option --set is given,
    ## store numberth matched subexpression in variable var.
    ## Subexpressions are numbered in order of their
    ## opening parentheses starting from '1'.
    ## number defaults to '1'.
    regexp         * : string
    content        * : string
    set            * : Option[string]
  Rmmod            * = ref object of Command
    ## Remove a loaded module.
    module         * : string
  SaveENV          * = ref object of Command
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
    file           * : Option[string]
    variable       * : Option[seq[string]]
  Search           * = ref object of Command
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
    id             * : string
    file           * : Option[bool]
    label          * : Option[bool]
    fsUUID         * : Option[bool]
    noFloppy       * : Option[bool]
    set            * : Option[string]
  SendKey          * = ref object of Command
    ## Insert keystrokes into the keyboard buffer when booting.
    ## Sometimes an operating system or chainloaded boot loader requires particular keys to be pressed:
    ## for example, one might need to press a particular key to
    ## enter "safe mode", or when
    ## chainloading another boot loader one might
    ## send keystrokes to it to navigate its menu.
    ##
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#sendkey
    keystroke      * : string
    num            * : Option[bool]
    caps           * : Option[bool]
    scroll         * : Option[bool]
    insert         * : Option[bool]
    pause          * : Option[bool]
    leftShift      * : Option[bool]
    rightShift     * : Option[bool]
    sysRQ          * : Option[bool]
    numKey         * : Option[bool]
    capsKey        * : Option[bool]
    scrollKey      * : Option[bool]
    insertKey      * : Option[bool]
    leftAlt        * : Option[bool]
    rightAlt       * : Option[bool]
    leftCtrl       * : Option[bool]
    rightCtrl      * : Option[bool] # `on` or `off`
    noLED          * : Option[bool]
  Set              * = ref object of Command
    ## Set the environment variable envvar to value.
    ## If invoked with no arguments,
    ## print all environment variables with their values.
    varToVal       * : Option[StringTableRef]
  Sha1sum          * = ref object of Command
    ## Alias for hashsum --hash sha1 arg ….
    ## See command hashsum (see hashsum) for full description.
    #TODO
  Sha256sum        * = ref object of Command
    ## Alias for hashsum --hash sha256 arg ….
    ## See command hashsum (see hashsum) for full description.
    #TODO
  Sha512sum        * = ref object of Command
    ## Alias for hashsum --hash sha512 arg …. See command hashsum (see hashsum) for full description.
    #TODO
  Sleep            * = ref object of Command
    ## Sleep for count seconds.
    ## If option --interruptible is given,
    ## allow pressing ESC, F4 or holding down SHIFT to interrupt sleep.
    ## With --verbose show countdown of remaining seconds.
    ## Exit code is set to 0 if timeout expired and to
    ## 1 if timeout was interrupted using any of the mentioned keys.
    seconds        * : int
    verbose        * : Option[bool]
    interruptible  * : Option[bool]
  SmBios           * = ref object of Command
    ## Retrieve SMBIOS information.
    ## The smbios command returns the value of a field in an SMBIOS structure.
    ## The following options determine which structure to select.
    ##
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#smbios
    offset         * : string
    set            * : Option[string]
    `type`         * : Option[uint8]
    handle         * : Option[uint16]
    match          * : Option[uint]
    getByte        * : Option[bool]
    getWord        * : Option[bool]
    getDWORD       * : Option[bool]
    getQWORD       * : Option[bool]
    getUUID        * : Option[bool]
    getString      * : Option[bool]
  Source           * = ref object of Command
    ## Read file as a configuration file,
    ## as if its contents had been incorporated directly into the sourcing file.
    ## Unlike configfile (see configfile), this executes the
    ## contents of file without changing context:
    ## any environment variable changes made by the commands in
    ## file will be preserved after source returns, and
    ## the menu will not be shown immediately.
    file           * : string
  Test             * = ref object of Command
    ## Evaluate expression and return zero exit status if result is true, non zero status otherwise.
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#test
    expression     * : string
  True             * = ref object of Command
    ## Do string, successfully.
    ## This is mainly useful in control constructs such as if and while (see Shell-like scripting).
    ##
    ## https://www.gnu.org/software/grub/manual/grub/grub.html#Shell_002dlike-scripting
  Trust            * = ref object of Command
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
    pubkeyFile     * : string
    skipSig        * : Option[bool]
  Unset            * = ref object of Command
    ## Unset the environment variable envvar.
    variable       * : string
  VerifyDetached   * = ref object of Command
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
    file           * : string
    signatureFile  * : string
    pubkeyFile     * : Option[string]
    skipSig        * : Option[bool]
  VideoInfo        * = ref object of Command
    ## List available video modes. If resolution is given, show only matching modes.
    width          * : Option[string]
    height         * : Option[string]
    depth          * : Option[string]
  Wrmsr            * = ref object of Command
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
    address        * : string
    value          * : string
  XenHypervisor    * = ref object of Command
    ## Load a Xen hypervisor binary from file.
    ## The rest of the line is passed verbatim as the kernel command-line.
    ## Any other binaries must be reloaded after using this command.
    ## This command is only available on AArch64 systems.
    file           * : string
    arguments      * : Option[seq[string]]
  XenModule        * = ref object of Command
    ## Load a module for xen hypervisor at the booting process of xen.
    ## The rest of the line is passed verbatim as the module command line.
    ## Modules should be loaded in the following order:
    ##   - dom0 kernel image
    ##   - dom0 ramdisk if present
    ##   - XSM policy if present
    ## This command is only available on AArch64 systems.
    file           * : string
    noUnzip        * : Option[bool]
    arguments      * : Option[seq[string]]

## Instantiate each Command.
func createAcpi*(): Acpi = Acpi(name: nameAcpi)
func createAuthenticate*(): Authenticate = Authenticate(name: nameAuthenticate)
func createBackgroundColor*(): BackgroundColor = BackgroundColor(name: nameBackgroundColor)
func createBackgroundImage*(): BackgroundImage = BackgroundImage(name: nameBackgroundImage)
func createBadRAM*(): BadRAM = BadRAM(name: nameBadRAM)
func createBlocklist*(): Blocklist = Blocklist(name: nameBlocklist)
func createBoot*(): Boot = Boot(name: nameBoot)
func createCat*(): Cat = Cat(name: nameCat)
func createChainloader*(): Chainloader = Chainloader(name: nameChainloader)
func createClear*(): Clear = Clear(name: nameClear)
func createCmosClean*(): CmosClean = CmosClean(name: nameCmosClean)
func createCmosDump*(): CmosDump = CmosDump(name: nameCmosDump)
func createCmosTest*(): CmosTest = CmosTest(name: nameCmosTest)
func createCmp*(): Cmp = Cmp(name: nameCmp)
func createConfigFile*(): ConfigFile = ConfigFile(name: nameConfigFile)
func createCpuID*(): CpuID = CpuID(name: nameCpuID)
func createCRC*(): CRC = CRC(name: nameCRC)
func createCryptoMount*(): CryptoMount = CryptoMount(name: nameCryptoMount)
func createCutmem*(): Cutmem = Cutmem(name: nameCutmem)
func createDate*(): Date = Date(name: nameDate)
func createDeviceTree*(): DeviceTree = DeviceTree(name: nameDeviceTree)
func createDistrust*(): Distrust = Distrust(name: nameDistrust)
func createDriveMap*(): DriveMap = DriveMap(name: nameDriveMap)
func createEcho*(): Echo = Echo(name: nameEcho)
func createEval*(): Eval = Eval(name: nameEval)
func createExport*(): Export = Export(name: nameExport)
func createFalse*(): False = False(name: nameFalse)
func createGetText*(): GetText = GetText(name: nameGetText)
func createGptSync*(): GptSync = GptSync(name: nameGptSync)
func createHalt*(): Halt = Halt(name: nameHalt)
func createHashsum*(): Hashsum = Hashsum(name: nameHashsum)
func createHelp*(): Help = Help(name: nameHelp)
func createInitRD*(): InitRD = InitRD(name: nameInitRD)
func createInitRD16*(): InitRD16 = InitRD16(name: nameInitRD16)
func createInsmod*(): Insmod = Insmod(name: nameInsmod)
func createKeyStatus*(): KeyStatus = KeyStatus(name: nameKeyStatus)
func createLinux*(): Linux = Linux(name: nameLinux)
func createLinux16*(): Linux16 = Linux16(name: nameLinux16)
func createListENV*(): ListENV = ListENV(name: nameListENV)
func createListTrusted*(): ListTrusted = ListTrusted(name: nameListTrusted)
func createLoadENV*(): LoadENV = LoadENV(name: nameLoadENV)
func createLoadFont*(): LoadFont = LoadFont(name: nameLoadFont)
func createLoopback*(): Loopback = Loopback(name: nameLoopback)
func createLs*(): Ls = Ls(name: nameLs)
func createListFonts*(): ListFonts = ListFonts(name: nameListFonts)
func createListMod*(): ListMod = ListMod(name: nameListMod)
func createMD5sum*(): MD5sum = MD5sum(name: nameMD5sum)
func createModule*(): Module = Module(name: nameModule)
func createMultiboot*(): Multiboot = Multiboot(name: nameMultiboot)
func createNativeDisk*(): NativeDisk = NativeDisk(name: nameNativeDisk)
func createNormal*(): Normal = Normal(name: nameNormal)
func createNormalExit*(): NormalExit = NormalExit(name: nameNormalExit)
func createPartTool*(): PartTool = PartTool(name: namePartTool)
func createPassword*(): Password = Password(name: namePassword)
func createPasswordPbkdf2*(): PasswordPbkdf2 = PasswordPbkdf2(name: namePasswordPbkdf2)
func createPlay*(): Play = Play(name: namePlay)
func createProbe*(): Probe = Probe(name: nameProbe)
func createRdmsr*(): Rdmsr = Rdmsr(name: nameRdmsr)
func createRead*(): Read = Read(name: nameRead)
func createReboot*(): Reboot = Reboot(name: nameReboot)
func createRegexp*(): Regexp = Regexp(name: nameRegexp)
func createRmmod*(): Rmmod = Rmmod(name: nameRmmod)
func createSaveENV*(): SaveENV = SaveENV(name: nameSaveENV)
func createSearch*(): Search = Search(name: nameSearch)
func createSendKey*(): SendKey = SendKey(name: nameSendKey)
func createSet*(): Set = Set(name: nameSet)
func createSha1sum*(): Sha1sum = Sha1sum(name: nameSha1sum)
func createSha256sum*(): Sha256sum = Sha256sum(name: nameSha256sum)
func createSha512sum*(): Sha512sum = Sha512sum(name: nameSha512sum)
func createSleep*(): Sleep = Sleep(name: nameSleep)
func createSmBios*(): SmBios = SmBios(name: nameSmBios)
func createSource*(): Source = Source(name: nameSource)
func createTest*(): Test = Test(name: nameTest)
func createTrue*(): True = True(name: nameTrue)
func createTrust*(): Trust = Trust(name: nameTrust)
func createUnset*(): Unset = Unset(name: nameUnset)
func createVerifyDetached*(): VerifyDetached = VerifyDetached(name: nameVerifyDetached)
func createVideoInfo*(): VideoInfo = VideoInfo(name: nameVideoInfo)
func createWrmsr*(): Wrmsr = Wrmsr(name: nameWrmsr)
func createXenHypervisor*(): XenHypervisor = XenHypervisor(name: nameXenHypervisor)
func createXenModule*(): XenModule = XenModule(name: nameXenModule)