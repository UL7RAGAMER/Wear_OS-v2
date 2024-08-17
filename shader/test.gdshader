shader_type canvas_item;
uniform bool toon = true;
void light(){
    vec3 lightDir = normalize(LIGHT_DIRECTION);
    vec3 normal = normalize(NORMAL);
    vec4 specMap = SPECULAR_SHININESS; // Adjust based on your specular map or use a uniform
    vec4 lightColor = LIGHT_COLOR; // Light color
    float specIntensity = 0.0; // Specular intensity
    float diffIntensity = LIGHT_ENERGY; // Diffuse intensity

    float nl = dot(lightDir, normal);
    float diff = max(nl, 0.0);

    if (toon) {
        diff = smoothstep(0.495, 0.505, diff);
    }

    vec4 diffuse = diff * lightColor * diffIntensity;

    float spec = pow(max(dot(reflect(-lightDir, normal), -normalize(FRAGCOORD.xyz)), 0.0), 32.0);

    if (toon) {
        spec = smoothstep(0.005, 0.01, spec);
    }

    vec4 specular = lightColor * spec * specIntensity * specMap;

   vec4 l_color = diffuse + specular;
    LIGHT = vec4(l_color);

}
void fragment() {


}
