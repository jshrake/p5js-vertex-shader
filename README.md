# Vertex Shader Programming with p5.JS

## Getting started

You can run any of the examples locally with Python's SimpleHTTPServer:

```
cd step-0
python -m SimpleHTTPServer
```

Then open [localhost:8000](localhost:8000) in your browser. Or just follow along online with the p5.js editor.

Note that this tutorial uses WEBGL2 and will only work [on browsers that support WEBGL 2](https://caniuse.com/webgl2). In practice, this means you need to use Firefox or Chrome. Safari will not work!

## Step 0: Draw one square

[p5.js editor](https://editor.p5js.org/jshrake/sketches/SeJW2yt_)

- Understand how to configure p5js for WebGL 2
- Understand the jobs of the vertex and fragment shaders
- Configure a simple sketch with shaders

## Step 1: Multiple animated squares

[p5.js editor](https://editor.p5js.org/jshrake/sketches/0ungywqG)

- Understand how to animate attributes
    * Attributes are properties such as position, color, alpha, scale, rotation
- Distinguishing geometry with gl_VertexID
    * For each vertex, we want to know which square the vertex belongs to
    * If we want to specify per-square attributes (position, color, scale), then 
      all vertices belonging to the same square should share the same attributes
    * If each square has 6 vertices, then we can calculate a unique id for each square as
      `int square_id = floor(gl_VertexID / 6)`
- Random number generation
    * Use the square id as a seed, then hash the value

## Step N: Fragment Shading, Noise Functions, and User interaction

[p5.js editor](https://editor.p5js.org/jshrake/sketches/WUyHFW2s)

- Drawing outlined circles in each square
- Specifying user interaction through uniforms
- Noise functions
- Correct aspect ratios

## Resources

- [GLSL shader functions](http://www.shaderific.com/glsl-functions)
- [p5 js shader guide](https://itp-xstory.github.io/p5js-shaders/#/)
- [p5js shader examples (Adam Ferriss)](https://github.com/aferriss/p5jsShaderExamples)
- [Book of Shaders (Patricio Gonzalez Vivo & Jen Lowe)](https://thebookofshaders.com/)
- [vertex shader art tutorial](https://www.youtube.com/watch?v=mOEbXQWtP3M&list=PLC80qbPkXBmw3IR6JVvh7jyKogIo5Bi-d)
- [2D SDF](https://iquilezles.org/www/articles/distfunctions2d/distfunctions2d.htm)
- [OpenGL coordinate system](https://learnopengl.com/Getting-started/Coordinate-Systems)