extends Node2D

@onready var text = $RichTextLabel

@onready var timer: Timer = $ChangeTimer
@onready var hit_sound : AudioStreamPlayer = $Hit173
@onready var ambient_sound : AudioStreamPlayer = $AtmosphereLoop8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ambient_sound.play()
	hit_sound.play()
	timer.start()
	start_dissolve()

func start_dissolve()->void:
	var dissolve_tween = get_tree().create_tween()
	dissolve_tween.tween_method(set_dissolve, 1.0, 0.0, 8)

func set_dissolve(amount: float):
	text.material.set_shader_parameter("percentage", amount)

func _on_change_timer_timeout() -> void:
	scene_manager.change_scene_fade("res://scenes/framework/title_scene/title_scene.tscn")
