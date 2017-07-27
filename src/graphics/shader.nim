import common

imports:
  opengl
  glm
  matrix
  tables

requires:
  config


type
  Shader = ref object
    id: GLuint
    locations: Table[string, GLint]


var
  current: Shader
  shaders: Table[string, Shader]


proc use*(name: string): void =
  current = shaders[name]
  glUseProgram(shaders[name].id)


proc id*(): GLuint =
  current.id


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


proc create(typeName: string): Shader =
  result = Shader()

  var vertexSrc   = [readFile("assets/shaders/" & typeName & ".glslv")].allocCStringArray
  var fragmentSrc = [readFile("assets/shaders/" & typeName & ".glslf")].allocCStringArray

  var vertexShaderID   = compileShader(vertexSrc, GL_VERTEX_SHADER)
  var fragmentShaderID = compileShader(fragmentSrc, GL_FRAGMENT_SHADER)

  result.id = glCreateProgram()

  glAttachShader(result.id, vertexShaderID)
  glAttachShader(result.id, fragmentShaderID)

  glLinkProgram(result.id)

  glDeleteShader(vertexShaderID)
  glDeleteShader(fragmentShaderID)

  let locations = config.shaderSettings[typeName]

  result.locations = initTable[string, GLint]()
  for location in locations:
    result.locations[location] = glGetUniformLocation(result.id, location)


proc initialize*(): void =
  shaders = initTable[string, Shader]()
  shaders["simple"] = create("simple")
  shaders["chunk"] = create("chunk")


proc destroy*() =
  glDeleteProgram(shaders["simple"].id)
  glDeleteProgram(shaders["chunk"].id)
