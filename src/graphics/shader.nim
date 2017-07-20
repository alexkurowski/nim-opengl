import
  opengl


{.experimental.}
type
  Shader* = ref object
    id*: GLuint


proc bindAttributes*(shader: Shader, location: GLuint, name: cstring): void =
  glBindAttribLocation(shader.id, location, name)
  discard


proc compileShader(source: cstringArray, shaderType: GLenum): GLuint =
  result = glCreateShader(shaderType)

  glShaderSource(result, 1.GLsizei, source, nil)
  glCompileShader(result)

  var isSuccess: GLint;
  glGetShaderiv(result, GL_COMPILE_STATUS, isSuccess.addr)
  if not isSuccess == 0: echo "TOO BAD"


proc newShader*(vertexSrc, fragmentSrc: cstringArray): Shader =
  result = Shader()

  var vertexShaderID = compileShader(vertexSrc, GL_VERTEX_SHADER)
  var fragmentShaderID = compileShader(fragmentSrc, GL_FRAGMENT_SHADER)

  result.id = glCreateProgram()

  glAttachShader(result.id, vertexShaderID)
  glAttachShader(result.id, fragmentShaderID)

  glLinkProgram(result.id)

  glDeleteShader(vertexShaderID)
  glDeleteShader(fragmentShaderID)


proc `=destroy`*(shader: var Shader) =
  glDeleteProgram(shader.id)
