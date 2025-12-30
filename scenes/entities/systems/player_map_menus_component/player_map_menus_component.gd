extends Node2D

@onready var menu_scene : PackedScene = preload("uid://dunhuxrgyvtne")
#@onready var inv_scene : PackedScene = preload()
@onready var gui_canvas : CanvasLayer = $CanvasLayer

signal menu_opened
signal menu_closed

var in_menu : bool = false

func allow_inputs(value : bool) -> void:
	in_menu = !value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu") and !in_menu:
		in_menu = true
		menu_opened.emit()
		SignalBus.player_move_toggle(false)
		var settings_menu_instance = menu_scene.instantiate()
		gui_canvas.add_child(settings_menu_instance)
		await settings_menu_instance.tree_exited
		in_menu = false
		menu_closed.emit()
		SignalBus.player_move_toggle(true)
		
	#if event.is_action("inventory") and !in_menu:
	#	in_menu = true
	#	menu_opened.emit()
	#	var inv_menu_instance = inv_scene.instantiate()
	#	gui_canvas.add_child(inv_menu_instance)
	#	await inv_menu_instance.menu_closed
	#	in_menu = false
	#	menu_closed.emit()
