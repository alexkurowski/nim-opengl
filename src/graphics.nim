import
  sdl2,
  opengl,
  glu,
  graphics.window,
  graphics.model,
  graphics.shader,
  graphics.texture


proc initialize*(title: cstring, width, height: cint): void =
  window.initializeWindow(title, width, height)
  window.initializeOpenGl()


proc destroy*(): void =
  window.destroy()


proc renderStart*(): void =
  window.clear()
  # glMatrixMode(GL_MODELVIEW)                          # To operate on model-view matrix
  # glLoadIdentity()                                    # Reset the model-view matrix

proc renderEnd*(): void =
  window.swap()


proc renderModel*(id: int): void =
  let m = model.models[id]

  glBindVertexArray(m.vao)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, m.ebo)

  glDrawElements(GL_TRIANGLES, m.indexCount, GL_UNSIGNED_INT, nil)

  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0)
  glBindVertexArray(0)


proc setShader*(id: int): void =
  glUseProgram(shader.shaders[id]);

proc unsetShader*(): void =
  glUseProgram(0);


proc setTexture*(id: int): void =
  glBindTexture(GL_TEXTURE_2D, texture.textures[id])

proc unsetTexture*(): void =
  glBindTexture(GL_TEXTURE_2D, 0)
