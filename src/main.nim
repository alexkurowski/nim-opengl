import
  lib.display,
  game


const
  windowWidth: cint = 800
  windowHeight: cint = 600


display.initialize(
  width  = windowWidth,
  height = windowHeight
)

game.mainLoop()

display.destroy()
