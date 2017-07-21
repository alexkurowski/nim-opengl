import
  sdl2,
  input,
  graphics,
  renderer,
  states.gameplay


var
  state = gameplay.state


proc initialize*(): void =
  graphics.initialize(
    title  = "Hello",
    width  = 800,
    height = 600
  )

  renderer.load()


proc mainLoop*(): void =
  while not input.exit:
    input.read()
    state()
    renderer.render()


proc finish*(): void =
  graphics.destroy()
