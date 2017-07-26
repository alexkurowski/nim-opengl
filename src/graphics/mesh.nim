import common

imports:
  opengl

requires:
  texture


type
  Mesh* = ref object
    vao*: GLuint
    ebo*: GLuint
    vboList: seq[GLuint]
    indexCount*: GLsizei


var
  cube*: int
  meshes*: seq[Mesh] = @[]


proc addVBO(mesh: var Mesh, dimensions: cint, vertices: ptr seq[GLfloat]): void =
  var vbo: GLuint
  glGenBuffers(1.GLsizei, vbo.addr)
  glBindBuffer(GL_ARRAY_BUFFER, vbo)

  glBufferData(
    GL_ARRAY_BUFFER,
    GLsizeiptr( vertices[].len * sizeof(GLfloat) ),
    vertices[0].addr,
    GL_STATIC_DRAW
  )
  glVertexAttribPointer(
    mesh.vboList.len.GLuint,
    dimensions.GLint,
    cGL_FLOAT,
    GL_FALSE,
    0.GLsizei,
    nil
  )

  glBindBuffer(GL_ARRAY_BUFFER, 0)

  glEnableVertexAttribArray(mesh.vboList.len.GLuint)

  mesh.vboList.add(vbo)


proc addEBO(mesh: var Mesh, indices: ptr seq[GLuint]): void =
  var ebo: GLuint
  glGenBuffers(1.GLsizei, ebo.addr)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo)

  glBufferData(
    GL_ELEMENT_ARRAY_BUFFER,
    GLsizeiptr( indices[].len * sizeof(GLuint) ),
    indices[0].addr,
    GL_STATIC_DRAW
  )

  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0)

  mesh.ebo = ebo
  mesh.vboList.add(ebo)


proc new*(vertexCoords, textureCoords: seq[float64], indices: seq[int]): int =
  var
    vertexCoordsGl:  seq[GLfloat] = @[]
    textureCoordsGl: seq[GLfloat] = @[]
    indicesGl:       seq[GLuint]  = @[]

  for x in vertexCoords:  vertexCoordsGl.add(x.GLfloat)
  for x in textureCoords: textureCoordsGl.add(x.GLfloat)
  for x in indices:       indicesGl.add(x.GLuint)

  var mesh = Mesh(
    vboList: @[],
    indexCount: indices.len.GLsizei
  )

  glGenVertexArrays(1, mesh.vao.addr)
  glBindVertexArray(mesh.vao)

  addVBO(mesh, 3, vertexCoordsGl.addr)
  addVBO(mesh, 2, textureCoordsGl.addr)
  addEBO(mesh, indicesGl.addr)

  glBindVertexArray(0)

  result = meshes.len
  meshes.add(mesh)


proc destroyMeshes*() =
  for mesh in meshes:
    glDeleteVertexArrays(1, mesh.vao.addr)
    glDeleteBuffers(mesh.vboList.len.GLsizei, mesh.vboList[0].addr)


proc initialize*(): void =
  # TODO: Create all possible meshes here
  # `proc new` then should return an id of the specific mesh
  # from a list and not create anything new
  let vertexCoords = @[
    # back
    1.0, 0.0, 0.0,
    0.0, 0.0, 0.0,
    0.0, 1.0, 0.0,
    1.0, 1.0, 0.0,

    # right
    1.0, 0.0, 1.0,
    1.0, 0.0, 0.0,
    1.0, 1.0, 0.0,
    1.0, 1.0, 1.0,

    # front
    0.0, 0.0, 1.0,
    1.0, 0.0, 1.0,
    1.0, 1.0, 1.0,
    0.0, 1.0, 1.0,

    # left
    0.0, 0.0, 0.0,
    0.0, 0.0, 1.0,
    0.0, 1.0, 1.0,
    0.0, 1.0, 0.0,

    # top
    0.0, 1.0, 1.0,
    1.0, 1.0, 1.0,
    1.0, 1.0, 0.0,
    0.0, 1.0, 0.0,

    # bottom
    0.0, 0.0, 0.0,
    1.0, 0.0, 0.0,
    1.0, 0.0, 1.0,
    0.0, 0.0, 1.0
  ]

  var textureCoords: seq[float] = @[]
  # add 4 sides
  for _ in 1..4:
    for i in texture.new(1):
      textureCoords.add(i)

  # add 1 top
  for i in texture.new(0):
    textureCoords.add(i)

  # add 1 bottom
  for i in texture.new(2):
    textureCoords.add(i)

  let vertexIndices = @[
    0, 1, 2,
    2, 3, 0,

    4, 5, 6,
    6, 7, 4,

    8, 9, 10,
    10, 11, 8,

    12, 13, 14,
    14, 15, 12,

    16, 17, 18,
    18, 19, 16,

    20, 21, 22,
    22, 23, 20
  ]

  cube = new(vertexCoords, textureCoords, vertexIndices)
