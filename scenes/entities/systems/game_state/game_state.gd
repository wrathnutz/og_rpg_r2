extends Node

@export_category("Player") 
@export var player_name : String = ""
@export var player_title : String = "none"
@export var player_class : String = ""
@export var player_level : int = 1
@export var player_xp : int = 0
@export var player_hp : int = 10
@export var player_mp : int = 0
@export_group("Stats")
@export_subgroup("Strength")
@export var strength : int = 12
@export var strength_modifier : int = 0
@export var strength_gear_modifier : int = 0
@export_subgroup("Dexterity")
@export var dexterity : int = 12
@export var dexterity_modifier : int = 0
@export var dexterity_gear_modifier : int = 0
@export_subgroup("Constitution")
@export var constitution : int = 12
@export var constitution_modifier : int = 0
@export var constitution_gear_modifier : int = 0
@export_subgroup("Intelligence")
@export var intelligence : int = 12
@export var intelligence_modifier : int = 0
@export var intelligence_gear_modifier : int = 0
@export_subgroup("Wisdom")
@export var wisdom : int = 12
@export var wisdom_modifier : int = 0
@export var wisdom_gear_modifier : int = 0
@export_subgroup("Charisma")
@export var charisma : int = 12
@export var charisma_modifier : int = 0
@export var charisma_gear_modifier : int = 0

@export_group("Unlocked Titles")
@export var unlocked_titles : Dictionary = { "none": ""}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
