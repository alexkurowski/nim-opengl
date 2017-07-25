import common

imports:
  glm

requires:
  graphics.matrix


var
  position*: Vec3f = vec3f(0.0, 0.0, 0.0)
  rotation*: Vec3f = vec3f(0.0, 0.0, 0.0)
  distance*: float = 2
  fov*: float = 80.0
  projection*: Mat4f
  view*: Mat4f


proc updateMatrices(): void =
  # TODO: rework rotation value to get a lookat normalized vector
  projection = matrix.projection(fov)
  view = matrix.view(position, rotation)


proc move*(change: Vec3f): void =
  position += change
  updateMatrices()


proc moveTo*(newPosition: Vec3f): void =
  position = newPosition
  updateMatrices()


proc rotate*(vx, vy: float): void =
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
