import
  times,
  glm,
  graphics,
  graphics.model,
  graphics.texture,
  graphics.shader,
  graphics.entity


var
  quad: Entity
  camera: Entity
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

  camera = Entity(
    position: vec3f(0.0, 0.0, 0.0),
    rotation: vec3f(0.0, 0.0, 0.0)
  )


proc render*(): void =
  graphics.renderStart()

  graphics.setShader(simpleShader)
  simpleShader.setMat4("viewMatrix", camera.viewMatrix)

  graphics.setTexture(grassTexture)

  graphics.setModel(myModel)
  simpleShader.setMat4("modelMatrix", quad.modelMatrix)

  graphics.renderModel(myModel)
  graphics.unsetModel()

  graphics.unsetTexture()
  graphics.unsetShader()

  graphics.renderEnd()
