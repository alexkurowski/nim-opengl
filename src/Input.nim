include common

imports:
  sdl2
  glm
  tables
  common.types

requires:
  graphics/Window


var
  event = defaultEvent

  exit* = false

  lastKey*: Scancode = SDL_SCANCODE_UNKNOWN
  keys*: set[Action] = {}

  keymap = {
    SDL_SCANCODE_Q:     Action.cameraRotateLeft,
    SDL_SCANCODE_E:     Action.cameraRotateRight,
    SDL_SCANCODE_W:     Action.cameraGoForward,
    SDL_SCANCODE_S:     Action.cameraGoBackward,
    SDL_SCANCODE_A:     Action.cameraGoLeft,
    SDL_SCANCODE_D:     Action.cameraGoRight,
    SDL_SCANCODE_SPACE: Action.cameraGoUp,
    SDL_SCANCODE_C:     Action.cameraGoDown,
  }.toTable

  mousePosition*: Vec2i = vec2i(0)
  mouseDelta*: Vec2i    = vec2i(0)


proc keyDown(key: Scancode) =
  lastKey = key
  if keymap.hasKey key:
    keys.incl keymap[key]


proc keyUp(key: Scancode) =
  lastKey = SDL_SCANCODE_UNKNOWN
  if keymap.hasKey key:
    keys.excl keymap[key]


proc mouseMotion(x, y: cint) =
  mouseDelta.x = mousePosition.x - x
  mouseDelta.y = mousePosition.y - y
  mousePosition = vec2i(x, y)


proc mouseButtonDown(btn: uint8) =
  case btn
  of 1: echo("Mouse button down: left")
  of 2: echo("Mouse button down: middle")
  of 3: keys.incl Action.cameraDrag
  else: discard


proc mouseButtonUp(btn: uint8) =
  case btn
  of 1: echo("Mouse button up: left")
  of 2: echo("Mouse button up: middle")
  of 3: keys.excl Action.cameraDrag
  else: discard


proc read*() =
  mouseDelta = vec2i(0)

  while pollEvent(event):
    case event.kind
    of QuitEvent:
      exit = true

    of WindowEvent:
      if event.window.event == WindowEvent_Resized:
        Window.resize(
          w = event.window.data1,
          h = event.window.data2
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


proc isDown*(action: Action): bool =
  keys.contains action
