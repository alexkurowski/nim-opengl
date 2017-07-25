#version 450

out vec4 color;

in vec2 passTextureCoords;

uniform sampler2D textureColors;

void main() {
  color = texture(textureColors, passTextureCoords);
}
