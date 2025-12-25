extends Node2D

@onready var light = $PointLight2D
@export var noise: NoiseTexture2D
var  time_passed: float = 0
var random_seed: float = 0
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#random_seed = rng.randf_range(0.0, 1.0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta
	
	#var sampled_noise: float = noise.noise.get_noise_1d(time_passed + random_seed)
	var sampled_noise: float = noise.noise.get_noise_1d(time_passed)
	sampled_noise = abs(sampled_noise)
	light.energy = sampled_noise + 0.75
