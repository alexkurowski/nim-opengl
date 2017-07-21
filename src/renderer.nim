import
  opengl,
  lib.display,
  graphics.shader,
  graphics.shaders.simple,
  graphics.texture,
  graphics.model


var
  models: seq[Model]
  simpleShader: Shader
  grassTexture: Texture


proc initialize*(): void =
  var vertexCoords = @[
     0.5.GLfloat,  0.5.GLfloat,
    -0.5.GLfloat,  0.5.GLfloat,
    -0.5.GLfloat, -0.5.GLfloat,
     0.5.GLfloat, -0.5.GLfloat
  ]

  var textureCoords = @[
     1.0.GLfloat, 1.0.GLfloat,
     0.0.GLfloat, 1.0.GLfloat,
     0.0.GLfloat, 0.0.GLfloat,
     1.0.GLfloat, 0.0.GLfloat
  ]

  var vertexIndices = @[
    0.GLuint, 1.GLuint, 2.GLuint,
    2.GLuint, 3.GLuint, 0.GLuint
  ]

  models = @[]
  models.add( newModel(vertexCoords.addr, textureCoords.addr, vertexIndices.addr) )
  simpleShader = newSimpleShader()
  grassTexture = newTexture("grass")


proc render*(): void =
  display.renderStart()

  display.setShader(simpleShader)
  display.setTexture(grassTexture)

  for model in models:
    display.drawModel(model)

  display.unsetShader()
  display.unsetTexture()

  display.renderEnd()
