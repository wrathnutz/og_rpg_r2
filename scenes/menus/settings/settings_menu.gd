extends Control

@onready var game: Control = $PanelContainer/TabContainer/Game
@onready var sfx_button: AudioStreamPlayer = $Button4
@onready var sfx_mouseover: AudioStreamPlayer = $ButtonMouseover

@onready var input_button_scene = preload("uid://cs5rpp4ocx3a4")
@onready var action_list: VBoxContainer = $PanelContainer/TabContainer/Keyboard/ScrollContainer/ActionList

@onready var btn_cancel: Button = $PanelContainer/Panel/btnCancel
@onready var lb_version: Label = $PanelContainer/Panel/lbVersion

@onready var lbl_master: Label = $PanelContainer/TabContainer/Audio/lblMaster/lblMasterValue
@onready var lbl_music: Label = $PanelContainer/TabContainer/Audio/lblMusic/lblMusicValue
@onready var lbl_sfx: Label = $PanelContainer/TabContainer/Audio/lblSFX/lblSFXValue

@onready var slider_master: HSlider = $PanelContainer/TabContainer/Audio/lblMaster/Master_HSlider
@onready var slider_music: HSlider = $PanelContainer/TabContainer/Audio/lblMusic/Music_HSlider
@onready var slider_sfx: HSlider = $PanelContainer/TabContainer/Audio/lblSFX/SFX_HSlider

var is_remapping: bool = false
var action_to_remap
var remapping_button : Button

var input_actions : Dictionary = {
	"move_up" : " Move Up",
	"move_left" : " Move Left",
	"move_down" : " Move Right",
	"move_right" : " Move Right",
	"action_interact" : "Action",
	"action_cancel" : "Cancel",
	"menu" : "Menu / Pause"
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lb_version.text = "Version: " + str(GameState.version_major) + "." + str(GameState.version_minor) + "." + str(GameState.version_build)
	#initialize all of the audio settings
	slider_master.set_value(AudioManager.Get_Master_Volume())
	slider_music.set_value(AudioManager.Get_Music_Volume())
	slider_sfx.set_value(AudioManager.Get_SFX_Volume())
	btn_cancel.grab_focus()
	
	#initialize keyboard remapping
	_create_action_list()

func _input(event):
	if is_remapping:
		if (event is InputEventKey) and (!_event_in_use(event)) : 
			InputMap.action_erase_events(action_to_remap)
			InputMap.action_add_event(action_to_remap, event)
			_update_action_list(remapping_button, event)
			is_remapping = false
			action_to_remap = null
			remapping_button = null

func _event_in_use(event) -> bool:
	var retval = false
	
	# loop through all game keyboard inputs
	for key in input_actions.keys():
		# Make sure we aren't checking the original keyboard input that has this event mapped
		if key != action_to_remap:
			if InputMap.action_has_event(key, event):
				retval = true
	
	return retval

#rebuild the list of keyboard inputs
func _update_action_list(button, event) -> void:
	button.find_child("lblKey").text = event.as_text().trim_suffix(" (Physical)")


func _create_action_list() ->void:
	InputMap.load_from_project_settings()
	for item in action_list.get_children():
		item.queue_free()
	
	for action in input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("lblDescription")
		var input_label = button.find_child("lblKey")
		
		action_label.text = input_actions[action]
		var events = InputMap.action_get_events(action)
		if events.size() > 0:
			input_label.text = events[0].as_text().trim_suffix(" (Physical)")
		else:
			input_label.text = ""
		button.pressed.connect(_on_input_button_pressed.bind(button, action))
		action_list.add_child(button)

func _on_input_button_pressed(button, action):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		remapping_button = button
		button.find_child("lblKey").text = "Press key to bind..."


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
