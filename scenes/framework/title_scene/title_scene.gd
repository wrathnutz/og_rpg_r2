extends Node2D

@onready var btnNew : Button    = $props/VBoxContainer/btnNew
@onready var btn_sound : AudioStreamPlayer = $sounds/Button4
@onready var btn_mouseover : AudioStreamPlayer = $sounds/ButtonMouseover
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btnNew.grab_focus()

func _on_btn_new_pressed() -> void:
	btn_sound.play()
	await btn_sound.finished
	scene_manager.change_scene_fade("res://scenes/cutscenes/intro_cutscene/intro_custscene.tscn")


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
