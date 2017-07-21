import
  sdl2,
  graphics.window


var
  event = defaultEvent
  exit* = false


proc keyDown(key: cint): void =
  echo("Keyboard down: " & $key)


proc keyUp(key: cint): void =
  echo("Keyboard up: " & $key)


proc mouseMotion(x, y: cint): void =
  echo("Mouse move: " & $x & ":" & $y)


proc mouseButtonDown(btn: uint8): void =
  case btn
  of 1: echo("Mouse button down: left")
  of 2: echo("Mouse button down: middle")
  of 3: echo("Mouse button down: right")
  else: discard


proc mouseButtonUp(btn: uint8): void =
  case btn
  of 1: echo("Mouse button up: left")
  of 2: echo("Mouse button up: middle")
  of 3: echo("Mouse button up: right")
  else: discard


proc read*(): void =
  while pollEvent(event):
    case event.kind
    of QuitEvent:
      exit = true

    of WindowEvent:
      if event.window.event == WindowEvent_Resized:
        window.resize(
          width  = event.window.data1,
          height = event.window.data2
        )

    of KeyDown:
      keyDown(event.key.keysym.sym)

    of KeyUp:
      keyUp(event.key.keysym.sym)

    of MouseMotion:
      mouseMotion(event.motion.x, event.motion.y)

    of MouseButtonDown:
      mouseButtonDown(event.button.button)

    of MouseButtonUp:
      mouseButtonDown(event.button.button)

    else: discard
