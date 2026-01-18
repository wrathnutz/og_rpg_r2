@tool
extends Node2D

@export_range(1, 100, 1) var rows : int = 5 : set = _set_rows
@export_range(1, 100, 1) var columns : int = 1 : set = _set_columns

@export var hidden_offset_x : float = 0 : set = _set_offset_x
@export var hidden_offset_y : float = 0 : set = _set_offset_y


@export var door_texture : Texture
@export var hidden_texture : Texture


@export var success_lines : Array[String]
@export var dialog_speaker : String
@export var fail_lines : Array[String]

@export var proficiency : GameUtilities.proficiency_stat
@export var proficiency_target : int

var  sprite_array : Array[Sprite2D]

@onready var hidden_node: Node2D = $DoorTexture/HiddenNode
@onready var hidden_door: TextureRect = $DoorTexture

@onready var interactable: Area2D = $Interactable


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#This line throws an error if it is run in the editor and not at runtime
	if not Engine.is_editor_hint():
		interactable.interact = Callable(self, "_on_interact")
	hidden_node.position.x = hidden_door.position.x + hidden_door.position.x
	_update_array()

func _on_interact() -> void:
	if interactable.is_interactable:
		if _check_search():
			var line : int
			line = GameUtilities.rng.randi_range(0, success_lines.size() -1)
			var dlg_resource = DialogueManager.create_resource_from_text(success_lines[line])
			DialogueManager.show_example_dialogue_balloon(dlg_resource)
			interactable.is_interactable = false
			await DialogueManager.dialogue_ended
			self.queue_free()
		else:
			var line : int
			line = GameUtilities.rng.randi_range(0, fail_lines.size() -1)
			var dlg_resource = DialogueManager.create_resource_from_text(fail_lines[line])
			DialogueManager.show_example_dialogue_balloon(dlg_resource)
			interactable.is_interactable = false
			#interactable.unregtister()

func _check_search() -> bool:
	return GameUtilities.proficiency_check(proficiency, proficiency_target)

func _set_offset_x(new_offset: float) -> void:
	hidden_offset_x = new_offset
	_update_array()
	emit_signal("draw")

func _set_offset_y(new_offset: float) -> void:
	hidden_offset_y = new_offset
	_update_array()
	emit_signal("draw")


func _set_rows(new_rows: int) -> void:
	rows = new_rows
	_update_array()
	emit_signal("draw")

func _set_columns(new_columns:  int) -> void : 
	columns = new_columns
	_update_array()
	emit_signal("draw")
	
func _update_hidden_texture(new_texture: Texture)-> void:
	hidden_texture = new_texture
	_update_array()
	emit_signal("draw")

func _update_array() -> void:
	sprite_array.clear()
	for i in range(columns):
		for j in range(rows):
			var new_sprite = Sprite2D.new()
			new_sprite.texture = hidden_texture
			sprite_array.append(new_sprite)
			new_sprite.position.x = float(i * 32) + hidden_offset_x
			new_sprite.position.y = float(j * 32) + hidden_offset_y
	
	_clear_hidden()
	if hidden_node !=null:
		for sprite in sprite_array:
			@warning_ignore("integer_division")
			var yoffset = (rows / 2) * -32
			var newx = sprite.position.x + hidden_node.position.x + 48
			var newy = sprite.position.y + yoffset
			
			sprite.position.x = newx
			sprite.position.y = newy
			hidden_node.add_child(sprite)

func _clear_hidden()->void:
	if hidden_node != null:
		var children = hidden_node.get_children()
		for child in children:
			child.free()
