# Package

version       = "0.1.0"
author        = "Alex"
description   = "Test minecraft-ish voxel world generation & rendering"
license       = "GPLv3"

skipExt       = @["nim"]

# Dependencies

requires "nim >= 0.17.0"
requires "sdl2"
requires "glm"

task run, "build and run":
  exec "nim c -o=game --nimcache=build -p:. -r src/main.nim"

task fast, "build and run fast":
  exec "nim c -o=game --nimcache=build -p:. --opt:speed -r src/main.nim"

task release, "build a release version":
  exec "nim c -o=game --nimcache=build -p:. -d:release -r src/main.nim"
