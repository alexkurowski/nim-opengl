import
  sdl2,
  opengl,
  lib.display,
  states.gameplay,
  renderer,
  graphics.model,
  graphics.texture,
  graphics.shaders.simple


var
  event = sdl2.defaultEvent
  exit  = false
  state = gameplay.state


proc mainLoop*(): void =
  renderer.initialize()

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

    renderer.render()
