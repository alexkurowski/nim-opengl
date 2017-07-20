import
  sdl2,
  opengl,
  lib.display,
  states.gameplay,
  types


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

    model.draw()
    # TODO: Render game here

    display.renderEnd()
