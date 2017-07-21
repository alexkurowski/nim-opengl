import
  opengl


var
  shaders*: seq[GLuint] = @[]


proc bindAttributes*(shader: GLuint, location: GLuint, name: cstring): void =
  glBindAttribLocation(shader, location, name)


proc compileShader(source: cstringArray, shaderType: GLenum): GLuint =
  result = glCreateShader(shaderType)

  glShaderSource(result, 1.GLsizei, source, nil)
  glCompileShader(result)

  var isSuccess: GLint;
  glGetShaderiv(result, GL_COMPILE_STATUS, isSuccess.addr)
  if not isSuccess == 0: echo "TOO BAD"


proc new*(filename: string): int =
  var vertexSrc   = [readFile("assets/shaders/" & filename & ".glslv")].allocCStringArray
  var fragmentSrc = [readFile("assets/shaders/" & filename & ".glslf")].allocCStringArray

  var vertexShaderID   = compileShader(vertexSrc, GL_VERTEX_SHADER)
  var fragmentShaderID = compileShader(fragmentSrc, GL_FRAGMENT_SHADER)

  var id = glCreateProgram()

  glAttachShader(id, vertexShaderID)
  glAttachShader(id, fragmentShaderID)

  glLinkProgram(id)

  glDeleteShader(vertexShaderID)
  glDeleteShader(fragmentShaderID)

  result = shaders.len
  shaders.add(id)


proc destroy*() =
  for shader in shaders:
    glDeleteProgram(shader)
