#version 300 es

precision mediump float;
in vec2 v_texcoord;
layout(location = 0) out vec4 fragColor;
uniform sampler2D tex;
uniform vec2 pointer_position;
uniform vec2 screen_size;
uniform vec2 pos;

bool between(float val, float minimum, float maximum) {
    if (minimum <= val && val <= maximum) {
        return true;
    }
    return false;
}

void main() {
    vec4 pixColor = texture(tex, v_texcoord);

    float x = gl_FragCoord[0];
    float y = gl_FragCoord[1];

    vec2 cur_pos = pointer_position.xy * screen_size.xy;

    if (between(x, cur_pos.x, cur_pos.x + 1.0) || between(y, cur_pos.y, cur_pos.y + 1.0)) {
        // pixColor.xyz = vec3(1.0, 0.0, 0.0);
    }

    // if (x > cur_pos.x) {
    //     pixColor.xyzw = texture(tex, vec2(v_texcoord.x + 10.0 / screen_size.x, v_texcoord.y + 0.0 / screen_size.y));
    // }

    fragColor = pixColor;
}
