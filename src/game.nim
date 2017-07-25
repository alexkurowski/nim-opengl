import common

requires:
  clock
  input
  graphics
  game.state


proc start*(): void =
  graphics.initialize()

  state.set("gameplay")


proc mainLoop*(): void =
  while not input.exit:
    input.read()

    state.update( clock.getDelta() )

    graphics.set()
    state.draw()
    graphics.unset()


proc finish*(): void =
  graphics.finish()
