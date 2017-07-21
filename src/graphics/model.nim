import
  opengl


{.experimental.}
type
  Model* = ref object
    vao*: GLuint
    buffers: seq[GLuint]
    indexCount*: GLsizei


proc addVBO*(model: Model, dimensions: cint, vertices: ptr seq[GLfloat]): void =
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
    model.buffers.len.GLuint,
    dimensions.GLint,
    cGL_FLOAT,
    GL_FALSE,
    0.GLsizei,
    nil
  )

  glEnableVertexAttribArray(model.buffers.len.GLuint)

  model.buffers.add(vbo)

  glBindBuffer(GL_ARRAY_BUFFER, 0)


proc addEBO*(model: Model, indices: ptr seq[GLuint]): void =
  var ebo: GLuint
  glGenBuffers(1.GLsizei, ebo.addr)
  glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo)

  glBufferData(
    GL_ELEMENT_ARRAY_BUFFER,
    GLsizeiptr( indices[].len * sizeof(GLuint) ),
    indices[0].addr,
    GL_STATIC_DRAW
  )

  model.buffers.add(ebo)

  # glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0)



proc newModel*(vertexCoords, textureCoords: ptr seq[GLfloat], indices: ptr seq[GLuint]): Model =
  result = Model(
    buffers: @[],
    indexCount: indices[].len.GLsizei
  )

  glGenVertexArrays(1, result.vao.addr)
  glBindVertexArray(result.vao)

  addVBO(result, 2, vertexCoords)
  addVBO(result, 2, textureCoords)
  addEBO(result, indices)

  glBindVertexArray(0)


proc `=destroy`*(model: var Model) =
  glDeleteVertexArrays(1, model.vao.addr)
  glDeleteBuffers(model.buffers.len.GLsizei, model.buffers[0].addr)
