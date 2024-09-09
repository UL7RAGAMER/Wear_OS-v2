shader_type spatial;

uniform sampler2D noise_texture;          // Texture for displacement mapping
uniform sampler2D normal_map;             // Normal map texture
uniform sampler2D low_color_texture;      // Texture for low height colors
uniform sampler2D high_color_texture;     // Texture for high height colors

uniform sampler2D low_normal_texture;     // Normal map for low height texture
uniform sampler2D high_normal_texture;    // Normal map for high height texture

uniform sampler2D low_roughness_texture;  // Roughness map for low height texture
uniform sampler2D high_roughness_texture; // Roughness map for high height texture

uniform float displacement_strength = 1.0;

varying vec3 world_normal; // Pass normal from vertex to fragment shader

void vertex() {
    // Get the UV coordinates of the current vertex
    vec2 uv = UV * 1.0;

    // Sample the noise texture using the UV coordinates
    float noise_value = texture(noise_texture, uv).r;

    // Calculate the displacement vector
    vec3 displacement = clamp(NORMAL * noise_value * displacement_strength, 0.9, 100.0);

    // Apply the displacement to the vertex position
    VERTEX += displacement;

    // Pass the original normal to the fragment shader, transformed to world space
    world_normal = normalize(MODELVIEW_NORMAL_MATRIX * NORMAL);
}

void fragment() {
    // Get the UV coordinates of the current fragment
    vec2 uv = UV * 1.0;
	
    // Sample the noise texture to get the height value
    float height = texture(noise_texture, uv).r;

    // Normalize the height value to ensure it's between 0 and 1
    height = clamp(height * displacement_strength, 0.0, 1.0);

    // Sample the low and high color textures
    vec3 low_color = texture(low_color_texture, uv* 2.0).rgb;
    vec3 high_color = texture(high_color_texture, uv* 5.0).rgb;

    // Interpolate between the low and high colors based on height
    vec3 color = mix(low_color, high_color, height);

    // Sample the low and high normal textures
    vec3 low_normal = texture(low_normal_texture, uv).rgb;
    vec3 high_normal = texture(high_normal_texture, uv).rgb;

    // Transform normals from [0, 1] range to [-1, 1] range
    low_normal = low_normal * 2.0 - 1.0;
    high_normal = high_normal * 2.0 - 1.0;

    // Interpolate between the low and high normals based on height
    vec3 interpolated_normal = normalize(mix(low_normal, high_normal, height));
    
    // Final normal is the combination of the world space normal and the interpolated normal
    NORMAL = normalize(world_normal + interpolated_normal);

    // Sample the low and high roughness textures
    float low_roughness = texture(low_roughness_texture, uv).r;
    float high_roughness = texture(high_roughness_texture, uv).r;

    // Interpolate between the low and high roughness values based on height
    float final_roughness = mix(low_roughness, high_roughness, height);

    // Set the fragment color and roughness
    ALBEDO = color;
    ROUGHNESS = final_roughness;
}
