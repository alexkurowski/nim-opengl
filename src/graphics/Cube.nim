import common

requires:
  Texture


proc new*(height: float,
          x, y, id: int,
          vrt, nrm, tex: var seq[float64],
          idx: var seq[int]) =
  ## height - height of the created cube
  ## x, y   - position of a mesh inside chunk
  ## id     - where to start counting indices
  ## vrt    - seq for new vertex coordinates
  ## nrm    - seq for vertex normal directions
  ## tex    - seq for new texture coordinates
  ## idx    - seq for vertex indices
  let x1: float = x.float
  let x2: float = x.float + 1
  let y1: float = 0f
  let y2: float = -height
  let z1: float = y.float
  let z2: float = y.float + 1

  vrt = @[
    # back
    x2, y1, z1,
    x1, y1, z1,
    x1, y2, z1,
    x2, y2, z1,

    # right
    x2, y1, z2,
    x2, y1, z1,
    x2, y2, z1,
    x2, y2, z2,

    # front
    x1, y1, z2,
    x2, y1, z2,
    x2, y2, z2,
    x1, y2, z2,

    # left
    x1, y1, z1,
    x1, y1, z2,
    x1, y2, z2,
    x1, y2, z1,

    # top
    x1, y2, z2,
    x2, y2, z2,
    x2, y2, z1,
    x1, y2, z1,

    # bottom
    # x1, y1, z1,
    # x2, y1, z1,
    # x2, y1, z2,
    # x1, y1, z2
  ]

  nrm = @[
    # back
    0.0, 0.0, -1.0,
    0.0, 0.0, -1.0,
    0.0, 0.0, -1.0,
    0.0, 0.0, -1.0,

    # right
    1.0, 0.0, 0.0,
    1.0, 0.0, 0.0,
    1.0, 0.0, 0.0,
    1.0, 0.0, 0.0,

    # front
    0.0, 0.0, 1.0,
    0.0, 0.0, 1.0,
    0.0, 0.0, 1.0,
    0.0, 0.0, 1.0,

    # left
    -1.0, 0.0, 0.0,
    -1.0, 0.0, 0.0,
    -1.0, 0.0, 0.0,
    -1.0, 0.0, 0.0,

    # top
    0.0, 1.0, 0.0,
    0.0, 1.0, 0.0,
    0.0, 1.0, 0.0,
    0.0, 1.0, 0.0,

    # bottom
    # 0.0, -1.0, 0.0,
    # 0.0, -1.0, 0.0,
    # 0.0, -1.0, 0.0,
    # 0.0, -1.0, 0.0
  ]

  # Add a texture with id = 0 six times for each side
  # except bottom
  tex = @[]
  for _ in 1..5:
    for i in Texture.new(0):
      tex.add i

  idx = @[
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

    # 20, 21, 22,
    # 22, 23, 20
  ]

  for i in 0..idx.len - 1:
    idx[i] += id
