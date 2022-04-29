type
  BackgroundImageMode* = enum
    stretch,
    normal
  GptSyncStatus* = enum
    active,
    inactive
  HashType* = enum
    adler32,
    crc64,
    crc32,
    crc32rfc1510,
    crc24rfc2440,
    md4,
    md5,
    ripemd160,
    sha1,
    sha224,
    sha256,
    sha384,
    sha512,
    tiger,
    tiger2,
    tiger192,
    whirlpool
  PartToolCommand* = enum
    boot,
    `type`,
    hidden