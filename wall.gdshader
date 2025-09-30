shader_type spatial;
uniform float time;
void vertex() {
	VERTEX.y+=sin(TIME*2.0+VERTEX.x*10.0);
}

void fragment() {
	ALBEDO=vec3(0.3,3,0);
	EMISSION=vec3(0,0,0);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
