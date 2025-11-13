shader_type spatial;
render_mode shadows_disabled;

varying vec3 world_pos;

uniform float scale : hint_range(0.0, 1.0) = 0.05;
uniform float animation_speed : hint_range(0.0, 10.0, 0.1) = 0.8;
uniform sampler2D noise : filter_nearest_mipmap_anisotropic;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable;

void vertex() {
	world_pos = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	vec2 new_uv = world_pos.xz * scale;
	new_uv.x += sin(TIME * animation_speed + (new_uv.x + new_uv.y) * 25.0) * 0.01;
	new_uv.y += cos(TIME * animation_speed + (new_uv.x - new_uv.y) * 25.0) * 0.01;

	vec2 new_screen_uv = SCREEN_UV;
	new_screen_uv.x += sin(TIME * animation_speed + (new_screen_uv.x + new_screen_uv.y) * 25.0) * 0.01;
	new_screen_uv.y += cos(TIME * animation_speed + (new_screen_uv.x - new_screen_uv.y) * 25.0) * 0.01;

	ALBEDO = texture(screen_texture, new_screen_uv).rgb * 0.2;
	NORMAL_MAP = texture(noise, new_uv).rgb;
	ROUGHNESS = 0.1;
}
