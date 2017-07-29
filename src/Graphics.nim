import common

imports:
  glm
  common.types

requires:
  Config
  graphics/Window
  graphics/Mesh
  graphics/Texture
  graphics/Shader
  graphics/Matrix
  game/Camera


proc renderStart() =
  Window.clear()


proc renderEnd() =
  Window.swap()


proc setShader(nextShader: ShaderType) =
  Shader.use(nextShader)


proc setTexture() =
  Texture.use()


proc setMesh(id: int) =
  Mesh.use(id)


proc renderMesh(id: int) =
  Mesh.render()


proc set*() =
  renderStart()

  setTexture()


proc renderChunks*(chunks: seq[Chunk]) =
  setShader(ShaderType.chunk)
  Shader.setMat4("projViewMatrix", Camera.projection * Camera.view)

  for chunk in chunks:
    let chunkX = chunk.x * Config.chunkSize
    let chunkY = chunk.y * Config.chunkSize
    setMesh(chunk.mesh)
    Shader.setMat4("modelMatrix", Matrix.chunk(chunkX, chunkY))
    renderMesh(chunk.mesh)


proc renderEntities*(entities: seq[Entity]) =
  setShader(ShaderType.simple)
  Shader.setMat4("projViewMatrix", Camera.projection * Camera.view)
  for entity in entities:
    setMesh(entity.mesh)
    Shader.setMat4("modelMatrix", Matrix.model(entity.position, entity.rotation))
    renderMesh(entity.mesh)


proc unset*() =
  renderEnd()


proc initialize*() =
  Window.initializeWindow()
  Window.initializeOpenGl()

  Shader.initialize()
  Texture.initialize()


proc finish*() =
  Mesh.destroyAll()
  Window.destroy()
