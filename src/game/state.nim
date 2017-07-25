import common

imports:
  common.types

requires:
  graphics
  game.states.gameplay.gameplay_state as gameplay


var
  currentState: string


proc set*(newState: string): void =
  currentState = newState

  case currentState
  of "gameplay": gameplay.load()
  else: discard


proc update*(dt: float): void =
  case currentState
  of "gameplay": gameplay.update(dt)
  else: discard


proc draw*(): void =
  case currentState
  of "gameplay": graphics.render(gameplay.entityList)
  else: discard
