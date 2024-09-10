shader_type spatial;

uniform sampler2D noise_texture;
uniform sampler2D normal_map;
uniform sampler2D low_color_texture;
uniform sampler2D high_color_texture;

uniform sampler2D low_normal_texture;
uniform sampler2D high_normal_texture;

uniform sampler2D low_roughness_texture;
uniform sampler2D high_roughness_texture;

uniform float displacement_strength = 1.0;

varying vec3 world_normal;
varying vec3 world_position;

void vertex() {
    vec2 uv = UV;

    // Displacement logic
    float noise_value = texture(noise_texture, uv).r;
    vec3 displacement = clamp(NORMAL * noise_value * displacement_strength, 0.9, 100.0);
    VERTEX += displacement;

    // Pass normal and world position
    world_normal = normalize(MODELVIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;
    world_position = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
    vec2 uv = UV;

    // Height-based color interpolation
    float height = texture(noise_texture, uv).r;
    height = clamp(height * displacement_strength, 0.0, 1.0);

    vec3 low_color = texture(low_color_texture, uv * 6.0).rgb;
    vec3 high_color = texture(high_color_texture, uv * 6.0).rgb;

    float biased_height = pow(height, 0.8);
    vec3 color = mix(low_color, high_color, biased_height);

    // Interpolated normal calculation
    vec3 low_normal = texture(low_normal_texture, uv * 6.0).rgb * 2.0 - 1.0;
    vec3 high_normal = texture(high_normal_texture, uv * 6.0).rgb * 2.0 - 1.0;
    vec3 interpolated_normal = normalize(mix(low_normal, high_normal, biased_height));

    NORMAL = normalize(world_normal + interpolated_normal);

    // Roughness interpolation
    float low_roughness = texture(low_roughness_texture, uv).r;
    float high_roughness = texture(high_roughness_texture, uv).r;
    float final_roughness = mix(low_roughness, high_roughness, biased_height);

    // Lighting calculations using light() function


    // Apply lighting
    ALBEDO = color;
    ROUGHNESS = final_roughness;
}
void light() {
    vec3 light_direction = normalize(LIGHT - world_position); // If LIGHT is position
    float diffuse_intensity = max(dot(NORMAL, light_direction), 0.0);  // Lambert's cosine law


    // Apply the light color and attenuation
    vec3 diffuse_light = diffuse_intensity * LIGHT_COLOR.rgb * ATTENUATION;

    // Combine diffuse light with the material's base color
    DIFFUSE_LIGHT = diffuse_light/10.0;
}
