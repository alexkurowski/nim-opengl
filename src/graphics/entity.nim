import
  opengl,
  glm


type
  Entity* = ref object
    position*: Vec3f
    rotation*: Vec3f


proc viewMatrix*(e: Entity): Mat4f =
  result = mat4f()

  result = rotate(
    result,
    vec3f(1.0, 0.0, 0.0),
    e.rotation.x.radians
  )

  result = rotate(
    result,
    vec3f(0.0, 1.0, 0.0),
    e.rotation.y.radians
  )

  result = rotate(
    result,
    vec3f(0.0, 0.0, 1.0),
    e.rotation.z.radians
  )

  result = translate(result, -e.position)


proc modelMatrix*(e: Entity): Mat4f =
  result = mat4f()

  result = translate(result, e.position)

  result = rotate(
    result,
    vec3f(1.0, 0.0, 0.0),
    e.rotation.x.radians
  )

  result = rotate(
    result,
    vec3f(0.0, 1.0, 0.0),
    e.rotation.y.radians
  )

  result = rotate(
    result,
    vec3f(0.0, 0.0, 1.0),
    e.rotation.z.radians
  )


proc projMatrix*(): Mat4f =
  perspective(
    radians(120.0),
    800 / 600,
    0.001,
    1000.0
  ).mat4f
