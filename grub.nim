##[
  Master Module
]##

when isMainModule:
  import
    grub/meta,
    logging

  let logger = getLogger("grub")
  logger.log(lvlNotice, "appVersion: " & appVersion)
  logger.log(lvlNotice, "appRevision: " & appRevision)
  logger.log(lvlNotice, "appDate: " & appDate)
