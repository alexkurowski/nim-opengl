include common

imports:
  sdl2
  opengl

requires:
  config


const
  mode = SDL_WINDOW_OPENGL or SDL_WINDOW_RESIZABLE


var
  window: WindowPtr
  context: GlContextPtr
  width*: int
  height*: int


proc resize*(w, h: int): void =
  width  = w
  height = h

  glViewport( # Set the viewport to cover the new window
    0.GLint,
    0.GLint,
    w.GLsizei,
    h.GLsizei
  )
  discard


proc clear*(): void =
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)


proc swap*(): void =
  glSwapWindow(window)


proc initializeWindow*(): void =
  width  = config.windowWidth
  height = config.windowHeight

  discard sdl2.init(INIT_EVERYTHING)

  discard glSetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE)
  discard glSetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, config.glMajor.cint)
  discard glSetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, config.glMinor.cint)

  window = createWindow(
    config.windowTitle.cstring,
    SDL_WINDOWPOS_CENTERED,
    SDL_WINDOWPOS_CENTERED,
    width.cint,
    height.cint,
    mode
  )
  context = glCreateContext(window)


proc initializeOpenGl*(): void =
  loadExtensions()
  echo("INFO: OpenGL version ", cast[cstring](glGetString(GL_VERSION)))
  glClearColor(0.1, 0.1, 0.1, 1.0)                  # Set background color to black and opaque
  glClearDepth(1.0)                                 # Set background depth to farthest
  glEnable(GL_DEPTH_TEST)                           # Enable depth testing for z-culling
  glDepthFunc(GL_LEQUAL)                            # Set the type of depth-test
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST) # Nice perspective corrections

  resize(width, height)


proc destroy*(): void =
  destroy(window)
