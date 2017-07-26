import common

imports:
  sdl2
  opengl
  glu

requires:
  window
  mesh
  texture
  shader
  matrix


proc renderStart(): void =
  window.clear()


proc renderEnd(): void =
  window.swap()


proc setShader(nextShader: shader.Shader): void =
  shader.use(nextShader)
  glUseProgram(nextShader.id)


proc unsetShader(): void =
  glUseProgram(0);


proc setTexture(): void =
  glBindTexture(GL_TEXTURE_2D, texture.atlas)


proc unsetTexture(): void =
  glBindTexture(GL_TEXTURE_2D, 0)


proc setMesh(id: int): void =
  glBindVertexArray(mesh.meshes[id].vao)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, mesh.meshes[id].ebo)


proc unsetMesh(): void =
  glBindVertexArray(0)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0)


proc renderMesh(id: int): void =
  glDrawElements(GL_TRIANGLES, mesh.meshes[id].indexCount, GL_UNSIGNED_INT, nil)
