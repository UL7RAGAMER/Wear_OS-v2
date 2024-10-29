shader_type canvas_item;

uniform int amount = 40;

void fragment()
{
    // Calculate grid UV using floor to reduce pattern artifacts
    vec2 grid_uv = floor(UV * float(amount)) / float(amount);
    
    // Sample the texture at the modified UV coordinates
    vec4 text = texture(TEXTURE, grid_uv);
    
    // Output the color
    COLOR = text;
}