extends Node2D

@onready var btnNew : Button    = $props/VBoxContainer/btnNew
@onready var canvas_layer_gui: CanvasLayer = $CanvasLayerGUI

@onready var load_game_scene : PackedScene = preload("uid://s7ge858a5toj")
@onready var new_game_scene : PackedScene = preload("uid://bgs554aupd1xs")

@onready var btn_sound : AudioStreamPlayer = $sounds/Button4
@onready var btn_mouseover : AudioStreamPlayer = $sounds/ButtonMouseover

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btnNew.grab_focus()

func _on_btn_new_pressed() -> void:
	btn_sound.play()
	await btn_sound.finished
	#open the load game scene
	var new_scene_instance = new_game_scene.instantiate()
	canvas_layer_gui.add_child(new_scene_instance)



func _on_btn_quit_pressed() -> void:
	btn_sound.play()
	await btn_sound.finished
	get_tree().quit()


func _on_btn_quit_focus_entered() -> void:
	btn_mouseover.play()


func _on_btn_new_focus_entered() -> void:
	btn_mouseover.play()


func _on_btn_continue_focus_entered() -> void:
	btn_mouseover.play()


func _on_btn_settings_focus_entered() -> void:
	btn_mouseover.play()


func _on_btn_credits_focus_entered() -> void:
	btn_mouseover.play()


func _on_btn_continue_pressed() -> void:
	btn_sound.play()
	await btn_sound.finished
	#open the load game scene
	var load_scene_instance = load_game_scene.instantiate()
	canvas_layer_gui.add_child(load_scene_instance)
	
	
