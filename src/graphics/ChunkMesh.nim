import common

imports:
  glm
  common.types

requires:
  Config
  MeshLoader
  Mesh


proc new*(): int =
  var vrt: seq[float] = @[]
  var nrm: seq[float] = @[]
  var tex: seq[float] = @[]
  var idx: seq[float] = @[]

  let offset = vec3f(4f, 0, 4f)
  let scale  = vec3f(1/8)

  MeshLoader.load("grass1", vrt, nrm, tex, idx, offset, scale)

  return Mesh.new(vrt, nrm, tex, idx)

  # var vrt: seq[float]
  # var nrm: seq[float]
  # var tex: seq[float]
  # var idx: seq[int]
  #
  # var idCount: int = 0
  #
  # for x in 0..Config.chunkSize - 1:
  #   for y in 0..Config.chunkSize - 1:
  #
  #     Cube.new(
  #       map[x][y].height,
  #       x, y,
  #       idCount,
  #       vrt, nrm, tex, idx
  #     )
  #
  #     for v in vrt:
  #       vertexCoords.add v
  #
  #     for n in nrm:
  #       normalCoords.add n
  #
  #     for t in tex:
  #       textureCoords.add t
  #
  #     for i in idx:
  #       vertexIndices.add i
  #
  #     idCount += vrt.len div 3
