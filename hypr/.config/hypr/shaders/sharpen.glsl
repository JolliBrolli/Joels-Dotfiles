#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
out vec4 fragColor;

void main() {
    // Sharpness: 0.0 is off, 1.0 is very sharp. 
    // Since you're on a matte screen, 0.6 is a good sweet spot.
    float sharpness = 0.6; 
    
    // Zenbook S16 Resolution: 2880 x 1800
    vec2 res = vec2(2880.0, 1800.0);
    vec2 texelSize = 1.0 / res;
    
    vec4 center = texture(tex, v_texcoord);
    vec4 top    = texture(tex, v_texcoord + vec2(0, texelSize.y));
    vec4 bottom = texture(tex, v_texcoord - vec2(0, texelSize.y));
    vec4 left   = texture(tex, v_texcoord - vec2(texelSize.x, 0));
    vec4 right  = texture(tex, v_texcoord + vec2(texelSize.x, 0));
    
    vec4 blurred = (top + bottom + left + right) * 0.25;
    
    // Apply the sharpening math
    vec3 sharpenedColor = center.rgb + (center.rgb - blurred.rgb) * sharpness;
    
    fragColor = vec4(sharpenedColor, center.a);
}
