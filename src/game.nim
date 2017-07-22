import
  sdl2,
  input,
  renderer,
  game.state


var
  currentState = "gameplay"


proc start*(): void =
  renderer.initialize(
    title  = "Hello",
    width  = 800,
    height = 600
  )

  currentState.load()


proc mainLoop*(): void =
  while not input.exit:
    input.read()

    currentState.update()

    renderer.set()
    renderer.render( currentState.draw() )
    renderer.unset()


proc finish*(): void =
  renderer.finish()
