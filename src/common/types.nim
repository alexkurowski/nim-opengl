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


  CellMap* = array[config.chunkSize, array[config.chunkSize, Cell]]


  Chunk* = ref object
    x*: int
    y*: int
    cell*: CellMap
    lod*: int
    mesh*: int
