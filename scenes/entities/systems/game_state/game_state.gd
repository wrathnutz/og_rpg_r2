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
@export var player_inventory : Array[Resource] = []

@export_category("Inventory")
@export var gold : int = 0
@export var keys : int = 0
@export var current_light : int = 0
@export var player_lights : Array[String] = ["none"]

@export_category("Equipment")
@export var player_equipment: Dictionary[String, Resource] = {
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
		
		#Titles
		"unlocked_titles" : unlocked_titles,

		#inventory
		"max_inventory" : max_inventory,
		"player_inventory" : _pack_player_inventory(),
		
		"gold" : gold,
		"keys" : keys,
		"current_light" : current_light,
		"player_lights" : player_lights,
		
		#Equipment
		"player_equipment ": _pack_player_equipment(),
		
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

func _pack_player_equipment() -> Dictionary:
	var retval : Dictionary[String,String]
	retval["head"] = _get_scene_uid(player_equipment.get("head"))
	retval["neck"] = _get_scene_uid(player_equipment.get("neck"))
	retval["chest"] = _get_scene_uid(player_equipment.get("chest"))
	retval["waist"] = _get_scene_uid(player_equipment.get("waist"))
	retval["legs"] = _get_scene_uid(player_equipment.get("legs"))
	retval["feet"] = _get_scene_uid(player_equipment.get("feet"))
	retval["offhand"] = _get_scene_uid(player_equipment.get("offhand"))
	retval["mainhand"] = _get_scene_uid(player_equipment.get("mainhand"))
	retval["ring"] = _get_scene_uid(player_equipment.get("ring"))
	retval["trinket"] = _get_scene_uid(player_equipment.get("trinket"))
	return retval

func _pack_player_inventory() -> Array:
	var retval : Array
	
	for item in player_inventory:
		retval.append(_get_scene_uid(item))
		
		#retval.append(item.get_path())
		print("get_path(): " + item.get_path())
		print("resource_path: " + item.resource_path)
		print("resource_name: " + item.resource_name)
		#print("to_string(): " + item.get_id_for_path())
		print("to_string(): " + item.to_string())
	return retval


func _get_scene_uid(scn) -> String:
	var retval = ""
	if scn != null:
		retval = ResourceUID.id_to_text(ResourceLoader.get_resource_uid(scn.get_path()))
	return retval
