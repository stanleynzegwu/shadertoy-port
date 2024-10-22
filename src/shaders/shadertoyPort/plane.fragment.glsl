// uniform float iTime;
// uniform vec3 iResolution;
// uniform sampler2D iChannel0;
// uniform sampler2D iChannel1;
// uniform sampler2D iChannel2;

// varying vec2 vUv;

// void mainImage(out vec4 color, vec2 coord)
// {
//     vec3 res = iResolution;
//     vec3 dir = vec3(res.xy - coord * 2.0, res.x) / res.x;
//     vec3 pos;
    
//     // Use RG channels of last frame for the GB (brightened by /.7)
//     color = vec4(0, texture(iChannel0, coord / res.xy) / 0.7);
    
//     for(float i = 0.0; i < 100.0; i++) {
//         pos = dir * (texture(iChannel2, coord / 1000.0).r + i) * 0.1 + 9.0;
//         pos.xz = mat2(cos(iTime * 0.1 + asin(vec4(0.0, 1.0, -1.0, 0.0)))) * pos.xz;
//         color.r += (100.0 - i) / 100000.0 / abs(texture(iChannel1, pos * 0.1).r + dot(sin(pos), cos(pos.yzx)));
//     }
// }

// void main() {
//   vec2 coord = vUv * iResolution.xy;
//   vec4 color;
//   mainImage(color, coord);
//   gl_FragColor = color;
// }


uniform float iTime;
uniform vec3 iResolution;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;

varying vec2 vUv;

void mainImage(out vec4 color, vec2 coord)
{
    vec3 res = iResolution;
    vec3 dir = vec3(res.xy - coord * 2.0, res.x) / res.x;
    vec3 pos;

    // Sample from iChannel0 and ensure the correct color is used
    vec4 tex0 = texture(iChannel0, vUv);
    
    color = vec4(0.0);  // Initialize the color to black
    
    // Adjust the loop count for performance while debugging
    for (float i = 0.0; i < 50.0; i++) {
        // Calculate position for sampling
        pos = dir * (tex0.r + i) * 0.1 + 9.0;
        
        // Rotation matrix to rotate `pos.xz`
        float angle = iTime * 0.1;
        mat2 rotationMatrix = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
        pos.xz = rotationMatrix * pos.xz;

        // Sample from iChannel1 and accumulate
        vec4 tex1 = texture(iChannel1, pos.xy * 0.1);  // Ensure pos.xy is within range

        color.r += (50.0 - i) / 50000.0 / abs(tex1.r + dot(sin(pos), cos(pos.yzx)));
    }
}

void main() {
    vec4 color;
    mainImage(color, vUv * iResolution.xy);
    gl_FragColor = color;
}




// void main() {
//     // Set the output color to a solid red (RGB)
//     gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);  // Red color
// }