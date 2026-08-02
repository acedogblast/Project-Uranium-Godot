shader_type canvas_item;

uniform sampler2D mask_texture;

void fragment() {
    vec4 colour = texture(TEXTURE, UV);
    colour.a *= texture(mask_texture, UV).a;

    COLOR = colour;
}