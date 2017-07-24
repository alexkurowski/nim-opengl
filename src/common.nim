import macros


macro includes*(libs: untyped): untyped =
  result = newStmtList()
  for lib in libs:
    result.add(
      newNimNode(nnkIncludeStmt).add(lib)
    )


macro imports*(libs: untyped): untyped =
  result = newStmtList()
  for lib in libs:
    result.add(
      newNimNode(nnkImportStmt).add(lib)
    )


macro requires*(libs: untyped): untyped =
  result = newStmtList()
  for lib in libs:
    result.add(
      newNimNode(nnkFromStmt).add(lib, newNilLit())
    )


macro exports*(libs: untyped): untyped =
  result = newStmtList()
  for lib in libs:
    result.add(
      newNimNode(nnkExportStmt).add(lib)
    )
