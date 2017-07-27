import common

imports:
  glm
  common.types

requires:
  config
  input
  physics.ray
  game.camera
  game.chunks
  game.entities


const
  allowDebugCameraMovement = true


var
  chunkList*: seq[Chunk] = @[]
  entityList*: seq[Entity] = @[]


proc load*(): void =
  chunks.initialize()

  for i in 0..config.mapSize:
    for j in 0..config.mapSize:
      chunkList.add chunks.newChunkAt(i, j)

  camera.moveTo vec3f(8, 0, 8)


proc cameraMovement(dt: float): void =
  if allowDebugCameraMovement:
    let speed = 12f
    var change = vec3f(0.0)

    if input.keys.contains Action.cameraGoForward:
      change.x += camera.rotation.y.radians.sin
      change.z -= camera.rotation.y.radians.cos
    if input.keys.contains Action.cameraGoBackward:
      change.x -= camera.rotation.y.radians.sin
      change.z += camera.rotation.y.radians.cos
    if input.keys.contains Action.cameraGoLeft:
      change.x -= camera.rotation.y.radians.cos
      change.z -= camera.rotation.y.radians.sin
    if input.keys.contains Action.cameraGoRight:
      change.x += camera.rotation.y.radians.cos
      change.z += camera.rotation.y.radians.sin

    if input.keys.contains Action.cameraGoUp:
      change.y += 1
    if input.keys.contains Action.cameraGoDown:
      change.y -= 1

    if change.length != 0:
      camera.move(change.normalize * speed * dt)

  if allowDebugCameraMovement or input.isDown(Action.cameraDrag):
    camera.rotate(input.mouseDelta.y.float, input.mouseDelta.x.float)


proc update*(dt: float): void =
  cameraMovement(dt)

  # RAY CASTING
  let rayWorld = ray.castFromScreen(input.mousePosition)

  if camera.position.y > 0 and rayWorld.y < 0: # if camera above 0 plane and mouse point looks down
    var point = camera.position
    let distance = -1f * ( point.y / rayWorld.y )
    let x = ( point.x + rayWorld.x * distance ).floor
    let y = ( point.z + rayWorld.z * distance ).floor
    let selectedId = ( x * 32 + y ).int
