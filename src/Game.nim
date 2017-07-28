import common

requires:
  Clock
  Input
  Graphics
  State


proc start*() =
  Graphics.initialize()

  State.set("gameplay")


proc mainLoop*() =
  while not Input.exit:
    Input.read()

    State.update( Clock.getDelta() )

    Graphics.set()
    State.draw()
    Graphics.unset()


proc finish*() =
  Graphics.finish()
