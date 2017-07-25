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


proc update*(dt: float): void =
  # MOVEMENT
  let speed = 4f

  var change = vec3f(0.0)

  if input.keys.contains actions.cameraGoForward:
    change.x += camera.rotation.y.radians.sin * speed
    change.z -= camera.rotation.y.radians.cos * speed
  if input.keys.contains actions.cameraGoBackward:
    change.x -= camera.rotation.y.radians.sin * speed
    change.z += camera.rotation.y.radians.cos * speed
  if input.keys.contains actions.cameraGoLeft:
    change.x -= camera.rotation.y.radians.cos * speed
    change.z -= camera.rotation.y.radians.sin * speed
  if input.keys.contains actions.cameraGoRight:
    change.x += camera.rotation.y.radians.cos * speed
    change.z += camera.rotation.y.radians.sin * speed

  if input.keys.contains actions.cameraGoUp:
    change.y += speed
  if input.keys.contains actions.cameraGoDown:
    change.y -= speed

  camera.position += change * dt

  # ROTATION
  camera.rotation.x -= input.mouseDelta.y.float
  camera.rotation.y -= input.mouseDelta.x.float

  if camera.rotation.x > 90:
    camera.rotation.x = 90
  if camera.rotation.x < -90:
    camera.rotation.x = -90

  while camera.rotation.y < 0:
    camera.rotation.y += 360;
  while camera.rotation.y >= 360:
    camera.rotation.y -= 360;

  # RAY CASTING
  let rayWorld = ray.castFromScreen(input.mousePosition)

  if camera.position.y > 0 and rayWorld.y < 0: # if camera above 0 plane and mouse point looks down
    var point = camera.position
    let distance = -1f * ( point.y / rayWorld.y )
    let x = ( point.x + rayWorld.x * distance ).floor
    let y = ( point.z + rayWorld.z * distance ).floor
    let selectedId = ( x * 32 + y ).int
