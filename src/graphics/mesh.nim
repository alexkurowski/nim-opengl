import common

imports:
  opengl


type
  Mesh* = ref object
    vao*: GLuint
    ebo*: GLuint
    vboList: seq[GLuint]
    indexCount*: GLsizei


var
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
  discard
