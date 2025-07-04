shader_type canvas_item;

uniform sampler2D under_texture;
uniform float wipe_progress : hint_range(-1.0, 1.0);
uniform float size : hint_range(0.0, 1.0) = 0.1;
uniform float block_size = 4.0;

float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec2 pixel_pos = floor(UV / TEXTURE_PIXEL_SIZE / vec2(block_size));

    float x_norm = pixel_pos.x / (1.0 / (TEXTURE_PIXEL_SIZE.x * block_size));

    float dissolve_end = 1.0 - wipe_progress;
    float dissolve_start = dissolve_end - size;

    float rand_val = random(pixel_pos);

    vec4 base_color = texture(TEXTURE, UV);
    vec4 under_color = texture(under_texture, UV);

    if (x_norm > dissolve_end) {
        COLOR = vec4(0.0);
    } else if (x_norm < dissolve_start) {
        COLOR = base_color;
    } else {
        float local_progress = 1.0 - ((x_norm - dissolve_start) / max(size, 0.001));
        float threshold = rand_val;

        vec4 color = base_color;
        color.a *= step(threshold, local_progress);

        float blend_factor = smoothstep(dissolve_start, dissolve_end, x_norm);
        color.rgb = mix(color.rgb, under_color.rgb, blend_factor);

        COLOR = color;
    }
}
