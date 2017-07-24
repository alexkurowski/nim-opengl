import glm


type
  Entity* = ref object
    position*: Vec3f
    rotation*: Vec3f
    mesh*: int
