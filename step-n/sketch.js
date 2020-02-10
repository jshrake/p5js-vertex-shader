let program;

function preload() {
  program = loadShader('shader.vert', 'shader.frag');
}

function setup() {
  // shaders require WEBGL mode to work
  createCanvas(windowWidth, windowHeight, WEBGL);
  frameRate(60.0);
}

function draw() {
  background(25);
  shader(program);

  let count = 1000.0;
  // lets send the time in seconds, window resolution, and the number of quads to draw
  program.setUniform('resolution', [width, height]);
  program.setUniform('time', millis()/1000.0);
  program.setUniform('count', count);
  program.setUniform('mouse', [mouseX, mouseY]);

  // Enable noStroke for performance, we don't need p5js to stroke our geometry
  noStroke();
  // Draw `count` quads. Each quad consists of 2 triangles (so 6 vertices)
  beginShape(TRIANGLES);
  for (let i = 0; i < count; i++) {
    // triangle 1
    vertex(-0.5 ,-0.5);
    vertex(-0.5, 0.5);
    vertex(0.5, 0.5);
    // triangle 2
    vertex(-0.5, -0.5);
    vertex(0.5, 0.5);
    vertex(0.5, -0.5);
  }
  endShape();
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}

// Hack to enable WEBGL2 and set a sane blend mode
// https://github.com/processing/p5.js/issues/2536
// https://github.com/diwi/p5.EasyCam/blob/master/examples/ReactionDiffusion_Webgl2/ReactionDiffusion_Webgl2.js#L563
p5.RendererGL.prototype._initContext = function() {
  this.drawingContext = false ||
    this.canvas.getContext('webgl2', this.attributes) ||
    this.canvas.getContext('webgl', this.attributes) ||
    this.canvas.getContext('experimental-webgl', this.attributes);
  let gl = this.drawingContext;
  gl.enable(gl.BLEND);
  gl.blendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA);
};