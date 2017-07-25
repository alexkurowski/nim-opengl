import common

imports:
  glm

requires:
  graphics.matrix


var
  position*: Vec3f = vec3f(0.0, 0.0, 0.0)
  rotation*: Vec3f = vec3f(0.0, 0.0, 0.0)
  fov*: float = 80.0
  projection*: Mat4f
  view*: Mat4f


proc updateMatrices(): void =
  projection = matrix.projection(fov)
  view = matrix.view(position, rotation)


proc move*(change: Vec3f): void =
  camera.position += change
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
