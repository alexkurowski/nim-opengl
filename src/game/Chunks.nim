import common

imports:
  glm
  common.types

requires:
  Config
  IslandGenerator
  graphics/ChunkMesh


const
  size = Config.chunkSize


proc initialize*() =
  IslandGenerator.initialize()


proc newChunkAt*(x, y: int): Chunk =
  result = Chunk(
    x: x,
    y: y,
    lod: 0
  )

  result.cell = IslandGenerator.generateChunk(x, y)
  result.mesh = ChunkMesh.new(x, y)
