import
  opengl,
  ../shader


let vertexShaderSrc = """
#version 450

layout (location = 0) in vec2 inVertexPosition;

void main() {
  gl_Position = vec4 (inVertexPosition.x, inVertexPosition.y, 0.0, 1.0);
}
"""


let fragmentShaderSrc = """
#version 450

out vec4 color;

void main() {
  color = vec4 (1.0, 0.0, 0.0, 1.0);
}
"""


proc newSimpleShader*(): Shader =
  result = newShader(
    [vertexShaderSrc].allocCStringArray,
    [fragmentShaderSrc].allocCStringArray
  )
  bindAttributes(result, 0, "inVertexPosition")
