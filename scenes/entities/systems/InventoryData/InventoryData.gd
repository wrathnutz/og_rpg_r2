@abstract
class_name InventoryData extends Resource


@export var inventory_texture : Texture2D
@export var count : int = 0
@export var max_stack : int = 1
@export var name : String = ""
@export_multiline var description : String = ""
@export var value : int = 1
@export var type : GameUtilities.item_type = GameUtilities.item_type.RESOURCE
@export var quality : GameUtilities.item_quality = GameUtilities.item_quality.POOR

var equip : Callable = func():
	pass
	
var unequip : Callable = func():
	pass
