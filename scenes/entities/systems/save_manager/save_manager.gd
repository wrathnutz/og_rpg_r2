extends Node

var save_slot : int = 1
var max_save_slots : int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_F5:
			save_game()
		pass

func create_new_game_save() -> void:
	#reset the game state
	GameState.reset_state()
	#point to the intro cutscene
	GameState.current_scene =  "uid://d0uqbc8k65vw"
	GameState.spawn_location = ""
	save_game()
	
func save_game()->void:
	var gamestate_data : Dictionary = GameState.serialize()
	var fname : String = "save" + str(save_slot) + ".sav"
	_check_dir()
	var save_file = FileAccess.open("user://og_rpg//" + fname, FileAccess.WRITE)
	if save_file:
		save_file.store_line(JSON.stringify(gamestate_data))
	else:
		print("Cannot write to save file")

func load_game() -> void:
	var fname : String = "save" + str(save_slot) + ".sav"
	var save_file = FileAccess.open("user://og_rpg//" + fname, FileAccess.READ)
	GameState.deserialize(JSON.parse_string(save_file.get_line()))
	scene_manager.change_scene_fade(GameState.current_scene)

func load_game_file() -> Dictionary:
	var fname : String = "save" + str(save_slot) + ".sav"
	var retval : Dictionary = {}
	#Make sure the directory exists
	_check_dir()
	
	#See if the file exists
	if FileAccess.file_exists("user://og_rpg//" + fname):
		var save_file = FileAccess.open("user://og_rpg//" + fname, FileAccess.READ)
		retval = JSON.parse_string(save_file.get_line())
	
	return retval

func _check_dir() -> void:
	#make sure the directory exists
	var dir = DirAccess.open("user://")
	if dir.dir_exists("user://og_rpg") == false:
		var err = dir.make_dir("user://og_rpg")
		if err != OK:
			print("cannot create directory")
	
