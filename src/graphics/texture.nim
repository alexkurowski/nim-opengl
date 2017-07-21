import
  sdl2,
  opengl


type
  Texture* = ref object
    id*: GLuint


proc newTexture*(filename: string): Texture =
  result = Texture()

  glGenTextures(1.GLsizei, result.id.addr)

  var image = loadBMP("assets/textures/" & filename & ".bmp")

  glBindTexture(GL_TEXTURE_2D, result.id)

  glTexImage2D(
    GL_TEXTURE_2D,
    0.GLint,
    GL_RGB.GLint,
    image.w.GLsizei,
    image.h.GLsizei,
    0.GLint,
    GL_RGB,
    GL_UNSIGNED_BYTE,
    image.pixels
  )

  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
  glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)

  glBindTexture(GL_TEXTURE_2D, 0)
