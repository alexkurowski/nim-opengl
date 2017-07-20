import
  opengl


{.experimental.}
type
  Model* = ref object
    id: GLuint


proc newModel*[T](vertices: ptr seq[T]): Model =
  result = Model()

  glGenBuffers(1.GLsizei, result.id.addr)
  glBindBuffer(GL_ARRAY_BUFFER, result.id)
  glBufferData(
    GL_ARRAY_BUFFER,
    len(vertices[]).GLsizeiptr * sizeof(T).GLsizeiptr,
    vertices[0].addr,
    GL_STATIC_DRAW
  )
  glVertexAttribPointer(
    0.GLuint,
    2.GLint,
    cGL_FLOAT,
    GL_FALSE,
    0.GLsizei,
    nil
  )
  glEnableVertexAttribArray(0)
  glBindBuffer(GL_ARRAY_BUFFER, 0)


proc `=destroy`*(model: var Model) =
  glDeleteBuffers(1.GLsizei, model.id.addr)


proc draw*(model: Model): void =
  glBindBuffer(GL_ARRAY_BUFFER, model.id)
  glDrawArrays(GL_TRIANGLES, 0.GLint, 6.GLint)
  glBindBuffer(GL_ARRAY_BUFFER, 0)
