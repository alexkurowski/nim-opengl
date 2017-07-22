import
  glm,
  ../../graphics/mesh,
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
  discard


proc draw*(): seq[Entity] =
  @[quad]
