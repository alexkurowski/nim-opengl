import
  opengl


type
  Model* = ref object
    vao*: GLuint
    ebo*: GLuint
    vboList: seq[GLuint]
    indexCount*: GLsizei


var
  models*: seq[Model] = @[]


proc addVBO(model: var Model, dimensions: cint, vertices: ptr seq[GLfloat]): void =
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
    model.vboList.len.GLuint,
    dimensions.GLint,
    cGL_FLOAT,
    GL_FALSE,
    0.GLsizei,
    nil
  )

  glBindBuffer(GL_ARRAY_BUFFER, 0)

  glEnableVertexAttribArray(model.vboList.len.GLuint)

  model.vboList.add(vbo)


proc addEBO(model: var Model, indices: ptr seq[GLuint]): void =
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

  model.ebo = ebo
  model.vboList.add(ebo)


proc new*(vertexCoords, textureCoords: seq[float64], indices: seq[int]): int =
  var
    vertexCoordsGl:  seq[GLfloat] = @[]
    textureCoordsGl: seq[GLfloat] = @[]
    indicesGl:       seq[GLuint]  = @[]

  for x in vertexCoords:  vertexCoordsGl.add(x.GLfloat)
  for x in textureCoords: textureCoordsGl.add(x.GLfloat)
  for x in indices:       indicesGl.add(x.GLuint)

  var model = Model(
    vboList: @[],
    indexCount: indices.len.GLsizei
  )

  glGenVertexArrays(1, model.vao.addr)
  glBindVertexArray(model.vao)

  addVBO(model, 2, vertexCoordsGl.addr)
  addVBO(model, 2, textureCoordsGl.addr)
  addEBO(model, indicesGl.addr)

  glBindVertexArray(0)

  result = models.len
  models.add(model)


proc destroy*() =
  for model in models:
    glDeleteVertexArrays(1, model.vao.addr)
    glDeleteBuffers(model.vboList.len.GLsizei, model.vboList[0].addr)
