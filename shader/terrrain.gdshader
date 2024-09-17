shader_type spatial;

uniform float height_scale = 0.5;
uniform sampler2D noise;
uniform sampler2D normalmap;
uniform sampler2D low_color_texture;
uniform sampler2D high_color_texture;

uniform sampler2D low_normal_texture;
uniform sampler2D high_normal_texture;

varying vec2 tex_position;
varying vec3 v;

void vertex() {
    // Generate UV coordinates from the vertex xz position
    tex_position = VERTEX.xz / 2.0 + 0.5;

    // Sample the noise texture to get a height value
    float height = texture(noise, tex_position).x;

    // Scale and clamp the height
    height = clamp(pow(height * height_scale, 1.5), 0.03, 1.0);

    // Add the height to the y-coordinate of the vertex
    VERTEX.y += height;

    // Store the vertex position for use in the fragment shader
    v = VERTEX;
}

void fragment() {
    // Sample the normal map
    NORMAL_MAP = texture(normalmap, tex_position).xyz;

    // Sample the low and high color textures
    vec3 low_color = texture(low_color_texture, UV).rgb;
    vec3 high_color = texture(high_color_texture, UV).rgb;

    // Smooth transition factor based on vertex height
    // Normalize the y-coordinate for blending (you can adjust the range)
    float blend_factor = smoothstep(0.0, 0.17, v.y);

    // Blend between low_color and high_color based on the blend_factor
    vec3 color = mix(low_color, high_color, blend_factor);

    // Output the final blended color
    ALBEDO = color;
}
