#version 450

out vec4 color;

in vec2 passTextureCoords;

uniform sampler2D textureColors;

uniform bool selected;

void main() {
  if (selected)
    color = vec4(1.0, 0.0, 0.0, 1.0);
  else
    color = texture(textureColors, passTextureCoords);
}
