import
  times,
  glm,
  graphics,
  graphics.model,
  graphics.texture,
  graphics.shader,
  graphics.matrix,
  camera,
  entity


var
  quad: Entity
  myModel: int
  simpleShader: int
  grassTexture: int


proc load*(): void =
  var vertexCoords = @[
     0.5,  0.5,  0.0,
    -0.5,  0.5,  0.0,
    -0.5, -0.5,  0.0,
     0.5, -0.5,  0.0
  ]

  var textureCoords = @[
     1.0, 1.0,
     0.0, 1.0,
     0.0, 0.0,
     1.0, 0.0
  ]

  var vertexIndices = @[
    0, 1, 2,
    2, 3, 0
  ]

  myModel      = model.new(vertexCoords, textureCoords, vertexIndices)
  simpleShader = shader.new("simple")
  grassTexture = texture.new("grass")

  quad = Entity(
    position: vec3f(0.0, 0.0, -3.0),
    rotation: vec3f(0.0, 0.0, 0.0)
  )


proc render*(): void =
  graphics.renderStart()

  graphics.setShader(simpleShader)
  setMat4(simpleShader, "viewMatrix", matrix.view(camera.position, camera.rotation))

  graphics.setTexture(grassTexture)

  graphics.setModel(myModel)
  setMat4(simpleShader, "modelMatrix", matrix.model(quad.position, quad.rotation))

  graphics.renderModel(myModel)
  graphics.unsetModel()

  graphics.unsetTexture()
  graphics.unsetShader()

  graphics.renderEnd()
