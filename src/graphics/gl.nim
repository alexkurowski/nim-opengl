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


proc setShader(nextShader: string): void =
  shader.use(nextShader)


proc setTexture(): void =
  texture.use()


proc setMesh(id: int): void =
  mesh.use(id)


proc renderMesh(id: int): void =
  mesh.render()
