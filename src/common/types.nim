import common

imports:
  glm

requires:
  config


type
  Action* {.pure.} = enum
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


  CellType* {.pure.} = enum
    ground,
    sand,


  Cell* = ref object
    cellType*: int # TODO: change to CellType
    height*: float


  Chunk* = ref object
    x*: int
    y*: int
    cell*: array[config.chunkSize, array[config.chunkSize, Cell]]
    lod*: int
