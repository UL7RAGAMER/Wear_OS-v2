shader_type spatial;

uniform float height_scale = 0.5;
uniform sampler2D noise;
uniform sampler2D normalmap;
uniform sampler2D low_color_texture;
uniform sampler2D high_color_texture;

uniform sampler2D low_normal_texture;
uniform sampler2D high_normal_texture;

varying vec2 tex_position;

void vertex() {
  tex_position = VERTEX.xz / 2.0 + 0.5;
  float height = texture(noise, tex_position).x;
  height = clamp(pow(height * height_scale,1.5),0.1,10);
  VERTEX.y += height ;
}
void fragment() {
 	NORMAL_MAP = texture(normalmap, tex_position).xyz;
	vec3 low_color = texture(low_color_texture, UV * 6.0).rgb;
	vec3 high_color = texture(high_color_texture, UV * 6.0).rgb;
	float biased_height = pow(height_scale, 0.8);
	vec3 color = mix(low_color, high_color, biased_height);
	ALBEDO = color;
}
