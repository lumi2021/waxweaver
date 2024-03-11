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
		//new = tex;
		new.r = tex.r*1.125;
		new.g = tex.g*1.05;
		new.b = tex.b*1.115;
		
	
		new = clamp(new,vec4(0.0),vec4(1.0));
		new = floor(new * 16.0)/16.0; // banding
		
		if(new.r > 0.9){ new.r = 1.0; }
		if(new.g > 0.9){ new.g = 1.0; }
		if(new.b > 0.9){ new.b = 1.0; }
		
		COLOR = multiply(screen,new);
	}
}

