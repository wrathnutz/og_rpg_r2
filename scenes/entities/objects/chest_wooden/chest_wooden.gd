extends Node2D



var current_state : GameUtilities.chest_state = GameUtilities.chest_state.CLOSED
@export var is_locked : bool = false
@onready var interactable: Area2D = $Interactable
@onready var chest_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_opening: AudioStreamPlayer = $AncientGameWoodenDoorOpen2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = try_open

func try_open() -> void:
	interactable.is_interactable = false
	
	chest_sprite.play("opening")
	sfx_opening.play()
	await chest_sprite.animation_finished
	chest_sprite.play("opened")
	var dlg_resource = DialogueManager.create_resource_from_text("This chest is empty.")
	DialogueManager.show_example_dialogue_balloon(dlg_resource)
	
