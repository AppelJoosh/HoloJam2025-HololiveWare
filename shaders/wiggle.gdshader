shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform float strength = 0.01;
uniform float wait = 1.0;

float random (vec2 uv, float x) {
    return fract(sin(dot(uv.xy, vec2(12.9898,78.233)) * x) * 43758.5453123);
}


void fragment() {
	// Called for every pixel the material is visible on.
	float random_x = (random(UV, UV.y * floor(TIME / wait)) - 0.5) * strength;
	float random_y = (random(UV, UV.x * floor(TIME / wait)) - 0.5) * strength;
	COLOR = texture(TEXTURE, UV + vec2(random_x, random_y));
}
