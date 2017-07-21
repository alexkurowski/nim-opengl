#version 450

layout (location = 0) in vec3 inVertexPosition;
layout (location = 1) in vec2 inTextureCoords;

out vec2 passTextureCoords;

uniform mat4 projMatrix;
uniform mat4 viewMatrix;
uniform mat4 modelMatrix;

void main() {

  gl_Position = projMatrix *
                viewMatrix *
                modelMatrix *
                vec4 (
                  inVertexPosition.x,
                  inVertexPosition.y,
                  inVertexPosition.z,
                  1.0
                );

  passTextureCoords = inTextureCoords;

}
