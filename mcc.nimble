# Package

version       = "0.1.0"
author        = "Alex"
description   = "Test minecraft-ish voxel world generation & rendering"
license       = "GPLv3"

skipExt       = @["nim"]

# Dependencies

requires "nim >= 0.17.0"
requires "sdl2"

task run, "build and run":
  exec "nim c -o=game --nimcache=build -r src/main.nim"
