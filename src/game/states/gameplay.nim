import
  glm,
  ../../graphics/mesh,
  ../../input,
  ../camera,
  ../entity


var
  quad: Entity


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

  quad = Entity(
    position: vec3f(0.0, 0.0, -3.0),
    rotation: vec3f(0.0, 0.0, 0.0),
    mesh: mesh.new(vertexCoords, textureCoords, vertexIndices)
  )


proc update*(): void =
  if input.lastKey == 97:
    camera.position.x -= 0.01
  if input.lastKey == 100:
    camera.position.x += 0.01
  if input.lastKey == 115:
    camera.position.y -= 0.01
  if input.lastKey == 119:
    camera.position.y += 0.01

  if input.lastKey == 101:
    camera.rotation.y += 0.1
  if input.lastKey == 113:
    camera.rotation.y -= 0.1


proc draw*(): seq[Entity] =
  @[quad]
