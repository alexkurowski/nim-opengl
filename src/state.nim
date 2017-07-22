import
  game.entity,
  game.states.gameplay


proc load*(state: string): void =
  case state
  of "gameplay": gameplay.load()
  else: discard


proc update*(state: string): void =
  case state
  of "gameplay": gameplay.update()
  else: discard


proc draw*(state: string): seq[Entity] =
  case state
  of "gameplay": gameplay.draw()
  else: @[]
