import macros


macro require*(libs: varargs[untyped]): untyped =
  result = newNimNode(nnkStmtList, libs)
  for lib in libs:
    var node = newNimNode(nnkFromStmt)
    node.add( lib )
    node.add( newNilLit() )
    result.add(node)
