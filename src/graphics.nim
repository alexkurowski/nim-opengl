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


proc setShader*(id: int): void =
  glUseProgram(shaders[id].id);


proc unsetShader*(): void =
  glUseProgram(0);


proc setTexture*(id: int): void =
  glBindTexture(GL_TEXTURE_2D, textures[id])


proc unsetTexture*(): void =
  glBindTexture(GL_TEXTURE_2D, 0)


proc setModel*(id: int): void =
  glBindVertexArray(models[id].vao)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, models[id].ebo)


proc unsetModel*(): void =
  glBindVertexArray(0)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0)


proc renderModel*(id: int): void =
  glDrawElements(GL_TRIANGLES, models[id].indexCount, GL_UNSIGNED_INT, nil)
