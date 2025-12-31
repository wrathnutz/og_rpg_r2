extends Control

@onready var btn_close: Button = $PanelContainer/Panel2/btnClose

@onready var sfx_mouseover: AudioStreamPlayer = $Button4
@onready var sfx_button: AudioStreamPlayer = $ButtonMouseover




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btn_close.grab_focus()


func _on_btn_close_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	self.queue_free()


func _on_btn_close_focus_entered() -> void:
	sfx_mouseover.play()
