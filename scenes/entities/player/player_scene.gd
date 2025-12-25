class_name player extends Node2D

@onready var physics_body : CharacterBody2D = $CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func allow_movement_inputs(allow : bool) -> void:
	physics_body.movement_toggle(allow)
