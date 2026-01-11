extends Control

#Get buttons
@onready var btn_slot1: Button = $PanelContainer/VBoxContainer/PanelSlots/VBoxContainer/HBoxContainer_Slot1/btnSlot1
@onready var btn_slot2: Button = $PanelContainer/VBoxContainer/PanelSlots/VBoxContainer/HBoxContainer_Slot2/btnSlot2
@onready var btn_slot3: Button = $PanelContainer/VBoxContainer/PanelSlots/VBoxContainer/HBoxContainer_Slot3/btnSlot3

#Get info slots
@onready var lbl_slot1: RichTextLabel = $PanelContainer/VBoxContainer/PanelSlots/VBoxContainer/HBoxContainer_Slot1/lblSlot1
@onready var lbl_slot2: RichTextLabel = $PanelContainer/VBoxContainer/PanelSlots/VBoxContainer/HBoxContainer_Slot2/lblSlot2
@onready var lbl_slot3: RichTextLabel = $PanelContainer/VBoxContainer/PanelSlots/VBoxContainer/HBoxContainer_Slot3/lblSlot3

@onready var sfx_mouseover: AudioStreamPlayer = $Button4
@onready var sfx_button: AudioStreamPlayer = $ButtonMouseover

var slot_has_data : Array[bool] = [false, false, false]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btn_slot1.grab_focus()
	_updateSlotInfo()

func _updateSlotInfo() -> void:
	
	var strInfo : String = ""
	var strEffectPrefix : String = "[fade start=0 length=100]"
	var strEffectPostfix : String = "[/fade]"
	
	#Slot 1 Info
	SaveManager.save_slot = 1
	strInfo = _getSlotInfo()
	lbl_slot1.text = strEffectPrefix + strInfo + strEffectPostfix
	
	#Slot2 Info
	SaveManager.save_slot = 2
	strInfo = _getSlotInfo()
	lbl_slot2.text = strEffectPrefix + strInfo + strEffectPostfix
	
	#Slot3 Info
	SaveManager.save_slot = 3
	strInfo = _getSlotInfo()
	lbl_slot3.text = strEffectPrefix + strInfo + strEffectPostfix
	
func _getSlotInfo() -> String : 
	var retval : String = ""
	var s_info : Dictionary = SaveManager.load_game_file()
	s_info = SaveManager.load_game_file()
	if s_info.has("player_name"):
		retval = "Name: " + s_info["player_name"] + "\n"
		retval = retval + "Level: " + str(int(s_info["player_level"])) + "\n"
		retval = retval + "Last Saved: " + s_info["save_date"] + "\n"
		slot_has_data[SaveManager.save_slot-1] = true
	else:
		retval = "Empty"
		slot_has_data[SaveManager.save_slot-1] = false
	return retval


func _on_btn_back_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	self.queue_free()

func _on_btn_back_focus_entered() -> void:
	sfx_mouseover.play()


func _on_btn_slot_1_pressed() -> void:
	
	sfx_button.play()
	await sfx_button.finished
	
	if slot_has_data[0]:
		SaveManager.save_slot = 1
		SaveManager.load_game()
	else:
		_popup_empty("Slot 1 has no game to load.")


func _on_btn_slot_1_focus_entered() -> void:
	sfx_mouseover.play()


func _on_btn_slot_2_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	
	if slot_has_data[1]:
		SaveManager.save_slot = 2
		SaveManager.load_game()
	else:
		_popup_empty("Slot 2 has no game to load.")


func _on_btn_slot_2_focus_entered() -> void:
	sfx_mouseover.play()


func _on_btn_slot_3_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	
	if slot_has_data[2]:
		SaveManager.save_slot = 3
		SaveManager.load_game()
	else:
		_popup_empty("Slot 3 has no game to load.")

func _on_btn_slot_3_focus_entered() -> void:
	sfx_mouseover.play()
	
func _popup_empty(msg : String) -> void:
	var popup : AcceptDialog = AcceptDialog.new()
	popup.dialog_text = msg
	popup.title = "Error"
	popup.size = Vector2i(200,100)
	add_child(popup)
	popup.popup_centered()
	popup.connect("confirmed", popup.queue_free)
	
