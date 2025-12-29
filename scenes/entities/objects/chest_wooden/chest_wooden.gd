extends Node2D

enum chest_state{OPENED=0, CLOSED=1, OPENING=3}

var current_state : chest_state = chest_state.CLOSED
@export var is_locked : bool = false
@onready var interactable: Area2D = $Interactable
@onready var chest_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_opening: AudioStreamPlayer = $AncientGameWoodenDoorOpen2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = try_open

func try_open() -> void:
	chest_sprite.play("opening")
	sfx_opening.play()
	await chest_sprite.animation_finished
	chest_sprite.play("opened")
	var dlg_resource = DialogueManager.create_resource_from_text("This chest is empty.")
	DialogueManager.show_example_dialogue_balloon(dlg_resource)
	pass
