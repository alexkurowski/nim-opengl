import common

includes:
  graphics_gl

imports:
  glm
  common.types

requires:
  game.camera
  game.entities


proc set*(): void =
  renderStart()

  setTexture()
  setShader(shader.simple)


proc render*(entities: seq[Entity]): void =
  shader.setMat4("projViewMatrix", camera.projection * camera.view)

  for entity in entities:
    setMesh(entity.mesh)
    shader.setMat4("modelMatrix", graphics.matrix.model(entity.position, entity.rotation))
    renderMesh(entity.mesh)


proc unset*(): void =
  unsetMesh()
  unsetShader()
  unsetTexture()

  renderEnd()


proc initialize*(): void =
  graphics.window.initializeWindow()
  graphics.window.initializeOpenGl()

  graphics.shader.initialize()
  graphics.texture.initialize()
  graphics.mesh.initialize()


proc finish*(): void =
  graphics.mesh.destroyMeshes()
  graphics.window.destroy()
