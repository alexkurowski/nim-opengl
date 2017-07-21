import
  sdl2,
  opengl,
  lib.display,
  states.gameplay,
  graphics.model,
  graphics.texture,
  graphics.shaders.simple


var
  event = sdl2.defaultEvent
  exit  = false
  state = gameplay.state


proc mainLoop*(): void =
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

  var model = newModel(vertexCoords.addr, textureCoords.addr, vertexIndices.addr)
  var simpleShader = newSimpleShader()
  var texture = newTexture("grass")

  while not exit:
    while pollEvent(event):
      case event.kind
      of QuitEvent:
        exit = true

      of WindowEvent:
        var windowEvent = cast[WindowEventPtr](addr(event))
        if windowEvent.event == WindowEvent_Resized:
          display.onResize(
            width = windowEvent.data1,
            height = windowEvent.data2
          )

      else: discard

    # TODO: Update game here
    state()

    display.renderStart()

    # TODO: Render game here
    display.setShader(simpleShader)
    display.setTexture(texture)

    model.draw()

    display.unsetTexture()
    display.unsetShader()

    display.renderEnd()
