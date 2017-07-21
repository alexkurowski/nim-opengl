import
  opengl,
  ../shader


let vertexShaderSrc = """
#version 450

layout (location = 0) in vec2 inVertexPosition;
layout (location = 1) in vec2 inTextureCoords;

out vec2 passTextureCoords;

void main() {
  gl_Position = vec4 (inVertexPosition.x, inVertexPosition.y, 0.0, 1.0);
  passTextureCoords = inTextureCoords;
}
"""


let fragmentShaderSrc = """
#version 450

out vec4 color;

in vec2 passTextureCoords;

uniform sampler2D textureColors;

uniform float time;

void main() {
  color = texture(textureColors, passTextureCoords);
}
"""


proc newSimpleShader*(): Shader =
  result = newShader(
    [vertexShaderSrc].allocCStringArray,
    [fragmentShaderSrc].allocCStringArray
  )
  bindAttributes(result, 0, "inVertexPosition")
