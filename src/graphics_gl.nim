import
  sdl2,
  opengl,
  glu,
  graphics.window,
  graphics.mesh,
  graphics.texture,
  graphics.shader,
  graphics.matrix


export
  window,
  mesh,
  texture,
  shader,
  matrix


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


proc setTexture*(): void =
  glBindTexture(GL_TEXTURE_2D, texture.atlas)


proc unsetTexture*(): void =
  glBindTexture(GL_TEXTURE_2D, 0)


proc setMesh*(id: int): void =
  glBindVertexArray(meshes[id].vao)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, meshes[id].ebo)


proc unsetMesh*(): void =
  glBindVertexArray(0)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0)


proc renderMesh*(id: int): void =
  glDrawElements(GL_TRIANGLES, meshes[id].indexCount, GL_UNSIGNED_INT, nil)
