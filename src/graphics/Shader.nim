import common

imports:
  opengl
  glm
  tables
  common.types

requires:
  Config


type
  Shader = ref object
    id: GLuint
    locations: Table[string, GLint]


var
  current: Shader
  shaders: Table[ShaderType, Shader]


proc use*(name: ShaderType) =
  current = shaders[name]
  glUseProgram(shaders[name].id)


proc id*(): GLuint =
  current.id


proc setFloat*(loc: string, value: float) =
  glUniform1f(
    current.locations[loc],
    value.GLfloat
  )


proc setBool*(loc: string, value: bool) =
  glUniform1i(
    current.locations[loc],
    value.GLint
  )


proc setMat4*(loc: string, value: Mat4f) =
  var mat = value

  glUniformMatrix4fv(
    current.locations[loc],
    1.GLsizei,
    GL_FALSE,
    mat.caddr
  )


proc compileShader(source: string, shaderType: GLenum): GLuint =
  result = glCreateShader(shaderType)

  glShaderSource(result, 1.GLsizei, [source].allocCStringArray, nil)
  glCompileShader(result)


proc create(filename: string): Shader =
  let vertexSrc   = readFile("assets/shaders/" & filename & ".glslv")
  let fragmentSrc = readFile("assets/shaders/" & filename & ".glslf")

  var vertexShaderID   = compileShader(vertexSrc, GL_VERTEX_SHADER)
  var fragmentShaderID = compileShader(fragmentSrc, GL_FRAGMENT_SHADER)

  result = Shader()
  result.id = glCreateProgram()

  glAttachShader(result.id, vertexShaderID)
  glAttachShader(result.id, fragmentShaderID)

  glLinkProgram(result.id)

  glDeleteShader(vertexShaderID)
  glDeleteShader(fragmentShaderID)

  let locations = Config.shaderSettings[filename]

  result.locations = initTable[string, GLint]()
  for location in locations:
    result.locations[location] = glGetUniformLocation(result.id, location)


proc initialize*() =
  shaders = initTable[ShaderType, Shader]()
  shaders[ShaderType.simple] = create("simple")
  shaders[ShaderType.chunk] = create("chunk")


proc destroyAll*() =
  glDeleteProgram(shaders[ShaderType.simple].id)
  glDeleteProgram(shaders[ShaderType.chunk].id)
