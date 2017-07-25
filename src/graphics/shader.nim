import common

imports:
  opengl
  glm
  matrix
  tables

requires:
  config


type
  Shader* = ref object
    id*: GLuint
    locations: Table[string, GLint]


var
  current: Shader
  simple*: Shader


proc use*(shader: Shader): void =
  current = shader


proc setFloat*(loc: string, value: float): void =
  glUniform1f(
    current.locations[loc],
    value.GLfloat
  )


proc setBool*(loc: string, value: bool): void =
  glUniform1i(
    current.locations[loc],
    value.GLint
  )


proc setMat4*(loc: string, value: Mat4f): void =
  var mat = value

  glUniformMatrix4fv(
    current.locations[loc],
    1.GLsizei,
    GL_FALSE,
    mat.caddr
  )


proc compileShader(source: cstringArray, shaderType: GLenum): GLuint =
  result = glCreateShader(shaderType)

  glShaderSource(result, 1.GLsizei, source, nil)
  glCompileShader(result)


proc create(filename: string, locations: seq[string]): Shader =
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

  shader.locations = initTable[string, GLint]()
  for location in locations:
    shader.locations[location] = glGetUniformLocation(shader.id, location)

  result = shader


proc initialize*(): void =
  simple = create("simple", config.shaderLocations["simple"])


proc destroy*() =
  glDeleteProgram(simple.id)
