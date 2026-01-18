extends Node2D

@onready var interactable: Area2D = $Torch/Interactable

var pickup_dialogue = preload("uid://cgeso25kbdfyk")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = pickup

func pickup() -> void:
	DialogueManager.show_example_dialogue_balloon(pickup_dialogue)
	await DialogueManager.dialogue_ended
	_try_add()
	self.queue_free()

func _try_add() ->void:
	if GameState.player_lights.has("torch") == false:
		#Player doesnt have torch, lets add it
		GameState.player_lights.append("torch")
		GameState.current_light = GameState.player_lights.find("torch")
		#Try to turn on the torch
		SignalBus.activate_light()
