import common

imports:
  glm
  common.types

requires:
  random
  perlin
  input
  physics.ray
  game.camera
  game.entities


var
  entityList*: seq[Entity] = @[]


proc load*(): void =
  camera.position.x = 10.5
  camera.position.z = 10.5

  random.randomize()
  let noise = perlin.newNoise()
  var height: float

  for i in 0..31:
    for j in 0..31:
      height = ( perlin.simplex(noise, i.float / 4, j.float / 4) * 12 ) * -1.0
      entities.new(
        list = entityList,
        position = vec3f(i.float, height, j.float),
        rotation = vec3f(0.0, 0.0, 0.0),
        meshType = "cube"
      )


proc cameraMovement(dt: float): void =
  var change = vec3f(0.0)

  if input.keys.contains actions.cameraGoForward:
    change.x += camera.rotation.y.radians.sin
    change.z -= camera.rotation.y.radians.cos
  if input.keys.contains actions.cameraGoBackward:
    change.x -= camera.rotation.y.radians.sin
    change.z += camera.rotation.y.radians.cos
  if input.keys.contains actions.cameraGoLeft:
    change.x -= camera.rotation.y.radians.cos
    change.z -= camera.rotation.y.radians.sin
  if input.keys.contains actions.cameraGoRight:
    change.x += camera.rotation.y.radians.cos
    change.z += camera.rotation.y.radians.sin

  if input.keys.contains actions.cameraGoUp:
    change.y += 1
  if input.keys.contains actions.cameraGoDown:
    change.y -= 1

  if change.length != 0:
    let speed = 4f
    camera.move(change.normalize * speed * dt)

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
