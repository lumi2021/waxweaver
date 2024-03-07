shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec4 modulate : source_color = vec4(1.0);

void fragment() {
	vec4 screen = texture(screen_texture,SCREEN_UV);
	vec4 tex = texture(TEXTURE,UV);
	COLOR = vec4(0.0);
	if(screen.r < 0.01 && screen.g > 0.01 && screen.b < 0.01 ){
		COLOR = tex * modulate;
	}
	
	
}
