#version 300 es
precision mediump float;

in vec3 aPosition;
in vec2 aTexCoord;

out vec2 v_uv;
out vec4 v_color;

uniform float time;

void main() {
  vec4 pos = vec4(aPosition, 1.0);

  // Required output, the position in NDC space
  gl_Position = pos;
  
  // Write `out` attributes required by the fragment shader
  v_color = vec4(0.4, 0.5, 1.0, 1.0);
  v_uv    = aPosition.xy + 0.5;
}