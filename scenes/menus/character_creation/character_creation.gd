extends CanvasLayer

signal creation_complete

var Strength : int = 12
var Dexterity : int = 12
var Constitution : int = 12
var Intelligence : int = 12
var Wisdom : int = 12
var Charisma : int = 12

var Strength_Mod : int = 0
var Dexterity_Mod : int = 0
var Constitution_Mod : int = 0
var Intelligence_Mod : int = 0
var Wisdom_Mod : int = 0
var Charisma_Mod : int = 0

@onready var str_text: Label = $Menu/MarginContainer/PanelContainer/Panel_Stats/GridContainer/lblStrValue
@onready var dex_text: Label = $Menu/MarginContainer/PanelContainer/Panel_Stats/GridContainer/lblDexValue
@onready var con_text: Label = $Menu/MarginContainer/PanelContainer/Panel_Stats/GridContainer/lblConValue
@onready var int_text: Label = $Menu/MarginContainer/PanelContainer/Panel_Stats/GridContainer/lblIntValue
@onready var wis_text: Label = $Menu/MarginContainer/PanelContainer/Panel_Stats/GridContainer/lblWisValue
@onready var char_text: Label = $Menu/MarginContainer/PanelContainer/Panel_Stats/GridContainer/lblCharValue

@onready var str_text_mod: Label = $Menu/MarginContainer/PanelContainer/Panel_Stats/GridContainer/lblStrMod
@onready var dex_text_mod: Label = $Menu/MarginContainer/PanelContainer/Panel_Stats/GridContainer/lblDexMod
@onready var con_text_mod: Label = $Menu/MarginContainer/PanelContainer/Panel_Stats/GridContainer/lblConMod
@onready var int_text_mod: Label = $Menu/MarginContainer/PanelContainer/Panel_Stats/GridContainer/lblIntMod
@onready var wis_text_mod: Label = $Menu/MarginContainer/PanelContainer/Panel_Stats/GridContainer/lblWisMod
@onready var char_text_mod: Label = $Menu/MarginContainer/PanelContainer/Panel_Stats/GridContainer/lblCharMod

@onready var class_choice: OptionButton = $Menu/MarginContainer/PanelContainer/Panel_Header/OptionButton
@onready var name_choice: LineEdit = $Menu/MarginContainer/PanelContainer/Panel_Header/LineEdit

@onready var sfx_dice: AudioStreamPlayer = $AncientGameMetalBoltOrScrewDrop1
@onready var sfx_button: AudioStreamPlayer = $Button4

var player_class : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	name_choice.grab_focus()
	player_class = class_choice.get_item_text(class_choice.get_selected())
	_roll_all_stats()
	_update_mods()
	_update_screen()

func _input_valid()->bool:
	var retval : bool = true
	var errMsg : String = ""
	if name_choice.text == "":
		retval = false
		errMsg += "The Player Name cannot be left blank \n"
		
	if !retval:
		var dialog = ConfirmationDialog.new()
		dialog.title = "Input Error"
		dialog.dialog_text = errMsg
		add_child(dialog)
		dialog.popup_centered()
		dialog.show()
	return retval

func _roll_stat() -> int:
	
	var d1 : int = GameState.rng.randi_range(1, 6)
	var d2 : int = GameState.rng.randi_range(1, 6)
	var d3 : int = GameState.rng.randi_range(1, 6)
	
	return d1 + d2 + d3

func _roll_all_stats() -> void:
	Strength = _roll_stat()
	Dexterity = _roll_stat()
	Constitution = _roll_stat()
	Intelligence = _roll_stat()
	Wisdom = _roll_stat()
	Charisma = _roll_stat()

func _update_mods() -> void:
	_zero_mods()
	match class_choice.get_item_text(class_choice.get_selected()):
		"Warrior":
			Strength_Mod = 2
			Constitution_Mod = 1
			Intelligence_Mod = -2
			Wisdom_Mod = -1
		"Wizard":
			Intelligence_Mod = 2
			Wisdom_Mod = 1
			Strength_Mod = -2
			Constitution_Mod = -1
		"Thief":
			Dexterity_Mod = 2
			Charisma_Mod = 1
			Constitution_Mod = -2
			Strength_Mod = -1
		"Ranger":
			Dexterity_Mod = 1
			Constitution_Mod = 1
			Wisdom_Mod = 1
			Strength_Mod = -1
			Intelligence_Mod = -1
			Charisma_Mod = -1

func _zero_mods()->void:
	Strength_Mod = 0
	Dexterity_Mod = 0
	Constitution_Mod = 0
	Intelligence_Mod = 0
	Wisdom_Mod = 0
	Charisma_Mod = 0

func _update_screen() -> void:
	#update base stats
	str_text.text = str(Strength)
	dex_text.text = str(Dexterity)
	con_text.text = str(Constitution)
	int_text.text = str(Intelligence)
	wis_text.text = str(Wisdom)
	char_text.text = str(Charisma)
	
	#update mods	
	str_text_mod.text = _get_prefix(Strength_Mod)
	dex_text_mod.text = _get_prefix(Dexterity_Mod)
	con_text_mod.text = _get_prefix(Constitution_Mod)
	int_text_mod.text = _get_prefix(Intelligence_Mod)
	wis_text_mod.text = _get_prefix(Wisdom_Mod)
	char_text_mod.text = _get_prefix(Charisma_Mod)

func _get_prefix(value: int)->String:
	if value >= 0:
		return "+" + str(value)
	return str(value)

func _save_player_data() -> void:
	#Update the gamestate with the players choices
	GameState.player_name = name_choice.text
	GameState.player_class = class_choice.get_item_text(class_choice.get_selected())
	GameState.strength = Strength
	GameState.strength_modifier = Strength_Mod
	GameState.dexterity = Dexterity
	GameState.dexterity_modifier = Dexterity_Mod
	GameState.constitution = Constitution
	GameState.constitution_modifier = Constitution_Mod
	GameState.intelligence = Intelligence
	GameState.intelligence_modifier = Intelligence_Mod
	GameState.wisdom = Wisdom
	GameState.wisdom_modifier = Wisdom_Mod
	GameState.charisma = Charisma
	GameState.charisma_modifier = Charisma_Mod

func _on_btn_reroll_pressed() -> void:
	sfx_dice.play()
	_roll_all_stats()
	_update_screen()


func _on_btn_save_pressed() -> void:
	sfx_button.play()
	if _input_valid():
		_save_player_data()
		creation_complete.emit()
		queue_free()

func _on_option_button_item_selected(_index: int) -> void:
	sfx_button.play()
	_update_mods()
	_update_screen()
