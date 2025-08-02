shader_type canvas_item;

void fragment() {
	vec4 tex = texture(TEXTURE,UV);

	COLOR.rgb = tex.rgb * vec3(0.569,0.569,0.729);
	
}
