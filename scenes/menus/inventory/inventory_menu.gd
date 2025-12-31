extends Control

@onready var btn_close: Button = $PanelContainer/Panel2/btnClose

@onready var sfx_mouseover: AudioStreamPlayer = $Button4
@onready var sfx_button: AudioStreamPlayer = $ButtonMouseover

#stats page
@onready var lbl_name: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelInfo/lblName
@onready var rt_lbl_title: RichTextLabel = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelInfo/RTLblTitle
@onready var lbl_class: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelInfo/lblClass
@onready var lbl_level: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/lblLevel
@onready var lbl_experience: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/lblExperience

@onready var lbl_str_value: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/GridContainer/lblStrValue
@onready var lbl_dex_value: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/GridContainer/lblDexValue
@onready var lbl_con_value: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/GridContainer/lblConValue
@onready var lbl_int_value: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/GridContainer/lblIntValue
@onready var lbl_wis_value: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/GridContainer/lblWisValue
@onready var lbl_char_value: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/GridContainer/lblCharValue



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btn_close.grab_focus()
	
	#setup the player stats page
	lbl_name.text = GameState.player_name
	rt_lbl_title.text = GameState.unlocked_titles.get(GameState.player_title)
	lbl_class.text = GameState.player_class
	lbl_level.text = "Level: " + str(GameState.player_level)
	lbl_experience.text = "Experience: " + str(GameState.player_xp)
	
	lbl_str_value.text = str(GameState.strength + GameState.strength_modifier + GameState.strength_gear_modifier)
	lbl_dex_value.text = str(GameState.dexterity + GameState.dexterity_modifier + GameState.dexterity_gear_modifier)
	lbl_con_value.text = str(GameState.constitution + GameState.constitution_modifier + GameState.constitution_gear_modifier)
	lbl_int_value.text = str(GameState.intelligence + GameState.intelligence_modifier + GameState.intelligence_gear_modifier)
	lbl_wis_value.text = str(GameState.wisdom + GameState.wisdom_modifier + GameState.wisdom_gear_modifier)
	lbl_char_value.text = str(GameState.charisma + GameState.charisma_modifier + GameState.charisma_gear_modifier)


func _on_btn_close_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	self.queue_free()


func _on_btn_close_focus_entered() -> void:
	sfx_mouseover.play()
