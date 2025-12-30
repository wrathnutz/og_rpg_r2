extends Node2D

var dlg_first = preload("res://scenes/cutscenes/intro_cutscene/intro_dialogue_1.dialogue")
var dlg_second = preload("res://scenes/cutscenes/intro_cutscene/intro_dialogue_2.dialogue")

@onready var sfx_splash : AudioStreamPlayer = $SfxWaterSplash
@onready var sfx_bubbling : AudioStreamPlayer = $AncientGameUnderwaterLoop
@onready var sfx_hit : AudioStreamPlayer = $AncientGameGearBagThrowDown7
@onready var sfx_ping : AudioStreamPlayer = $AncientGameFantasyStarKeyLight

@onready var god_ray : ColorRect = $GodRay

@onready var splash : GPUParticles2D = $splash_particles

@onready var player_sprite : AnimatedSprite2D = $player_birth_sprite
@onready var fountain : AnimatedSprite2D = $props/fountain

@onready var ray_timer : Timer = $ray_start_timer
@onready var dialogue_timer : Timer = $dialogue_start_timer
@onready var game_camera: Camera2D = $GameCamera



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#DialogueManager.show_example_dialogue_balloon(dlg_resource)
	pass

func _on_scene_start_timer_timeout() -> void:
	god_ray.visible = true
	sfx_ping.play()
	await sfx_ping.finished
	ray_timer.start()
	

func _on_ray_start_timer_timeout() -> void:
	fountain.play("bubbling")
	sfx_bubbling.play()
	dialogue_timer.start()
	

func _on_dialogue_start_timer_timeout() -> void:
	DialogueManager.show_example_dialogue_balloon(dlg_first)

func wake_player() -> void:
	game_camera.add_trauma(0.5)
	player_sprite.visible = true
	player_sprite.play("spinning")
	splash.emitting = true
	sfx_splash.play()
	
	var tween = get_tree().create_tween()
	tween.tween_property($player_birth_sprite, "global_position", Vector2(0, 10), 1.25).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(birth_player)

func birth_player() -> void:
	player_sprite.play("awaken")
	await player_sprite.animation_finished
	
	var tween = get_tree().create_tween()
	tween.tween_property($player_birth_sprite, "global_position", Vector2(0, 175), 0.5)
	tween.tween_callback(final_dioalogue)

func final_dioalogue() -> void:
	player_sprite.play("idle")
	sfx_hit.play()
	var balloon = DialogueManager.show_example_dialogue_balloon(dlg_second)
	await DialogueManager.dialogue_ended
	end_scene()
	
func end_scene() -> void:
	scene_manager.change_scene_fade("res://scenes/maps/dungeons/intro_temple/intro_dungeon.tscn")
	pass
