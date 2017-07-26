import common

imports:
  glm

requires:
  window


proc projection*(fov: float): Mat4f =
  result = perspective(
    fov.radians,
    window.width.float / window.height.float,
    0.001,
    1000.0
  ).mat4f


proc view*(position, rotation: Vec3f): Mat4f =
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


proc chunk*(x, y: int, height: float): Mat4f =
  translate(mat4f, vec3f(x.float, height, y.float))


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
