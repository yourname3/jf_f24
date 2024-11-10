shader_type canvas_item;

uniform float all_scale = 0.0f;

void vertex() {
	// Called for every vertex the material is visible on.
}

float circle(vec2 pos, vec2 uv, vec2 scale, float aa, float radius) {
	vec2 d = uv - pos;
	d *= scale;
	float r = length(d);
	return smoothstep(1.0, 0.0, (r - radius) / aa);
}

void fragment() {
	vec2 scale = vec2(1.0, 1.0);
	if(SCREEN_PIXEL_SIZE.y > SCREEN_PIXEL_SIZE.x) {
		scale.x = SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
	}
	else if(SCREEN_PIXEL_SIZE.y < SCREEN_PIXEL_SIZE.x) {
		scale.y = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	}
	
	vec2 aa = fwidth(UV);
	float aa_f = max(aa.x, aa.y);
	aa_f = max(aa_f, 0.000001);
	
	float a = circle(vec2(0.6, 0.55), UV, scale, aa_f, 1.0 * all_scale);
	a = max(a, circle(vec2(0.25, 0.35), UV, scale, aa_f, 0.55 * all_scale));
	a = max(a, circle(vec2(0.85, 0.25), UV, scale, aa_f, 0.25 * all_scale));
	a = max(a, circle(vec2(0.15, 0.24), UV, scale, aa_f, 0.38 * all_scale));
	a = max(a, circle(vec2(0.89, 0.89), UV, scale, aa_f, 0.19 * all_scale));
	a = max(a, circle(vec2(0.05, 0.9), UV, scale, aa_f, 0.8 * all_scale));
	COLOR.a = a;
}