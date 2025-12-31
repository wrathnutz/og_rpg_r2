extends Button

@onready var lbl_quantity: Label = $lblQuantity
@onready var fg_texture: TextureRect = $TextureRect_BG/TextureRect_FG
@onready var inv_popup: PopupMenu = $PopupMenu


@export var inventory_data : InventoryData : set = set_inv_data


var inventory_slot_index : int = -1

signal update_description
signal inventory_action

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lbl_quantity.text = ""
	focus_entered.connect(item_focused)
	focus_exited.connect(item_unfocused)


func set_inv_data(value : InventoryData) -> void:
	inventory_data = value
	
	if !is_instance_valid(fg_texture):
		print("fg_texture is not valid")
	
	if inventory_data == null:
		return
	#deep copy data
	inventory_data.inventory_texture = value.inventory_texture	
	fg_texture.texture = inventory_data.inventory_texture
	lbl_quantity.text = str(inventory_data.count)	
	#setup the popup menu
	_set_popup()

func item_focused() -> void:
	if inventory_data != null:
		update_description.emit(inventory_data.description)
		inv_popup.visible = true
	else:
		update_description.emit("")

func item_unfocused() -> void:
	update_description.emit("")
	inv_popup.visible = false

func _set_popup()-> void:
	match inventory_data.type:
		inventory_data.item_type.RESOURCE:
			inv_popup.add_item("Drop")
		inventory_data.item_type.CONSUMABLE:
			inv_popup.add_item("Use")
			inv_popup.add_item("Drop")
		inventory_data.item_type.WEAPON:
			inv_popup.add_item("Equip")
			inv_popup.add_item("Drop")
		inventory_data.item_type.ARMOR:
			inv_popup.add_item("Equip")
			inv_popup.add_item("Drop")
	#set the menu position
	inv_popup.position.x = int(self.global_position.x * inventory_slot_index)
	#inv_popup.position.y = int(self.global_position.y - ((float(inv_popup.size.y)/2.0) + 15.0) )
	@warning_ignore("integer_division")
	inv_popup.position.y = 45 + int(int(inventory_slot_index/10) * 45)
	
	inv_popup.id_pressed.connect(_popup_pressed.bind())

func get_popup_pos() ->String:
	#return str(fg_texture.position) + str(fg_texture.global_position)
	return str(inv_popup.position) + "slot index: " + str(inventory_slot_index)

func _popup_pressed(id : int)->void:
	inventory_action.emit(inv_popup.get_item_text(id), inventory_slot_index)
	
