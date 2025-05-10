shader_type canvas_item;


void fragment() {
	vec4 input_color = texture(TEXTURE,UV);
	float color_average = (input_color.r + input_color.g + input_color.b) / 3.0;
	COLOR = vec4(color_average, color_average, color_average, input_color.a);
}
