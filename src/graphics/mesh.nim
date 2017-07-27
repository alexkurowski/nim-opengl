import common

imports:
  opengl
  common.types

requires:
  config
  cube
  texture


type
  Mesh = ref object
    vao: GLuint
    ebo: GLuint
    vboList: seq[GLuint]
    indexCount: GLsizei


var
  current: Mesh
  meshes: seq[Mesh] = @[]


proc use*(id: int): void =
  current = meshes[id]
  glBindVertexArray(meshes[id].vao)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, meshes[id].ebo)


proc render*(): void =
  glDrawElements(GL_TRIANGLES, current.indexCount, GL_UNSIGNED_INT, nil)


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


proc new*(vertexCoords, normalCoords, textureCoords: seq[float64], indices: seq[int]): int =
  var
    vertexCoordsGl:  seq[GLfloat] = @[]
    normalCoordsGl:  seq[GLfloat] = @[]
    textureCoordsGl: seq[GLfloat] = @[]
    indicesGl:       seq[GLuint]  = @[]

  for x in vertexCoords:  vertexCoordsGl.add(x.GLfloat)
  for x in normalCoords:  normalCoordsGl.add(x.GLfloat)
  for x in textureCoords: textureCoordsGl.add(x.GLfloat)
  for x in indices:       indicesGl.add(x.GLuint)

  var mesh = Mesh(
    vboList: @[],
    indexCount: indices.len.GLsizei
  )

  glGenVertexArrays(1, mesh.vao.addr)
  glBindVertexArray(mesh.vao)

  addVBO(mesh, 3, vertexCoordsGl.addr)
  addVBO(mesh, 3, normalCoordsGl.addr)
  addVBO(mesh, 2, textureCoordsGl.addr)
  addEBO(mesh, indicesGl.addr)

  glBindVertexArray(0)

  result = meshes.len
  meshes.add(mesh)


proc newChunk*(map: CellMap): int =
  var vertexCoords:  seq[float] = @[]
  var normalCoords:  seq[float] = @[]
  var textureCoords: seq[float] = @[]
  var vertexIndices: seq[int]   = @[]

  var vrt: seq[float]
  var nrm: seq[float]
  var tex: seq[float]
  var idx: seq[int]

  var idCount: int = 0

  for x in 0..config.chunkSize - 1:
    for y in 0..config.chunkSize - 1:

      cube.new(
        map[x][y].height,
        x, y,
        idCount,
        vrt, nrm, tex, idx
      )

      for v in vrt:
        vertexCoords.add v

      for n in nrm:
        normalCoords.add n

      for t in tex:
        textureCoords.add t

      for i in idx:
        vertexIndices.add i

      idCount += vrt.len div 3

  return new(vertexCoords, normalCoords, textureCoords, vertexIndices)


proc destroyMeshes*(): void =
  for mesh in meshes:
    glDeleteVertexArrays(1, mesh.vao.addr)
    glDeleteBuffers(mesh.vboList.len.GLsizei, mesh.vboList[0].addr)
  meshes = @[]


proc initialize*(): void =
  # TODO: Create all possible meshes here
  # `proc new` then should return an id of the specific mesh
  # from a list and not create anything new
  discard
