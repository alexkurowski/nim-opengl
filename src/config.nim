import tables

const
  windowTitle*  = "nim"
  windowWidth*  = 800
  windowHeight* = 600

  glMajor* = 3
  glMinor* = 1

  textureFilename* = "texture.bmp"

  shaderSettings* = {
    "simple": @["projViewMatrix", "modelMatrix"],
    "chunk": @["projViewMatrix", "modelMatrix"],
  }.toTable

  chunkSize* = 16
  cellSize* = 1f

  mapSize* = 16
