extends Node

signal toggle_player_move

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func player_move_toggle(toggle: bool) -> void:
	emit_signal("toggle_player_move", toggle)
