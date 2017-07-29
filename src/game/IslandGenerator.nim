import common

imports:
  math
  common.types

requires:
  Config
  random
  perlin


const
  chunkSize   = Config.chunkSize
  mapSize     = Config.mapSize * Config.chunkSize
  persistence = 0.1
  octaves     = 16


var
  noise: perlin.Noise


proc initialize*() =
  random.randomize()
  noise = perlin.newNoise(octaves, persistence)


proc generateChunk*(x, y: int): CellMap =
  var cx, cy, mask, delta, gradient, height: float

  let sx = x * chunkSize
  let sy = y * chunkSize
  let ex = sx + chunkSize - 1
  let ey = sy + chunkSize - 1

  for i in sx..ex:
    for j in sy..ey:

      # Distance to the center
      cx       = (mapSize.float * 0.5 - i.float).abs
      cy       = (mapSize.float * 0.5 - j.float).abs
      mask     = max(cx, cy)

      delta = mask / ( mapSize * 0.3 )
      gradient = delta * delta

      height = perlin.simplex(noise, i, j)
      height *= max(0.1, 2 - gradient)
      height = (height * 16).floor / 2 + 1

      result[i - sx][j - sy] = Cell(
        cellType: 0,
        height: -height
      )
