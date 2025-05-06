shader_type canvas_item;


uniform float position : hint_range(-0.5, 0.5) = 0.0;
uniform float size : hint_range(0.5, 2) = 0.5;
uniform float angle : hint_range(0.0, 360.0) = 0.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float lod: hint_range(0.0, 5) = 0.0;
render_mode blend_premul_alpha,unshaded;

void fragment() {
	vec4 first_color = texture(SCREEN_TEXTURE, SCREEN_UV, lod);
	vec4 second_color = vec4(0.0, 0.0, 0.0, 0.0);
	float pivot = position + 0.5;
	vec2 uv = UV - pivot;
	float rotated = uv.x * cos(radians(angle)) - uv.y * sin(radians(angle)); 
	float pos = smoothstep((1.0 - size) + position, size + 0.0001 + position, rotated + pivot);
	COLOR = mix(first_color, second_color, pos); 
}
