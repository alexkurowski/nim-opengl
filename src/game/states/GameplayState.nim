import common

imports:
  glm
  common.types

requires:
  Config
  Input
  physics/Ray
  game/Camera
  game/Chunks


const
  allowDebugCameraMovement = true


var
  chunkList*: seq[Chunk] = @[]
  entityList*: seq[Entity] = @[]


proc load*() =
  Chunks.initialize()

  for i in 0..Config.mapSize - 1:
    for j in 0..Config.mapSize - 1:
      chunkList.add Chunks.newChunkAt(i, j)

  Camera.moveTo vec3f(8, 0, 8)


proc cameraMovement(dt: float) =
  if allowDebugCameraMovement:
    let speed = 12f
    var change = vec3f(0.0)

    if Input.keys.contains Action.cameraGoForward:
      change.x += Camera.rotation.y.radians.sin
      change.z -= Camera.rotation.y.radians.cos
    if Input.keys.contains Action.cameraGoBackward:
      change.x -= Camera.rotation.y.radians.sin
      change.z += Camera.rotation.y.radians.cos
    if Input.keys.contains Action.cameraGoLeft:
      change.x -= Camera.rotation.y.radians.cos
      change.z -= Camera.rotation.y.radians.sin
    if Input.keys.contains Action.cameraGoRight:
      change.x += Camera.rotation.y.radians.cos
      change.z += Camera.rotation.y.radians.sin

    if Input.keys.contains Action.cameraGoUp:
      change.y += 1
    if Input.keys.contains Action.cameraGoDown:
      change.y -= 1

    if change.length != 0:
      Camera.move(change.normalize * speed * dt)

  if allowDebugCameraMovement or Input.isDown(Action.cameraDrag):
    Camera.rotate(Input.mouseDelta.y.float, Input.mouseDelta.x.float)


proc update*(dt: float) =
  cameraMovement(dt)

  # RAY CASTING
  let rayWorld = Ray.castFromScreen(Input.mousePosition)

  if Camera.position.y > 0 and rayWorld.y < 0: # if camera above 0 plane and mouse point looks down
    var point = Camera.position
    let distance = -1f * ( point.y / rayWorld.y )
    let x = ( point.x + rayWorld.x * distance ).floor
    let y = ( point.z + rayWorld.z * distance ).floor
    let selectedId = ( x * 32 + y ).int
