import
  glm,
  game.camera,
  game.entity,
  graphics.graphics


var
  simpleShader: int
  grassTexture: int


proc set*(): void =
  renderStart()

  setShader(simpleShader)
  setMat4(simpleShader, "viewMatrix", graphics.matrix.view(camera.position, camera.rotation))

  setTexture(grassTexture)


proc render*(entities: seq[Entity]): void =
  for entity in entities:
    setMesh(entity.mesh)
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

  simpleShader = graphics.shader.new("simple")
  grassTexture = graphics.texture.new("grass")


proc finish*(): void =
  graphics.mesh.destroyMeshes()
  graphics.window.destroy()
