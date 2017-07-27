import common

imports:
  glm
  common.types

requires:
  config
  island_generator
  graphics.mesh


const
  size = config.chunkSize


proc initialize*(): void =
  islandGenerator.initialize()


proc newChunkAt*(x, y: int): Chunk =
  result = Chunk(
    x: x,
    y: y,
    lod: 0
  )

  result.cell = islandGenerator.generateChunk(x, y)
  result.mesh = mesh.newChunk(result.cell)
