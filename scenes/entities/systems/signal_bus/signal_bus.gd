extends Node

signal toggle_player_move
signal player_enter_menu
signal player_exit_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func player_move_toggle(toggle: bool) -> void:
	emit_signal("toggle_player_move", toggle)

func player_entered_menu() -> void:
	emit_signal("player_enter_menu")

func player_exited_menu() -> void:
	emit_signal("player_exit_menu")
