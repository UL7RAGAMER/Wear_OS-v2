shader_type spatial;

uniform sampler2D noise_texture; // Texture for displacement mapping
uniform sampler2D normal_map;    // Normal map texture
uniform sampler2D low_color_texture;  // Texture for low height colors
uniform sampler2D high_color_texture; // Texture for high height colors

uniform float displacement_strength = 1.0;

void vertex() {
    // Get the UV coordinates of the current vertex
    vec2 uv = UV;

    // Sample the noise texture using the UV coordinates
    float noise_value = texture(noise_texture, uv).r;

    // Calculate the displacement vector
    vec3 displacement = NORMAL * noise_value * displacement_strength;

    // Apply the displacement to the vertex position
    VERTEX += displacement;

    // Sample the normal map using UV coordinates
    vec3 normal_map_value = texture(normal_map, uv).rgb;

    // Transform the normal from the normal map from the [0, 1] range to the [-1, 1] range
    normal_map_value = normal_map_value * 2.0 - 1.0;

    // Adjust the vertex normal using the normal map
    NORMAL = normalize(NORMAL + normal_map_value);
}

void fragment() {
    // Get the UV coordinates of the current fragment
    vec2 uv = UV;

    // Sample the noise texture to get the height value
    float height = texture(noise_texture, uv).r;

    // Normalize the height value to ensure it's between 0 and 1
    height = clamp(height * displacement_strength, 0.0, 1.0);

    // Sample the low and high color textures
    vec3 low_color = texture(low_color_texture, uv).rgb;
    vec3 high_color = texture(high_color_texture, uv).rgb;

    // Interpolate between the low and high colors based on height
    vec3 color = mix(low_color, high_color, height);

    // Set the fragment color
    ALBEDO = color;
}
