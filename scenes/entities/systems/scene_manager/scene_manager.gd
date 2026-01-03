class_name SceneManager extends CanvasLayer

@onready var fade_rect : ColorRect = $FadeRect
@onready var timer : Timer = $TransitionTimer

func change_scene_fade(scene_path : String, spawn : String = "") -> void:
	
	var fadeout_tween = get_tree().create_tween()
	fadeout_tween.tween_method(set_fade, 0.0, 1.0, 1.0 )
	timer.start(1.0)
	
	await timer.timeout
	
	get_tree().call_deferred("change_scene_to_file", scene_path)
	
	var fadein_tween = get_tree().create_tween()
	fadein_tween.tween_method(set_fade, 1.0, 0.0, 1.0 )
	GameState.current_scene = scene_path
	GameState.spawn_location = spawn
	
func change_scene_clean(scene_path: String) -> void:
	get_tree().call_deferred("change_scene_to_file", scene_path)

func set_fade(amount: float) -> void:
	fade_rect.material.set_shader_parameter("progress", amount)
	
