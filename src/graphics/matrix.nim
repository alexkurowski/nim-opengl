import
  glm


const
  fov = 80.0


proc view*(position: Vec3f, rotation: Vec3f): Mat4f =
  result = mat4f()

  result = rotate(
    result,
    vec3f(1.0, 0.0, 0.0),
    rotation.x.radians
  )

  result = rotate(
    result,
    vec3f(0.0, 1.0, 0.0),
    rotation.y.radians
  )

  result = rotate(
    result,
    vec3f(0.0, 0.0, 1.0),
    rotation.z.radians
  )

  result = translate(result, -position)


proc model*(position: Vec3f, rotation: Vec3f): Mat4f =
  result = mat4f()

  result = translate(result, position)

  result = rotate(
    result,
    vec3f(1.0, 0.0, 0.0),
    rotation.x.radians
  )

  result = rotate(
    result,
    vec3f(0.0, 1.0, 0.0),
    rotation.y.radians
  )

  result = rotate(
    result,
    vec3f(0.0, 0.0, 1.0),
    rotation.z.radians
  )


proc projection*(): Mat4f =
  perspective(
    fov.radians,
    800 / 600,
    0.001,
    1000.0
  ).mat4f