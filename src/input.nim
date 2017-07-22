import
  sdl2,
  tables,
  graphics.window,
  common.actions


export
  sdl2,
  actions


var
  event = defaultEvent

  exit* = false

  lastKey*: Scancode = SDL_SCANCODE_UNKNOWN
  keys*: set[actions] = {}

  keymap = {
    SDL_SCANCODE_Q: actions.cameraRotateLeft,
    SDL_SCANCODE_E: actions.cameraRotateRight,
    SDL_SCANCODE_W: actions.cameraGoForward,
    SDL_SCANCODE_S: actions.cameraGoBackward,
    SDL_SCANCODE_A: actions.cameraGoLeft,
    SDL_SCANCODE_D: actions.cameraGoRight
  }.toTable


proc keyDown(key: Scancode): void =
  lastKey = key
  if keymap.hasKey key:
    keys.incl keymap[key]


proc keyUp(key: Scancode): void =
  lastKey = SDL_SCANCODE_UNKNOWN
  if keymap.hasKey key:
    keys.excl keymap[key]


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
      keyDown(event.key.keysym.scancode)

    of KeyUp:
      keyUp(event.key.keysym.scancode)

    of MouseMotion:
      mouseMotion(event.motion.x, event.motion.y)

    of MouseButtonDown:
      mouseButtonDown(event.button.button)

    of MouseButtonUp:
      mouseButtonUp(event.button.button)

    else: discard
