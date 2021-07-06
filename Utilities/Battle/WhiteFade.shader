shader_type canvas_item;

uniform float effect_weight = 0.9; // How 'heavy' the effect is. Weighted Average color.

void fragment() {
	vec4 colour = texture(TEXTURE,UV);
	const vec4 white = vec4(1.0,1.0,1.0,1.0); // Pure white
	
	colour.rgb = colour.rgb + (white.rgb - colour.rgb) * effect_weight;
	
	COLOR = colour;
}
