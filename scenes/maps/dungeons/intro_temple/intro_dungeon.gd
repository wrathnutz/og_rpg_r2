extends Node2D

var creation_menu : PackedScene = preload("uid://cglvoh5mvwsml")
var pool_dialogue = preload("res://scenes/maps/dungeons/intro_temple/pool_start_dialogue.dialogue")
var door_dialogue = preload("res://scenes/maps/dungeons/intro_temple/pool_end_dialogue.dialogue")

@onready var camera_2d: Camera2D = $Camera2D
@onready var reflection_pool_trigger: Area2D = $ReflectionPoolTrigger
@onready var magic_door: Sprite2D = $MagicDoor
@onready var sfx_boom: AudioStreamPlayer = $AncientGameWoodenCrateImpact2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reflection_pool_trigger.interact = start_player_creation

func start_player_creation() -> void:
	reflection_pool_trigger.is_interactable = false
	
	DialogueManager.show_example_dialogue_balloon(pool_dialogue)
	await DialogueManager.dialogue_ended
	
	var creation_menu_instance = creation_menu.instantiate()
	get_tree().get_root().add_child(creation_menu_instance)
	
	await creation_menu_instance.creation_complete
	end_player_creation()

func end_player_creation() -> void:
	DialogueManager.show_example_dialogue_balloon(pool_dialogue)
	await DialogueManager.dialogue_ended
	sfx_boom.play()
	camera_2d.add_trauma(0.5)
	magic_door.current_state = GameUtilities.door_state.CLOSED
