import
  glm,
  ../../graphics/mesh,
  ../../graphics/texture,
  ../../input,
  ../camera,
  ../entity


var
  quads*: seq[Entity] = @[]


proc load*(): void =
  var vertexCoords = @[
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

  var vertexIndices = @[
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

  for i in 0..15:
    for j in 0..15:
      for k in 0..5:
        quads.add(
          Entity(
            position: vec3f(i.float, -k.float, j.float),
            rotation: vec3f(0.0, 0.0, 0.0),
            mesh: mesh.new(vertexCoords, textureCoords, vertexIndices)
          )
        )


proc update*(dt: float): void =
  let speed = 4f

  var change = vec3f(0.0)

  if input.keys.contains cameraGoForward:
    change.x += camera.rotation.y.radians.sin * speed
    change.z -= camera.rotation.y.radians.cos * speed
  if input.keys.contains cameraGoBackward:
    change.x -= camera.rotation.y.radians.sin * speed
    change.z += camera.rotation.y.radians.cos * speed
  if input.keys.contains cameraGoLeft:
    change.x -= camera.rotation.y.radians.cos * speed
    change.z -= camera.rotation.y.radians.sin * speed
  if input.keys.contains cameraGoRight:
    change.x += camera.rotation.y.radians.cos * speed
    change.z += camera.rotation.y.radians.sin * speed

  if input.keys.contains cameraGoUp:
    change.y += speed
  if input.keys.contains cameraGoDown:
    change.y -= speed

  camera.position += change * dt

  camera.rotation.x -= input.mouseDelta.y.float
  camera.rotation.y -= input.mouseDelta.x.float

  if camera.rotation.x > 80:
    camera.rotation.x = 80
  if camera.rotation.x < -80:
    camera.rotation.x = -80

  while camera.rotation.y < 0:
    camera.rotation.y += 360;
  while camera.rotation.y >= 360:
    camera.rotation.y -= 360;
