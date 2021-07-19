// NOTE: this is called for each vertex in the geometry

/*
    values of these matrices are the same for each vertex
    so they are declared uniform
*/
// transforms the coordinates into the final clip space coordinates
// uniform mat4 projectionMatrix;
// holds the transformations relative to the camera
// uniform mat4 viewMatrix;
// holds the transformations applied to the mesh
// uniform mat4 modelMatrix;
// combination of modelMatrix and viewMatrix
// uniform mat4 modelViewMatrix;

/*
    In contrast to RawShaderMaterial, ShaderMaterial provides by default:
        - uniform mat4 projectionMatrix;
        - uniform mat4 viewMatrix;
        - uniform mat4 modelMatrix;
        - attribute vec3 position;
        - attribute vec2 uv;
        - precision mediump float;
*/

// uniform of the sin wave frequency passed as a uniform from script.js
uniform vec2 uFrequency;
uniform float uTime;

// position of one vertex, will be called for every vertex in the geometry
// attribute because this value will change for each vertex
// attribute vec3 position;

// custom attribute created in script.js
attribute float aRandom;

// uv coordinates which are automatically generated by the geometry
// attribute vec2 uv;

// varyings are data which is passed from the vertex to the fragment shader
// varyings are interpolated
// varying float vRandom;

// send the texture's uv coordinates to the fragment shader
varying vec2 vUv;

// elevation of the vertex is sent to the fragment shader
varying float vElevation;

void main() {
    // vRandom = aRandom;

    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
    // the whole model can now be moved
    // modelPosition.y += 1.0;
    float elevation = sin(modelPosition.x * uFrequency.x - uTime) * 0.1;
    elevation += sin(modelPosition.y * uFrequency.y - uTime) * 0.1;
    modelPosition.z += elevation;

    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;

    gl_Position = projectedPosition;

    vUv = uv;
    vElevation = elevation;
}