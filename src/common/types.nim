import glm


type
  actions* = enum
    cameraRotateLeft,
    cameraRotateRight,
    cameraGoForward,
    cameraGoBackward,
    cameraGoLeft,
    cameraGoRight,
    cameraGoUp,
    cameraGoDown,


  Entity* = ref object
    position*: Vec3f
    rotation*: Vec3f
    mesh*: int
