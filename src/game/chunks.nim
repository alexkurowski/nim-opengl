import common

imports:
  glm
  common.types

requires:
  random
  perlin
  config


const
  size = config.chunkSize


var
  noise: perlin.Noise


proc initialize*(): void =
  random.randomize()
  noise = perlin.newNoise()


proc newChunkAt*(x, y: int): Chunk =
  result = Chunk(
    x: x,
    y: y,
    lod: 0
  )

  var height: float

  let sx = x * size
  let sy = y * size
  let ex = sx + size - 1
  let ey = sy + size - 1

  for i in sx..ex:
    for j in sy..ey:
      height = -1f * ( perlin.simplex(noise, i.float / 4, j.float / 4) * 12 )

      result.cell[i - sx][j - sy] = Cell(
        cellType: 0,
        height: height
      )
