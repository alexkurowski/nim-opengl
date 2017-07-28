import tables

const
  # Initial window settings
  windowTitle*  = "nim"
  windowWidth*  = 800
  windowHeight* = 600

  # OpenGL version
  glMajor* = 3
  glMinor* = 1

  textureFilename* = "texture.bmp"

  # Shader file name and a seq of its uniform locations
  shaderSettings* = {
    "simple": @["projViewMatrix", "modelMatrix"],
    "chunk":  @["projViewMatrix", "modelMatrix"],
  }.toTable

  cellSize*  = 1f # One block is this size in gl
  chunkSize* = 16 # A chunk consists of this many blocks per line
  mapSize*   = 16 # The map is this number of chunks per line
