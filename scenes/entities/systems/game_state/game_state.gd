extends Node

@export_category("Game Version") 
@export_group("Version Numbering")
@export var version_major : int = 0
@export var version_minor :int = 0
@export var version_build : int = 10

@export_category("Player") 
@export var player_name : String = ""
@export var player_title : String = "none"
@export var player_class : String = ""
@export var player_level : int = 1
@export var player_xp : int = 0
@export var player_max_hp : int = 10
@export var player_hp : int = 10
@export var player_max_mp : int = 4
@export var player_mp : int = 4
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

@export_category("Titles")

@export var unlocked_titles : Dictionary[String,String] = { "none": ""}
@export var titles_list : Dictionary[String,String] = {}

@export_category("Inventory")
@export var max_inventory : int = 8
@export var player_inventory : Array[InventoryData] = []

@export_category("Inventory")
var current_light : int = -1
@export var player_lights : Array[String] = []

@export_category("Equipment")
@export var player_equipment: Dictionary = {
	"head" : null,
	"neck" : null,
	"chest" : preload("uid://bx4rvmfp1d6ln"),
	"waist" : null,
	"legs" : preload("uid://ddc70e5mljxq1"),
	"feet" : preload("uid://c70rigtcliwqf"),
	"offhand" : null,
	"mainhand" : preload("uid://i3f0hd8tsdqw"),
	"ring" : null,
	"trinket" : null
}

var player_defense : float = 0.0
var player_attack : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
