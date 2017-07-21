import
  graphics,
  graphics.model,
  graphics.texture,
  graphics.shader,
  graphics.window


var
  myModel: int
  simpleShader: int
  grassTexture: int


proc load*(): void =
  var vertexCoords = @[
     0.5,  0.5,
    -0.5,  0.5,
    -0.5, -0.5,
     0.5, -0.5
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


proc render*(): void =
  graphics.renderStart()

  graphics.setShader(simpleShader)
  graphics.setTexture(grassTexture)

  graphics.renderModel(myModel)

  graphics.unsetTexture()
  graphics.unsetShader()

  graphics.renderEnd()
