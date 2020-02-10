#version 300 es
precision mediump float;

in vec2 v_uv;
in vec4 v_color;

out vec4 fragColor;

uniform vec2 resolution;

void main() {
  fragColor = v_color;
}