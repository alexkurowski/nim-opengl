#version 450

out vec4 color;

in vec3 passVertexPosition;
in vec3 passNormalDirection;
in vec2 passTextureCoords;

uniform sampler2D textureColors;

const float lightIntensity = 0.1;

const vec3 topLightDirection  = normalize(vec3(0.0, 1.0, 0.0));
const vec3 sideLightDirection = normalize(vec3(0.8, 1.0, 0.8));
const vec3 backLightDirection = normalize(vec3(-0.8, -1.0, -0.8));

const vec3 topLightColor  = vec3(1.0, 0.95, 0.8);
const vec3 sideLightColor = vec3(0.3, 0.8, 0.4);
const vec3 backLightColor = vec3(0.0, 0.15, 0.3);

void main() {

  color = texture(textureColors, passTextureCoords);

  float topBrightness  = dot(-topLightDirection,  passNormalDirection);
  float sideBrightness = dot(-sideLightDirection, passNormalDirection);
  float backBrightness = dot(-backLightDirection, passNormalDirection);

  vec3 brightAdd = topLightColor  * topBrightness  * lightIntensity;
  vec3 sideAdd   = sideLightColor * sideBrightness * lightIntensity;
  vec3 backAdd   = backLightColor * backBrightness * lightIntensity;

  color.r = min( color.r + brightAdd.r + sideAdd.r - backAdd.r, 1 );
  color.g = min( color.g + brightAdd.g + sideAdd.g - backAdd.g, 1 );
  color.b = min( color.b + brightAdd.b + sideAdd.b - backAdd.b, 1 );

  float heightFactor = min( max(passVertexPosition.y / 10, 0.9), 1);

  color.r *= heightFactor;
  color.g *= heightFactor;
  color.b *= heightFactor;

}
