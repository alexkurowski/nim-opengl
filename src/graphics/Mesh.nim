import common

imports:
  opengl
  common.types

requires:
  MeshConstructor


type
  Mesh = ref object
    vao: GLuint
    ebo: GLuint
    vboList: seq[GLuint]
    indexCount: GLsizei


var
  current: Mesh
  meshes: seq[Mesh] = @[]


proc use*(id: int) =
  current = meshes[id]
  glBindVertexArray(meshes[id].vao)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, meshes[id].ebo)


proc render*() =
  glDrawElements(GL_TRIANGLES, current.indexCount, GL_UNSIGNED_INT, nil)


proc addVBO(mesh: var Mesh, dimensions: cint, vertices: ptr seq[GLfloat]) =
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


proc addEBO(mesh: var Mesh, indices: ptr seq[GLuint]) =
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


proc new*(vertexCoords, normalCoords, textureCoords, indices: seq[float]): int =
  var
    vertexCoordsGl:  seq[GLfloat] = @[]
    normalCoordsGl:  seq[GLfloat] = @[]
    textureCoordsGl: seq[GLfloat] = @[]
    indicesGl:       seq[GLuint]  = @[]

  for x in vertexCoords:  vertexCoordsGl.add(x.GLfloat)
  for x in normalCoords:  normalCoordsGl.add(x.GLfloat)
  for x in textureCoords: textureCoordsGl.add(x.GLfloat)
  for x in indices:       indicesGl.add(x.int.GLuint)

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


proc initialize*() =
  MeshConstructor.initialize()


proc destroyAll*() =
  for mesh in meshes:
    glDeleteVertexArrays(1, mesh.vao.addr)
    glDeleteBuffers(mesh.vboList.len.GLsizei, mesh.vboList[0].addr)
  meshes = @[]
