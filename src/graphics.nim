import
  glm,
  game.camera,
  game.entity


include
  graphics_gl


var
  simpleShader: int


proc set*(): void =
  renderStart()

  setShader(simpleShader)
  setMat4(simpleShader, "viewMatrix", graphics.matrix.view(camera.position, camera.rotation))

  setTexture()


proc render*(entities: seq[Entity]): void =
  for entity in entities:
    setMesh(entity.mesh)
    # TODO: This is very bad for performance though!
    setMat4(simpleShader, "modelMatrix", graphics.matrix.model(entity.position, entity.rotation))
    renderMesh(entity.mesh)
  unsetMesh()


proc unset*(): void =
  unsetShader()
  unsetTexture()

  renderEnd()


proc initialize*(title: cstring, width, height: cint): void =
  graphics.window.initializeWindow(title, width, height)
  graphics.window.initializeOpenGl()

  graphics.texture.initialize()
  simpleShader = graphics.shader.new("simple")


proc finish*(): void =
  graphics.mesh.destroyMeshes()
  graphics.window.destroy()
