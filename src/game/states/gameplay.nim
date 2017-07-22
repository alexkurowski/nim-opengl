import
  glm,
  ../../graphics/mesh,
  ../../input,
  ../camera,
  ../entity


var
  quads*: seq[Entity] = @[]


proc load*(): void =
  var vertexCoords = @[
     0.5,  0.5,  0.0,
    -0.5,  0.5,  0.0,
    -0.5, -0.5,  0.0,
     0.5, -0.5,  0.0
  ]

  var textureCoords = @[
     1.0, 1.0,
     0.0, 1.0,
     0.0, 0.0,
     1.0, 0.0
  ]

  var vertexIndices = @[
    0, 1, 2,
    2, 3, 0
  ]

  for i in 0..10:
    for j in 0..10:
      quads.add(
        Entity(
          position: vec3f(i.float, j.float, -3.0),
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

  camera.position += change * dt

  if input.keys.contains cameraRotateLeft:
    camera.rotation.y -= 0.1
  if input.keys.contains cameraRotateRight:
    camera.rotation.y += 0.1
