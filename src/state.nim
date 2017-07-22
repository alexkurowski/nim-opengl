import
  game.entity,
  game.states.gameplay


proc load*(state: string): void =
  case state
  of "gameplay": gameplay.load()
  else: discard


proc update*(state: string, dt: float): void =
  case state
  of "gameplay": gameplay.update(dt)
  else: discard


proc draw*(state: string): seq[Entity] =
  case state
  of "gameplay": gameplay.quads
  else: @[]
