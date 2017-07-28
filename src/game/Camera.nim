import common

imports:
  glm

requires:
  graphics/Matrix


var
  position*: Vec3f = vec3f(0.0, 0.0, 0.0)
  rotation*: Vec3f = vec3f(0.0, 0.0, 0.0)
  distance*: float = 2
  fov*: float = 80.0
  projection*: Mat4f
  view*: Mat4f


proc updateMatrices() =
  let positionAdd = vec3f(
    0.5 - rotation.y.radians.sin * distance,
    0,
    0.5 + rotation.y.radians.cos * distance
  )

  projection = Matrix.projection(fov)
  view = Matrix.view(position + positionAdd, rotation)


proc move*(change: Vec3f) =
  position += change
  updateMatrices()


proc moveTo*(newPosition: Vec3f) =
  position = newPosition
  updateMatrices()


proc rotate*(vx, vy: float) =
  rotation.x -= vx
  rotation.y -= vy

  if rotation.x > 90:
    rotation.x = 90
  if rotation.x < -90:
    rotation.x = -90

  while rotation.y < 0:
    rotation.y += 360;
  while rotation.y >= 360:
    rotation.y -= 360;

  updateMatrices()
