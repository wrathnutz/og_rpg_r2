extends Control

@onready var game: Control = $PanelContainer/TabContainer/Game
@onready var sfx_button: AudioStreamPlayer = $Button4
@onready var sfx_mouseover: AudioStreamPlayer = $ButtonMouseover

@onready var btn_cancel: Button = $PanelContainer/Panel/btnCancel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btn_cancel.grab_focus()


func _on_btn_quit_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	get_tree().quit()


func _on_btn_main_menu_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	SignalBus.player_exited_menu()
	scene_manager.change_scene_fade("res://scenes/framework/title_scene/title_scene.tscn")


func _on_btn_load_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	SignalBus.player_exited_menu()

func _on_btn_load_focus_entered() -> void:
	sfx_mouseover.play()

func _on_btn_main_menu_focus_entered() -> void:
	sfx_mouseover.play()

func _on_btn_quit_focus_entered() -> void:
	sfx_mouseover.play()

func _on_btn_save_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	SignalBus.player_exited_menu()
	self.queue_free()

func _on_btn_save_focus_entered() -> void:
	sfx_mouseover.play()

func _on_btn_cancel_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	SignalBus.player_exited_menu()
	self.queue_free()

func _on_btn_cancel_focus_entered() -> void:
	sfx_mouseover.play()
