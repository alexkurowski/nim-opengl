import common

imports:
  sdl2
  opengl


const
  textureSize = 16
  atlasSize   = 256


var
  atlas*: GLuint


proc new*(id: int): seq[float] =
  let row = atlasSize div textureSize
  let x1 = (id mod row) * textureSize
  let y1 = (id div row) * textureSize
  let x2 = x1 + textureSize
  let y2 = y1 + textureSize

  let x1f = x1.float / atlasSize.float
  let x2f = x2.float / atlasSize.float
  let y1f = y1.float / atlasSize.float
  let y2f = y2.float / atlasSize.float

  return @[
    x2f, y2f,
    x1f, y2f,
    x1f, y1f,
    x2f, y1f
  ]


proc initializeTexture*(): void =
  glGenTextures(1.GLsizei, atlas.addr)

  var image = loadBMP("assets/textures/texture.bmp")

  glBindTexture(GL_TEXTURE_2D, atlas)

  glTexImage2D(
    GL_TEXTURE_2D,
    0.GLint,
    GL_RGB.GLint,
    image.w.GLsizei,
    image.h.GLsizei,
    0.GLint,
    GL_BGR,
    GL_UNSIGNED_BYTE,
    image.pixels
  )

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)

  glBindTexture(GL_TEXTURE_2D, 0)
