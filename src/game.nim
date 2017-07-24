import common

requires:
  clock
  input
  graphics
  game.state


var
  currentState = "gameplay"


proc start*(): void =
  graphics.initialize()
  state.load(currentState)


proc mainLoop*(): void =
  while not input.exit:
    input.read()

    state.update( currentState, clock.getDelta() )

    graphics.set()
    graphics.render( state.draw(currentState) )
    graphics.unset()


proc finish*(): void =
  graphics.finish()
