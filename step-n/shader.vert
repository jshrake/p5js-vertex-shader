#version 300 es
precision mediump float;

in vec3 aPosition;
in vec2 aTexCoord;

out vec2 v_uv;
out vec4 v_color;

uniform float count;
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;


// Hash functions https://www.shadertoy.com/view/XdGfRR
#define UI0 1597334673U
#define UI1 3812015801U
#define UI2 uvec2(UI0, UI1)
#define UI3 uvec3(UI0, UI1, 2798796415U)
#define UIF (1.0 / float(0xffffffffU))

float SEED = 0.0;
float rand(inout float seed)
{
	uvec2 n = uint(int(seed)) * UI2;
	uint q = (n.x ^ n.y) * UI0;
    seed += 0.05;
	return float(q) * UIF;
}

// https://github.com/hughsk/glsl-hsv2rgb
vec3 hsv2rgb(vec3 c) {
  vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
  vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
  return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

// Simplex noise function from IQ
// https://www.shadertoy.com/view/Msf3WH
vec2 shash( vec2 p ) // replace this by something better
{
	p = vec2( dot(p,vec2(127.1,311.7)), dot(p,vec2(269.5,183.3)) );
	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}

float snoise( in vec2 p )
{
    const float K1 = 0.366025404; // (sqrt(3)-1)/2;
    const float K2 = 0.211324865; // (3-sqrt(3))/6;

	vec2  i = floor( p + (p.x+p.y)*K1 );
    vec2  a = p - i + (i.x+i.y)*K2;
    float m = step(a.y,a.x); 
    vec2  o = vec2(m,1.0-m);
    vec2  b = a - o + K2;
	vec2  c = a - 1.0 + 2.0*K2;
    vec3  h = max( 0.5-vec3(dot(a,a), dot(b,b), dot(c,c) ), 0.0 );
	vec3  n = h*h*h*h*vec3( dot(a,shash(i+0.0)), dot(b,shash(i+o)), dot(c,shash(i+1.0)));
    return dot( n, vec3(70.0) );
}




void main() {
  float aspect = resolution.x/resolution.y;
  float id = floor(float(gl_VertexID)  / 6.0);
  float pct = id / count;
  SEED = id;
  
  // Calculate NDC mouse position
  vec2 mousepos =  2.0*mouse/resolution - 1.0;
  mousepos.y *= -1.0;

  // The two positions the quad will linearly interpolate between
  vec2 off = vec2(0.0);
  off.x += mix(0.25, 0.5, rand(SEED))*cos(2.0*3.1416*rand(SEED));
  off.y += mix(0.25, 0.5, rand(SEED))*aspect*sin(2.0*3.1416*rand(SEED));
  
  vec2 circ = vec2(0.0);
  circ.x += mix(0.5, 0.75, rand(SEED))*cos(5.0*3.1416*pct);
  circ.y += mix(0.5, 0.75, rand(SEED))*aspect*sin(5.0*3.1416*pct);
  
  // snoise returns a number between -1, 1
  float n = snoise(0.5*circ.xy + 0.2*time);
  n = smoothstep(-0.5, 0.5, n);
  
  // linearly interpolate between off and circ, using the noise value n
  vec4 pos = vec4(aPosition, 1.0);
  pos.xy *= 0.2*clamp(n, 0.5, 1.0); // quad scale, as a function of noise
  pos.xy += mix(circ, off, n);
  
  // Required output, the position in NDC space
  gl_Position = pos;
  
  // Write `out` attributes required by the fragment shader
  // Make the whiteness a function of the distance between the quad and the mouse
  float moused = distance(pos.xy, mousepos.xy);
  moused = 1.0 - smoothstep(0.0, 1.0, moused);
  v_color = vec4(hsv2rgb(vec3(rand(SEED), 0.75*moused, 0.9)), n);
  v_uv = aPosition.xy + 0.5;
}