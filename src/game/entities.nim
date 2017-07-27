import common

imports:
  glm
  common.types

requires:
  graphics.mesh
  graphics.texture


proc cubeMesh(): int =
  let vertexCoords = @[
    # back
    1.0, 0.0, 0.0,
    0.0, 0.0, 0.0,
    0.0, 1.0, 0.0,
    1.0, 1.0, 0.0,

    # right
    1.0, 0.0, 1.0,
    1.0, 0.0, 0.0,
    1.0, 1.0, 0.0,
    1.0, 1.0, 1.0,

    # front
    0.0, 0.0, 1.0,
    1.0, 0.0, 1.0,
    1.0, 1.0, 1.0,
    0.0, 1.0, 1.0,

    # left
    0.0, 0.0, 0.0,
    0.0, 0.0, 1.0,
    0.0, 1.0, 1.0,
    0.0, 1.0, 0.0,

    # top
    0.0, 1.0, 1.0,
    1.0, 1.0, 1.0,
    1.0, 1.0, 0.0,
    0.0, 1.0, 0.0,

    # bottom
    0.0, 0.0, 0.0,
    1.0, 0.0, 0.0,
    1.0, 0.0, 1.0,
    0.0, 0.0, 1.0
  ]

  let normalCoords: seq[float] = @[]

  var textureCoords: seq[float] = @[]
  # add 4 sides
  for _ in 1..4:
    for i in texture.new(1):
      textureCoords.add(i)

  # add 1 top
  for i in texture.new(0):
    textureCoords.add(i)

  # add 1 bottom
  for i in texture.new(2):
    textureCoords.add(i)

  let vertexIndices = @[
    0, 1, 2,
    2, 3, 0,

    4, 5, 6,
    6, 7, 4,

    8, 9, 10,
    10, 11, 8,

    12, 13, 14,
    14, 15, 12,

    16, 17, 18,
    18, 19, 16,

    20, 21, 22,
    22, 23, 20
  ]

  mesh.new(vertexCoords, normalCoords, textureCoords, vertexIndices)


proc new*(list: var seq[Entity], position, rotation: Vec3f, meshType: string): void =
  var mesh: int;

  case meshType
  of "cube": mesh = cubeMesh()
  else: discard

  list.add(
    Entity(
      position: position,
      rotation: rotation,
      mesh: mesh
    )
  )
