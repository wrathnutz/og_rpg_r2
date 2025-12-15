shader_type canvas_item;

uniform float progress: hint_range(0.0,1.0);

void fragment() {
	COLOR.a = progress;// Uncomment to replace the default light processing function with this one.
	}
