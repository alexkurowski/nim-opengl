import common

imports:
  glm
  strutils
  parseutils


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


proc load*(filename: string;
           vrt, nrm, tex, idx: var seq[float];
           ido: var int;
           position: Vec3f = vec3(0f, 0f, 0f);
           offset: Vec3f = vec3(0f, 0f, 0f);
           scale: Vec3f = vec3(1f, 1f, 1f)) =

  var vs: seq[Vec3f] = @[]
  var vn: seq[Vec3f] = @[]
  var vt: seq[Vec2f] = @[]

  var params: seq[string]
  var i, j, k: int
  var x, y, z: float
  var faceId = 0

  for line in lines("assets/models/" & filename & ".obj"):
    parseLine(line, params)

    if params.len == 0: continue

    case params[0]
    of "vn":
      parseInts(params, i, j, k)
      vn.add vec3f(i.float, j.float, k.float)

    of "vt":
      parseFloats(params, x, y, z)
      vt.add vec2f(x, y)

    of "v":
      parseInts(params, i, j, k)
      vs.add vec3f(
        (i.float + offset.x) * scale.x + position.x,
        (j.float + offset.y) * scale.y + position.y,
        (k.float + offset.z) * scale.z + position.z
      )

    of "f":
      for face in 1..3:
        parseFace(params[face], i, j, k)
        i -= 1
        j -= 1
        k -= 1
        vrt.add(vs[i].x)
        vrt.add(vs[i].y)
        vrt.add(vs[i].z)
        nrm.add(vn[k].x)
        nrm.add(vn[k].y)
        nrm.add(vn[k].z)
        tex.add(vt[j].x)
        tex.add(vt[j].y)
        idx.add((ido + faceId).float)
        faceId += 1

    else: discard

  ido += faceId
