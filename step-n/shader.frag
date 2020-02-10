#version 300 es
precision mediump float;

in vec2 v_uv;
in vec4 v_color;

out vec4 fragColor;

uniform vec2 resolution;

void main() {
  // normalized + aspect corrected uv
  vec2 uv = 2.0 * v_uv - 1.0;
  uv.y /= resolution.x/resolution.y;
  
  // main circle
  float d = length(uv) - 0.5;
  float a = 1.0 - smoothstep(0.0, 50.0/resolution.y, d);
  
  // black outline
  float sd = length(uv) - 0.45;
  float sa = 1.0-smoothstep(0.0, 50.0/resolution.y, sd);

  fragColor = vec4(v_color.rgb*sa, v_color.a*a);
}