shader_type canvas_item;

uniform vec2 screen_location = vec2(.5);
uniform float radi = .1;

uniform ivec2 reso = ivec2(1152, 648);

float circle(vec2 position, float radius, float feather)
{
	vec2 freso = vec2(reso);
	float ratio = freso.x/freso.y;
	float len = length((position - vec2(.5))*(vec2(ratio, 1.0))*(1.0/ratio));
	return smoothstep(radius, radius + feather, len);
}

void fragment() {
	COLOR.a = circle(UV+(screen_location-vec2(.5)), radi , .01);
}
