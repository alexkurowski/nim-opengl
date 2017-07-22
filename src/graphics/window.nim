import
  sdl2,
  opengl


const
  SDL_MODE = SDL_WINDOW_OPENGL or SDL_WINDOW_RESIZABLE
  GL_MAJOR = 3
  GL_MINOR = 1


var
  window: WindowPtr
  context: GlContextPtr


proc resize*(width, height: int): void =
  # glViewport(0, 0, width, height)                  # Set the viewport to cover the new window
  # glMatrixMode(GL_PROJECTION)                      # To operate on the projection matrix
  # glLoadIdentity()                                 # Reset the model-view matrix
  # gluPerspective(45.0, width / height, 0.1, 100.0) # Enable perspective projection with fovy, aspect, zNear and zFar
  discard


proc clear*(): void =
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)


proc swap*(): void =
  glSwapWindow(window)


proc initializeWindow*(title: cstring, width, height: cint): void =
  discard sdl2.init(INIT_EVERYTHING)

  discard glSetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE)
  discard glSetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, GL_MAJOR)
  discard glSetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, GL_MINOR)

  window = createWindow(
    title,
    SDL_WINDOWPOS_CENTERED,
    SDL_WINDOWPOS_CENTERED,
    width,
    height,
    SDL_MODE
  )
  context = glCreateContext(window)

  resize(width, height)


proc initializeOpenGl*(): void =
  loadExtensions()
  echo("INFO: OpenGL version ", cast[cstring](glGetString(GL_VERSION)))
  glClearColor(0.1, 0.1, 0.1, 1.0)                  # Set background color to black and opaque
  # glClearDepth(1.0)                                 # Set background depth to farthest
  # glEnable(GL_DEPTH_TEST)                           # Enable depth testing for z-culling
  # glDepthFunc(GL_LEQUAL)                            # Set the type of depth-test
  # glShadeModel(GL_SMOOTH)                           # Enable smooth shading
  # glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST) # Nice perspective corrections


proc destroy*(): void =
  destroy(window)
