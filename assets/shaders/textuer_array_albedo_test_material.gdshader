shader_type spatial;
render_mode depth_draw_opaque,diffuse_burley,specular_schlick_ggx;
uniform sampler2DArray albedoTex : hint_albedo;
varying float index_value;

void vertex(){
	index_value = CUSTOM0.x;
}

void fragment() {
	ALBEDO = texture(albedoTex, vec3(UV.x, UV.y, index_value)).xyz;
}