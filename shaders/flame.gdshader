shader_type canvas_item;

uniform vec4 inner_color = vec4(1.0, 1.0, 0.0, 1.0); // Yellow
uniform vec4 outer_color = vec4(1.0, 0.0, 0.0, 0.0); // Red with 0 alpha

uniform float radius = 1.0;

void fragment() {
    vec2 uv = (UV - vec2(0.5)) * 2.0; // Center UV
    float dist = length(uv);
    float t = clamp(dist / radius, 0.0, 1.0);
    COLOR = mix(inner_color, outer_color, t);
}
