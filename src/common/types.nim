import glm


type
  actions* {.pure.} = enum
    cameraRotateLeft,
    cameraRotateRight,
    cameraGoForward,
    cameraGoBackward,
    cameraGoLeft,
    cameraGoRight,
    cameraGoUp,
    cameraGoDown,
    cameraDrag,


  Entity* = ref object
    position*: Vec3f
    rotation*: Vec3f
    mesh*: int
