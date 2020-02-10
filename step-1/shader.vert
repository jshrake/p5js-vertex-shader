#version 300 es
precision mediump float;

in vec3 aPosition;
in vec2 aTexCoord;

out vec2 v_uv;
out vec4 v_color;

uniform float time;
uniform float count;

// Hash functions https://www.shadertoy.com/view/XdGfRR
#define UI0 1597334673U
#define UI1 3812015801U
#define UI2 uvec2(UI0, UI1)
#define UI3 uvec3(UI0, UI1, 2798796415U)
#define UIF (1.0 / float(0xffffffffU))

float SEED = 0.0;

// Returns [0.0, 1.0]
float rand(inout float seed)
{
	uvec2 n = uint(int(seed)) * UI2;
	uint q = (n.x ^ n.y) * UI0;
    seed += 7.05;
	return float(q) * UIF;
}

// https://github.com/hughsk/glsl-hsv2rgb
vec3 hsv2rgb(vec3 c) {
  vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
  vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
  return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}


void main() {
  float id = floor(float(gl_VertexID) / 6.0);
  float pct = id / count;
  SEED = id;
  
  vec4 pos = vec4(aPosition, 1.0);
  float zo = (0.5 + 0.5 * sin(3.0*pct + time));
  float radius = mix(0.1, 1.0, rand(SEED)) * zo;
  // Scale
  pos.xy *= mix(0.01, 0.03, rand(SEED)) * zo;
  // Position
  pos.x += 2.0*(pct - 0.5);
  pos.y += radius * sin(2.0 * 3.1416 * pct + time);
  
  // Required output, the position in NDC space
  gl_Position = pos;
  
  // Write `out` attributes required by the fragment shader
  v_color = vec4(hsv2rgb(vec3(rand(SEED), 1.0, 1.0)), 1.0);
  v_uv    = aPosition.xy + 0.5;
}