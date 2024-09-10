shader_type spatial;
uniform sampler2D noise_texture;          // Texture for displacement mapping

void vertex() {
    // Get the UV coordinates of the current vertex
    vec2 uv = UV * 1.0;

    // Sample the noise texture using the UV coordinates
    float noise_value = texture(noise_texture, uv).r;

    // Calculate the displacement vector
    vec3 displacement = clamp(NORMAL * noise_value * 2.0, 0.9, 100.0);

    // Apply the displacement to the vertex position
    VERTEX += displacement;

    // Pass the original normal to the fragment shader, transformed to world space
    world_normal = normalize(MODELVIEW_NORMAL_MATRIX * NORMAL);
}