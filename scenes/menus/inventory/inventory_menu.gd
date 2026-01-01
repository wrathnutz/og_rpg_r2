extends Control

@onready var btn_close: Button = $PanelContainer/Panel2/btnClose

@onready var sfx_mouseover: AudioStreamPlayer = $Button4
@onready var sfx_button: AudioStreamPlayer = $ButtonMouseover

#stats page
@onready var lbl_name: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelInfo/lblName
@onready var rt_lbl_title: RichTextLabel = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelInfo/RTLblTitle
@onready var lbl_class: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelInfo/lblClass
@onready var lbl_level: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/lblLevel
@onready var lbl_experience: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/lblExperience

@onready var lbl_str_value: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/GridContainer/lblStrValue
@onready var lbl_dex_value: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/GridContainer/lblDexValue
@onready var lbl_con_value: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/GridContainer/lblConValue
@onready var lbl_int_value: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/GridContainer/lblIntValue
@onready var lbl_wis_value: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/GridContainer/lblWisValue
@onready var lbl_char_value: Label = $PanelContainer/Panel/TabContainer/Stats/PanelContainer/PanelStats/GridContainer/lblCharValue

#inventory page
@onready var gc_inv: GridContainer = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Inventory/GridContainerInventory
@onready var gc_slot : PackedScene = preload("uid://bephm2c7083cv")

@onready var lbl_item_description: RichTextLabel = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Inventory/lblItemDescription
@onready var op_light: OptionButton = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Inventory/OpLight

@onready var lbl_defense: Label = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Equipped/lblDefense

@onready var slot_head: Button = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Equipped/SlotHead
@onready var slot_neck: Button = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Equipped/SlotNeck
@onready var slot_chest: Button = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Equipped/SlotChest
@onready var slot_legs: Button = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Equipped/SlotLegs
@onready var slot_feet: Button = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Equipped/SlotFeet
@onready var slot_mainhand: Button = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Equipped/SlotMainHand
@onready var slot_offhand: Button = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Equipped/SlotOffHand
@onready var slot_ring: Button = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Equipped/SlotRing
@onready var slot_trinket: Button = $PanelContainer/Panel/TabContainer/Inventory/PanelContainer/Panel_Equipped/SlotTrinket


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btn_close.grab_focus()
	
	GameUtilities.update_defense()
	
	#setup the player stats page
	lbl_name.text = GameState.player_name
	rt_lbl_title.text = GameState.unlocked_titles.get(GameState.player_title)
	lbl_class.text = GameState.player_class
	lbl_level.text = "Level: " + str(GameState.player_level)
	lbl_experience.text = "Experience: " + str(GameState.player_xp)
	
	lbl_str_value.text = str(GameState.strength + GameState.strength_modifier + GameState.strength_gear_modifier)
	lbl_dex_value.text = str(GameState.dexterity + GameState.dexterity_modifier + GameState.dexterity_gear_modifier)
	lbl_con_value.text = str(GameState.constitution + GameState.constitution_modifier + GameState.constitution_gear_modifier)
	lbl_int_value.text = str(GameState.intelligence + GameState.intelligence_modifier + GameState.intelligence_gear_modifier)
	lbl_wis_value.text = str(GameState.wisdom + GameState.wisdom_modifier + GameState.wisdom_gear_modifier)
	lbl_char_value.text = str(GameState.charisma + GameState.charisma_modifier + GameState.charisma_gear_modifier)
	
	#init the player inventory
	_update_item_description("")
	_clear_inv_slots()
	_set_inv_slots()
	
	# init the player lights
	_init_lights()
	
	#connect the equipment slots
	slot_head.update_description.connect(_update_item_description)
	slot_chest.update_description.connect(_update_item_description)
	slot_legs.update_description.connect(_update_item_description)
	slot_feet.update_description.connect(_update_item_description)
	slot_neck.update_description.connect(_update_item_description)
	slot_mainhand.update_description.connect(_update_item_description)
	slot_offhand.update_description.connect(_update_item_description)
	slot_trinket.update_description.connect(_update_item_description)
	slot_ring.update_description.connect(_update_item_description)
	
	slot_head.equipment_action.connect(_handle_equipment_action)
	slot_chest.equipment_action.connect(_handle_equipment_action)
	slot_legs.equipment_action.connect(_handle_equipment_action)
	slot_feet.equipment_action.connect(_handle_equipment_action)
	slot_neck.equipment_action.connect(_handle_equipment_action)
	slot_mainhand.equipment_action.connect(_handle_equipment_action)
	slot_offhand.equipment_action.connect(_handle_equipment_action)
	slot_trinket.equipment_action.connect(_handle_equipment_action)
	slot_ring.equipment_action.connect(_handle_equipment_action)
	
	_set_equipment_slots()
	
	_update_defense_label()


func _update_item_description(new_text : String) -> void:
	lbl_item_description.text = new_text

func _clear_inv_slots() -> void:
	for item in gc_inv.get_children():
		item.queue_free()

func _set_inv_slots() -> void:
	#clear inventory slots first
	if gc_inv.get_child_count() > 0:
		var children = gc_inv.get_children()
		for c in children:
			gc_inv.remove_child(c)
			c.queue_free()
	
	for i in range(GameState.max_inventory):
		var new_slot = gc_slot.instantiate()
		#We need to add the child before we can update the new slot data
		gc_inv.add_child(new_slot)
		new_slot.inventory_slot_index = i
		if GameState.player_inventory.size() > i:
			if GameState.player_inventory[i] != null:
				new_slot.inventory_data = GameState.player_inventory[i]
				#print("setting inventory popup")
				#print(new_slot.get_popup_pos())
				new_slot.inventory_action.connect(_handle_inventory_action)
		new_slot.update_description.connect(_update_item_description)

func _handle_inventory_action(action: String, slot_index:  int) -> void:
	#print("player_menu handling inventory_action: " + action + ", slot: " + str(slot_index))
	match action:
		"Use":
			#on equip activates inventory data usage
			GameState.player_inventory[slot_index]._on_equip()
			if GameState.player_inventory[slot_index].count == 0:
				GameState.player_inventory.remove_at(slot_index)
		"Drop":
			GameState.player_inventory.remove_at(slot_index)
			pass
		"Equip":
			var slot_name : String = ""
			if GameState.player_inventory[slot_index].type == GameUtilities.item_type.ARMOR:
				match GameState.player_inventory[slot_index].slot_type:
					GameUtilities.armor_slot.HEAD:
						slot_name = "head"
					GameUtilities.armor_slot.NECK:
						slot_name = "neck"
					GameUtilities.armor_slot.CHEST:
						slot_name = "chest"
					GameUtilities.armor_slot.LEGS:
						slot_name = "legs"
					GameUtilities.armor_slot.FEET:
						slot_name = "feet"
					GameUtilities.armor_slot.RING:
						slot_name = "ring"
					GameUtilities.armor_slot.TRINKET:
						slot_name = "trinket"
			else:
				#handle the weapons
				pass
			
			GameState.equip(slot_name, slot_index)
	#We need to draw the inventory
	_set_inv_slots()
	_set_equipment_slots()
	_update_defense_label()

func _set_equipment_slots() -> void:
	slot_head.set_inv_data(GameState.player_equipment.get("head"))
	slot_chest.set_inv_data(GameState.player_equipment.get("chest"))
	slot_legs.set_inv_data(GameState.player_equipment.get("legs"))
	slot_feet.set_inv_data(GameState.player_equipment.get("feet"))
	slot_neck.set_inv_data(GameState.player_equipment.get("neck"))
	slot_mainhand.set_inv_data(GameState.player_equipment.get("mainhand"))
	slot_offhand.set_inv_data(GameState.player_equipment.get("offhand"))
	slot_trinket.set_inv_data(GameState.player_equipment.get("trinket"))
	slot_ring.set_inv_data(GameState.player_equipment.get("ring"))

func _update_defense_label() -> void :
	lbl_defense.text = "Defense: " + str(GameState.player_defense)

func _init_lights() -> void:
	op_light.clear()
	for light in GameState.player_lights:
		op_light.add_item(light)
	if GameState.player_lights.size() > 0:
		op_light.select(GameState.current_light)

func _handle_equipment_action(action: String, strSlot : String) -> void:
	#print("player_menu handling equipment_action: " + action + ", slot: " + strSlot)
	match action:
		"Unequip":
			if GameUtilities.unequip(strSlot):
				#We need to draw the equipment
				_set_equipment_slots()
				_set_inv_slots()
		"Drop":
			GameUtilities.drop_equipment(strSlot)
			_set_equipment_slots()
	_update_defense_label()


func _on_btn_close_pressed() -> void:
	sfx_button.play()
	await sfx_button.finished
	self.queue_free()


func _on_btn_close_focus_entered() -> void:
	sfx_mouseover.play()
