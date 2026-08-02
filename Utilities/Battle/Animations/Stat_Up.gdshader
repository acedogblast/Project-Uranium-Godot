shader_type canvas_item;

uniform sampler2D effect;
uniform float effect_weight = 0.9; // How 'heavy' the effect is. Weighted Average color.
uniform vec2 repeat = vec2(2.735, 3.0); //62x68

void fragment() {
	vec4 colour = texture(TEXTURE,UV);
	colour.a = texture(TEXTURE,UV).a;
	
	vec2 slide;
	slide.x = 1.0;
	slide.y = TIME * 1.0;
	
	colour.rgb = texture(TEXTURE,UV).rgb * (1.0 - effect_weight) + texture(effect, vec2(UV.x / repeat.x, UV.y * repeat.y + slide.y)).rgb * effect_weight;
	
	
	
	COLOR = colour;
}
