shader_type canvas_item;
render_mode unshaded;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform vec2 scrollAmount = vec2(0.05, 0.05);
uniform float multiplierAmount : hint_range(0.0, 0.1) = 0.01;
uniform sampler2D noise: repeat_enable, filter_nearest;

void fragment() {
	
	vec2 distortionUV = SCREEN_UV + texture(noise, UV + scrollAmount * TIME).r * multiplierAmount;
	
	vec4 sckween = texture(screen_texture, distortionUV);
	if(sckween.r < 0.05 && sckween.g > 0.99 && sckween.b < 0.05){
		sckween.a = 0.0;
	}
	
	
	COLOR = texture(screen_texture,SCREEN_UV);
}