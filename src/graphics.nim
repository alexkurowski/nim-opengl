import common

includes:
  graphics.gl

imports:
  glm
  common.types

requires:
  config
  game.camera


proc set*(): void =
  renderStart()

  setTexture()


proc renderChunks*(chunks: seq[Chunk]): void =
  setShader(shader.chunk)
  shader.setMat4("projViewMatrix", camera.projection * camera.view)

  for chunk in chunks:
    let chunkX = chunk.x * config.chunkSize
    let chunkY = chunk.y * config.chunkSize
    setMesh(chunk.mesh)
    shader.setMat4("modelMatrix", graphics.matrix.chunk(chunkX, chunkY))
    renderMesh(chunk.mesh)


proc renderEntities*(entities: seq[Entity]): void =
  setShader(shader.simple)
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
