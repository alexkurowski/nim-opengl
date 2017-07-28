import common

imports:
  glm

requires:
  game/Camera
  graphics/Window
  graphics/Matrix


proc castFromScreen*(cursor: Vec2i): Vec3f =
  let mx = (cursor.x.float * 2f) / Window.width.float - 1f
  let my = 1f - (cursor.y.float * 2f) / Window.height.float

  # var eye = inverse(matrix.projection(camera.fov)) * vec4f(mx, my, -1f, 1f)
  var eye = inverse(Camera.projection) * vec4f(mx, my, -1f, 1f)
  eye.z = -1f
  eye.w = 0f

  # ( inverse(matrix.view(camera.position, camera.rotation)) * eye ).xyz.normalize
  ( inverse(Camera.view) * eye ).xyz.normalize
