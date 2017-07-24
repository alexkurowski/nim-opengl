import common

includes:
  graphics_gl

imports:
  glm
  common.types

requires:
  game.camera
  game.entities


var
  simpleShader: int


proc set*(): void =
  renderStart()

  setShader(simpleShader)
  shader.setMat4(simpleShader, "viewMatrix", graphics.matrix.view(camera.position, camera.rotation, camera.fov))

  setTexture()


proc render*(entities: seq[Entity]): void =
  for entity in entities:
    setMesh(entity.mesh)
    # TODO: This is very bad for performance though!
    shader.setMat4(simpleShader, "modelMatrix", graphics.matrix.model(entity.position, entity.rotation))
    renderMesh(entity.mesh)
  unsetMesh()


proc unset*(): void =
  unsetShader()
  unsetTexture()

  renderEnd()


proc initialize*(): void =
  graphics.window.initializeWindow()
  graphics.window.initializeOpenGl()

  graphics.texture.initializeTexture()

  simpleShader = graphics.shader.new("simple")


proc finish*(): void =
  graphics.mesh.destroyMeshes()
  graphics.window.destroy()
