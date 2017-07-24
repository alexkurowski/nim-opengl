import common

imports:
  glm

requires:
  game.camera
  graphics.window
  graphics.matrix


proc castFromScreen*(cursor: Vec2i): Vec3f =
  let mx = (cursor.x.float * 2f) / window.width.float - 1f
  let my = 1f - (cursor.y.float * 2f) / window.height.float

  let clip = vec4f(mx, my, -1f, 1f)
  var eye  = inverse(matrix.projection(camera.fov)) * clip
  eye.z = -1f
  eye.w = 0f

  ( inverse(matrix.view(camera.position, camera.rotation)) * eye ).xyz.normalize
