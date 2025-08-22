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

bool cross_check(vec2 pos, float border_width, float prong_length, vec2 centre) {
    vec2 rast_pos = pos.xy * screen_size.xy;
    vec2 rast_centre = centre.xy * screen_size.xy;

    bool x_mid_check = between(rast_pos.x, rast_centre.x - border_width / 2.0 + 0.5, rast_centre.x + border_width / 2.0 + 0.5);
    bool y_mid_check = between(rast_pos.y, rast_centre.y - border_width / 2.0 + 0.5, rast_centre.y + border_width / 2.0 + 0.5);

    bool x_length_check = between(rast_pos.x, rast_centre.x - prong_length, rast_centre.x + prong_length + 0.5);
    bool y_length_check = between(rast_pos.y, rast_centre.y - prong_length, rast_centre.y + prong_length + 0.5);

    if ((x_mid_check || y_mid_check) && (x_length_check && y_length_check))
    {
        return true;
    }
    return false;
}

void main() {
    vec4 pixColor = texture(tex, v_texcoord);

    float x = gl_FragCoord.x;
    float y = gl_FragCoord.y;

    vec2 cur_pos = pointer_position.xy * screen_size.xy;

    if (between(x, cur_pos.x, cur_pos.x + 1.0) || between(y, cur_pos.y, cur_pos.y + 1.0)) {
        // pixColor.xyz = vec3(1.0, 0.0, 0.0);
    }

    // if (x == screen_size.x / 2.0 + 0.5 || y == screen_size.y / 2.0 + 0.5) {
    // if ((between(x, screen_size.x / 2.0 - 0.5, screen_size.x / 2.0 + 1.5) || between(y, screen_size.y / 2.0 - 0.5, screen_size.y / 2.0 + 1.5)) && (between(x, 0.5 * screen_size.x - 10.0, 0.5 * screen_size.x + 10.5) && between(y, 0.5 * screen_size.y - 10.0, 0.5 * screen_size.y + 10.5))) {
    //     pixColor.xyz = 1.0 - pixColor.xyz;
    // pixColor.xyz = vec3(1.0, 0.0, 0.0);
    // }

    // if (cross_check(v_texcoord, 3.0, 10.0, pointer_position.xy)) {
    //     pixColor.xyz = 1.0 - pixColor.xyz;
    // }

    vec4 avg = vec4(0.0, 0.0, 0.0, 0.0);

    for (float i = -3.0; i <= 3.0; i++) {
        for (float j = -3.0; i <= 3.0; i++) {
            avg += texture(tex, vec2(v_texcoord.x + i / screen_size.x, v_texcoord.y + j / screen_size.y));
        }
    }

    // pixColor.xyzw = avg.xyzw / 7.0;

    fragColor = pixColor;
}
