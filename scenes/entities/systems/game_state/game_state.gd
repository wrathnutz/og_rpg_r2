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
@export var gold : int = 0
@export var keys : int = 0
@export var current_light : String = "none"
@export var player_lights : Dictionary [String, Resource]= {
	"none" : null
}

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

@export_category("Current Scene")
@export var current_scene : String = ""
@export var spawn_location : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func serialize() -> Dictionary:
	var retval : Dictionary = {
		#Serialize the version info
		"version_major" : version_major,
		"version_minor" : version_minor,
		"version_build" : version_build,
		#Serialize player info
		"player_name" : player_name,
		"player_title" : player_title,
		"player_class" : player_class,
		"player_level" : player_level,
		"player_xp" : player_xp,
		"player_max_hp" : player_max_hp,
		"player_hp" : player_hp,
		"player_max_mp" : player_max_mp,
		"player_mp" : player_mp,
		#Serialize player stats
		"strength" : strength,
		"strength_modifier" : strength_modifier,
		"strength_gear_modifier" : strength_gear_modifier,
		"dexterity" : dexterity,
		"dexterity_modifier" : dexterity_modifier,
		"dexterity_gear_modifier" : dexterity_gear_modifier,
		"constitution" : constitution,
		"constitution_modifier" : constitution_modifier,
		"constitution_gear_modifier" : constitution_gear_modifier,
		"intelligence" : intelligence,
		"intelligence_modifier" : intelligence_modifier,
		"intelligence_gear_modifier" : intelligence_gear_modifier,
		"wisdom" : wisdom,
		"wisdom_modifier" : wisdom_modifier,
		"wisdom_gear_modifier" : wisdom_gear_modifier,
		"charisma" : charisma,
		"charisma_modifier" : charisma_modifier,
		"charisma_gear_modifier" : charisma_gear_modifier,
		
		#Serialize current scene uuid
		"current_scene" : current_scene,
		"spawn_location" : spawn_location
	}
	
	return retval
	
func deserialize(save_data : Dictionary) -> void:
	#Dont Deserialize version info. Use to to handle different save files
	var _file_version_major = save_data.get("version_major")
	var _file_version_minor = save_data.get("version_minor")
	var _file_version_build = save_data.get("version_build")
	
	#Deserialize player info
	player_name = save_data.get("player_name")
	player_title = save_data.get("player_title")
	player_class = save_data.get("player_class")
	player_level = save_data.get("player_level")
	player_xp = save_data.get("player_xp")
	player_max_hp = save_data.get("player_max_hp")
	player_hp = save_data.get("player_hp")
	player_max_mp = save_data.get("player_max_mp")
	player_mp = save_data.get("player_mp")
	#Deserialize player stats
	strength = save_data.get("strength")
	strength_modifier = save_data.get("strength_modifier")
	strength_gear_modifier = save_data.get("strength_gear_modifier")
	dexterity = save_data.get("dexterity")
	dexterity_modifier = save_data.get("dexterity_modifier")
	dexterity_gear_modifier = save_data.get("dexterity_gear_modifier")
	constitution = save_data.get("constitution")
	constitution_modifier = save_data.get("constitution_modifier")
	constitution_gear_modifier = save_data.get("constitution_gear_modifier")
	intelligence = save_data.get("intelligence")
	intelligence_modifier = save_data.get("intelligence_modifier")
	intelligence_gear_modifier = save_data.get("intelligence_gear_modifier")
	wisdom = save_data.get("wisdom")
	wisdom_modifier = save_data.get("wisdom_modifier")
	wisdom_gear_modifier = save_data.get("wisdom_gear_modifier")
	charisma = save_data.get("charisma")
	charisma_modifier = save_data.get("charisma_modifier")
	charisma_gear_modifier = save_data.get("charisma_gear_modifier")
	
	#Serialize current scene uuid
	current_scene = save_data.get("current_scene")
	spawn_location = save_data.get("spawn_location")
