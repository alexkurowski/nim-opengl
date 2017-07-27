#version 450

out vec4 color;

in vec3 passNormalDirection;
in vec2 passTextureCoords;

uniform sampler2D textureColors;

const vec3 lightDirection = normalize(vec3(0.4, 1.0, 0.8));

void main() {

  float brightness = max( dot(-lightDirection, passNormalDirection), 0.3 );

  color = texture(textureColors, passTextureCoords) * brightness;

}
