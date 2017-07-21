import
  opengl,
  glm,
  entity,
  tables


type
  Shader = ref object
    id*: GLuint
    locations: Table[string, GLint]


var
  shaders*: seq[Shader] = @[]


proc setFloat*(id: int, loc: string, value: float): void =
  glUniform1f(
    shaders[id].locations[loc],
    value.GLfloat
  )


proc setMat4*(id: int, loc: string, value: Mat4f): void =
  var mat = value

  glUniformMatrix4fv(
    shaders[id].locations[loc],
    1.GLsizei,
    GL_FALSE,
    mat.caddr
  )


proc compileShader(source: cstringArray, shaderType: GLenum): GLuint =
  result = glCreateShader(shaderType)

  glShaderSource(result, 1.GLsizei, source, nil)
  glCompileShader(result)

  var isSuccess: GLint;
  glGetShaderiv(result, GL_COMPILE_STATUS, isSuccess.addr)
  if not isSuccess == 0: echo "TOO BAD"


proc initializeLocations(shader: var Shader): void =
  shader.locations = initTable[string, GLint]()

  var locations = ["viewMatrix", "modelMatrix", "projMatrix"]
  for location in locations:
    shader.locations[location] = glGetUniformLocation(shader.id, location)


proc new*(filename: string): int =
  var shader = Shader()

  var vertexSrc   = [readFile("assets/shaders/" & filename & ".glslv")].allocCStringArray
  var fragmentSrc = [readFile("assets/shaders/" & filename & ".glslf")].allocCStringArray

  var vertexShaderID   = compileShader(vertexSrc, GL_VERTEX_SHADER)
  var fragmentShaderID = compileShader(fragmentSrc, GL_FRAGMENT_SHADER)

  shader.id = glCreateProgram()

  glAttachShader(shader.id, vertexShaderID)
  glAttachShader(shader.id, fragmentShaderID)

  glLinkProgram(shader.id)

  glDeleteShader(vertexShaderID)
  glDeleteShader(fragmentShaderID)

  initializeLocations(shader)

  result = shaders.len
  shaders.add(shader)

  glUseProgram(shader.id)
  var mat = projMatrix()
  setMat4(
    result,
    "projMatrix",
    mat
  )
  glUseProgram(0)


proc destroy*() =
  for shader in shaders:
    glDeleteProgram(shader.id)
