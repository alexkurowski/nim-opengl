import
  sdl2,
  graphics.window


var
  event = sdl2.defaultEvent
  exit* = false


proc read*(): void =
  while pollEvent(event):
    case event.kind
    of QuitEvent:
      exit = true

    of WindowEvent:
      var windowEvent = cast[WindowEventPtr](addr(event))
      if windowEvent.event == WindowEvent_Resized:
        window.resize(
          width  = windowEvent.data1,
          height = windowEvent.data2
        )

    else: discard
