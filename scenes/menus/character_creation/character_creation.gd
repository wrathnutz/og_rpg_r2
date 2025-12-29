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
