import common

imports:
  common.types

requires:
  Graphics
  states/GameplayState as Gameplay


var
  currentState: string


proc set*(newState: string) =
  currentState = newState

  case currentState
  of "gameplay": Gameplay.load()
  else: discard


proc update*(dt: float) =
  case currentState
  of "gameplay": Gameplay.update(dt)
  else: discard


proc draw*() =
  case currentState
  of "gameplay":
    Graphics.renderChunks(Gameplay.chunkList)
    Graphics.renderEntities(Gameplay.entityList)
  else: discard
