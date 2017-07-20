import
  opengl


{.experimental.}
type
  Model* = ref object
    vao: GLuint
    buffers: seq[GLuint]


proc addVBO*[T](model: Model, dimensions: cint, vertices: ptr seq[T]): void =
  var vbo: GLuint;
  glGenBuffers(1.GLsizei, vbo.addr)
  glBindBuffer(GL_ARRAY_BUFFER, vbo)

  glBufferData(
    GL_ARRAY_BUFFER,
    GLsizeiptr( vertices[].len * sizeof(T) ),
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


proc newModel*[T](vertices: ptr seq[T]): Model =
  result = Model(buffers: @[])

  glGenVertexArrays(1, result.vao.addr)
  glBindVertexArray(result.vao)

  addVBO[T](result, 2, vertices)

  glBindVertexArray(0)


proc `=destroy`*(model: var Model) =
  glDeleteVertexArrays(1, model.vao.addr)
  glDeleteBuffers(model.buffers.len.GLsizei, model.buffers[0].addr)


proc draw*(model: Model): void =
  glBindVertexArray(model.vao)
  glDrawArrays(GL_TRIANGLES, 0.GLint, 6.GLint)
  glBindVertexArray(0)
