extends Node2D

@onready var interactable: Area2D = $Torch/Interactable

var pickup_dialogue = preload("uid://cgeso25kbdfyk")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = pickup

func pickup() -> void:
	DialogueManager.show_example_dialogue_balloon(pickup_dialogue)
	await DialogueManager.dialogue_ended
	
	self.queue_free()
