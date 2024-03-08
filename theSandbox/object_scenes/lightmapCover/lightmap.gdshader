shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

vec4 multiply(vec4 base, vec4 blend){
	return base * blend;
}

void fragment() {
	vec4 screen = texture(screen_texture,SCREEN_UV);
	vec4 tex = texture(TEXTURE,UV);
	vec4 new = tex;
	
	if(screen.r < 0.01 && screen.g > 0.99 && screen.b < 0.01 ){
		
		COLOR = screen;
		
	}
	else{
		new.r = tex.r*9.0;
		new.g = tex.g*8.2;
		new.b = tex.b*9.5;
	
		new = clamp(new,vec4(0.0),vec4(1.0));
		new = floor(new * 10.0)/10.0;
	
		COLOR = multiply(screen,new);
	}
}

