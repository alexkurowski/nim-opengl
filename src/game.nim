import
  sdl2,
  input,
  graphics,
  state


var
  currentState = "gameplay"


proc start*(): void =
  graphics.initialize(
    title  = "Hello",
    width  = 800,
    height = 600
  )

  currentState.load()


proc mainLoop*(): void =
  while not input.exit:
    input.read()

    currentState.update()

    graphics.set()
    graphics.render( currentState.draw() )
    graphics.unset()


proc finish*(): void =
  graphics.finish()
