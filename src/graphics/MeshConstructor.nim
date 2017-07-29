import common

imports:
  glm
  tables
  strutils
  parseutils
  common.types


type
  Mesh = ref object
    vn: seq[Vec3f]
    vt: seq[Vec2f]
    v:  seq[Vec3f]
    f:  seq[Vec3i]


var
  meshes: Table[string, Mesh]


proc parseLine(line: string, params: var seq[string]) =
  params = line.split(" ")


proc parseFace(param: string; x, y, z: var int) =
  let params = param.split("/")
  discard parseInt( params[0], x )
  discard parseInt( params[1], y )
  discard parseInt( params[2], z )


proc parseInts(params: seq[string], x, y, z: var int) =
  if params.len >= 2: discard parseInt( params[1], x )
  else: x = 0

  if params.len >= 3: discard parseInt( params[2], y )
  else: y = 0

  if params.len >= 4: discard parseInt( params[3], z )
  else: z = 0


proc parseFloats(params: seq[string], x, y, z: var float) =
  if params.len >= 2: discard parseFloat( params[1], x )
  else: x = 0f

  if params.len >= 3: discard parseFloat( params[2], y )
  else: y = 0f

  if params.len >= 4: discard parseFloat( params[3], z )
  else: z = 0f


proc load(filename: string): Mesh =
  result = Mesh(
    vn: @[],
    vt: @[],
    v:  @[],
    f:  @[]
  )

  var params: seq[string]
  var i, j, k: int
  var x, y, z: float

  for line in lines("assets/models/" & filename & ".obj"):
    parseLine(line, params)

    if params.len == 0: continue

    case params[0]
    of "vn":
      parseInts(params, i, j, k)
      result.vn.add vec3f(i.float, j.float, k.float)

    of "vt":
      parseFloats(params, x, y, z)
      result.vt.add vec2f(x, y)

    of "v":
      parseInts(params, i, j, k)
      result.v.add vec3f(
        i.float,
        j.float,
        k.float
      )

    of "f":
      for face in 1..3:
        parseFace(params[face], i, j, k)
        result.f.add vec3i(
          int32(i - 1),
          int32(j - 1),
          int32(k - 1)
        )

    else: discard


proc initialize*() =
  meshes = initTable[string, Mesh]()
  meshes["grass1"] = load("grass1")
  meshes["grass2"] = load("grass2")
  discard


proc add*(meshType: string;
          vrt, nrm, tex, idx: var seq[float];
          idOffset: var int;
          position: Vec3f = vec3(0f, 0f, 0f);
          offset: Vec3f = vec3(0f, 0f, 0f);
          scale: Vec3f = vec3(1f, 1f, 1f)) =

  let mesh = meshes[meshType]
  var i = 0

  for f in mesh.f:
    vrt.add((mesh.v[f.x].x + offset.x) * scale.x + position.x)
    vrt.add((mesh.v[f.x].y + offset.y) * scale.y + position.y)
    vrt.add((mesh.v[f.x].z + offset.z) * scale.z + position.z)
    tex.add mesh.vt[f.y].x
    tex.add mesh.vt[f.y].y
    nrm.add mesh.vn[f.z].x
    nrm.add mesh.vn[f.z].y
    nrm.add mesh.vn[f.z].z
    idx.add float(i + idOffset)
    i += 1

  idOffset += i
