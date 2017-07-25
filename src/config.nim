import tables

const
  windowTitle*  = "nim"
  windowWidth*  = 800
  windowHeight* = 600

  glMajor* = 3
  glMinor* = 1

  textureFilename* = "texture.bmp"

  shaderLocations* = {
    "simple": @["projViewMatrix", "modelMatrix"]
  }.toTable
