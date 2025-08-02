shader_type canvas_item;

void fragment() {
	vec4 tex = texture(TEXTURE,UV);
	if(tex.rgb == vec3(0.0,1.0,0.0)){
		COLOR = vec4(0.0);
	}
	
}
