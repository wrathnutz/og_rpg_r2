extends Control

@onready var game: Control = $PanelContainer/TabContainer/Game
@onready var sfx_button: AudioStreamPlayer = $Button4
@onready var sfx_mouseover: AudioStreamPlayer = $ButtonMouseover

@onready var btn_cancel: Button = $PanelContainer/Panel/btnCancel
@onready var lb_version: Label = $PanelContainer/Panel/lbVersion

@onready var lbl_master: Label = $PanelContainer/TabContainer/Audio/lblMaster/lblMasterValue
@onready var lbl_music: Label = $PanelContainer/TabContainer/Audio/lblMusic/lblMusicValue
@onready var lbl_sfx: Label = $PanelContainer/TabContainer/Audio/lblSFX/lblSFXValue

@onready var slider_master: HSlider = $PanelContainer/TabContainer/Audio/lblMaster/Master_HSlider
@onready var slider_music: HSlider = $PanelContainer/TabContainer/Audio/lblMusic/Music_HSlider
@onready var slider_sfx: HSlider = $PanelContainer/TabContainer/Audio/lblSFX/SFX_HSlider



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lb_version.text = "Version: " + str(GameState.version_major) + "." + str(GameState.version_minor) + "." + str(GameState.version_build)
	#initialize all of the audio settings
	slider_master.set_value(AudioManager.Get_Master_Volume())
	slider_music.set_value(AudioManager.Get_Music_Volume())
	slider_sfx.set_value(AudioManager.Get_SFX_Volume())
	btn_cancel.grab_focus()
	

func _on_btn_quit_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	get_tree().quit()


func _on_btn_main_menu_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	SignalBus.player_exited_menu()
	#Change to the title scene
	scene_manager.change_scene_fade("uid://f8evf6ueyum2")


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
	
	#save all of the audio changes
	AudioManager.Set_Music_Volume(float(lbl_music.text)/100.0)
	AudioManager.Set_SFX_Volume(float(lbl_sfx.text)/100.0)
	AudioManager.Set_Master_Volume(float(lbl_master.text)/100.0)
	
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


func _on_master_h_slider_value_changed(value: float) -> void:
	lbl_master.text = str(value * 100.0)

func _on_music_h_slider_value_changed(value: float) -> void:
	lbl_music.text = str(value * 100.0)

func _on_sfx_h_slider_value_changed(value: float) -> void:
	lbl_sfx.text = str(value * 100.0)
