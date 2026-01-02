@tool
extends Button

signal update_description
signal equipment_action

@onready var equipment_popup: PopupMenu = $PopupMenu
@onready var lbl_slot_name: Label = $lblSlotName
@onready var fg_texture: TextureRect = $TextureRect_BG/TextureRect_FG

@export var inventory_data : InventoryData : set = set_inv_data
@export var slot_name : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	lbl_slot_name.text = slot_name
	if Engine.is_editor_hint() == false:
		focus_entered.connect(item_focused)
		focus_exited.connect(item_unfocused)
		#setup the popup menu
		_set_popup()

func set_inv_data(value : InventoryData) -> void:
	inventory_data = value
	#if the data is null just jump out
	if inventory_data == null:
		fg_texture.texture = null
		return
	#update the data if it is not null
	inventory_data.inventory_texture = value.inventory_texture
	fg_texture.texture = inventory_data.inventory_texture


func item_focused() -> void:
	if inventory_data != null:
		update_description.emit(inventory_data.description)
		equipment_popup.visible = true
	else:
		update_description.emit("")

func item_unfocused() -> void:
	update_description.emit("")
	equipment_popup.visible = false

func _set_popup()-> void:
	#set the menu position
	equipment_popup.position.x = int(self.global_position.x + (600 - ((float(equipment_popup.size.y)/2.0) - 15)))
	equipment_popup.position.y = int(self.global_position.y - ((float(equipment_popup.size.y)/2.0) + 15.0))
	equipment_popup.id_pressed.connect(_popup_pressed.bind())

func _popup_pressed(id : int)->void:
	equipment_action.emit(equipment_popup.get_item_text(id), slot_name)
	
