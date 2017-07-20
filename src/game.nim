import
  sdl2,
  opengl,
  lib.display,
  graphics.model,
  states.gameplay,
  graphics.shaders.simple


var
  event = sdl2.defaultEvent
  exit  = false
  state = gameplay.state


proc mainLoop*(): void =
  var vertices = @[
     0.5.GLfloat,  0.5.GLfloat,
    -0.5.GLfloat,  0.5.GLfloat,
    -0.5.GLfloat, -0.5.GLfloat,

    -0.5.GLfloat, -0.5.GLfloat,
     0.5.GLfloat, -0.5.GLfloat,
     0.5.GLfloat,  0.5.GLfloat
  ]
  var model = newModel[GLfloat](vertices.addr)
  var simpleShader = newSimpleShader()

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

    state()
    # TODO: Update game here

    display.renderStart()

    model.draw(simpleShader)
    # TODO: Render game here

    display.renderEnd()
