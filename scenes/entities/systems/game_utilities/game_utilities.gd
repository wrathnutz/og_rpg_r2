extends Node

enum proficiency_stat {STRENGTH, DEXTERITY, CONSTITUTION, INTELLIGENCE, WISDOM, CHARISMA}
enum alignment {good, neutral, evil}

enum door_state {OPEN = 0, CLOSED = 1, LOCKED = 2, MAGIC_LOCK = 3, SEALED = 4}

enum chest_state{OPENED=0, CLOSED=1, OPENING=3}

enum item_type {RESOURCE, CONSUMABLE, WEAPON, ARMOR, QUEST_ITEM}
enum item_quality {POOR, NORMAL, GOOD, EXQUISITE}

enum armor_slot {HEAD, NECK, CHEST, LEGS, FEET, RING, TRINKET}
enum weapon_slot {MAINHAND, OFFHAND}


var rng = RandomNumberGenerator.new()

func get_proficiency_value(proficiency: proficiency_stat) -> int:
	match proficiency:
		proficiency_stat.STRENGTH:
			return GameState.player_data.strength
		proficiency_stat.DEXTERITY:
			return GameState.player_data.dexterity
		proficiency_stat.CONSTITUTION:
			return GameState.player_data.constitution
		proficiency_stat.INTELLIGENCE:
			return GameState.player_data.intelligence
		proficiency_stat.WISDOM:
			return GameState.player_data.wisdom
		proficiency_stat.CHARISMA:
			return GameState.player_data.charisma
		_:
			return GameState.player_data.strength

func update_defense()->void:
	GameState.player_defense = 0.0
	for key in GameState.player_equipment:
		if GameState.player_equipment[key] != null and GameState.player_equipment[key].type == GameUtilities.item_type.ARMOR:
			GameState.player_equipment[key]._update_defense()
			GameState.player_defense += GameState.player_equipment[key].defense_value


func update_attack()->void:
	pass

func drop_equipment(slot_type : String):
	if slot_type != "":
		GameState.player_equipment.set(slot_type, null)
		update_defense()

func unequip(slot_type : String) -> bool:
	var retval : bool = false
	if AddtoInventory(GameState.player_equipment.get(slot_type)):
		GameState.player_equipment.set(slot_type, null)
		update_defense()
		retval = true
	return retval

func equip(slot_type : String, inv_index : int):
	#If something is already equipped, swap it
	if GameState.player_equipment.get(slot_type) != null:
		var tmp_inv : InventoryData = GameState.player_equipment.get(slot_type)
		GameState.player_equipment.set(slot_type, GameState.player_inventory[inv_index])
		GameState.player_inventory[inv_index] = tmp_inv
	else:
		GameState.player_equipment.set(slot_type, GameState.player_inventory[inv_index])
		GameState.player_inventory.remove_at(inv_index)
	pass

# Try to add item to player_inventory. Return true if successful.
func AddtoInventory(inv_data : InventoryData) -> bool:
	var retval : bool = false
	#see if the inventory already contains the item and can it be stacked?
	var index_position : int = GameState.player_inventory.find(inv_data)
	if index_position > -1:
		if GameState.player_inventory[index_position].count < GameState.player_inventory[index_position].max_stack:
			GameState.player_inventory[index_position].count = GameState.player_inventory[index_position].count + 1
			return true
	
	#Looks like it wasn't found or has a full stack. See if we aren't at the max inventory
	if GameState.player_inventory.size() < (GameState.max_inventory):
		GameState.player_inventory.append(inv_data)
		return true
	
	return retval

#remove an item from the player inventory
func RemovefromInventory(inv_index : int) -> void:
	if inv_index >= 0 and inv_index < GameState.max_inventory:
		match GameState.player_inventory[inv_index].item_type:
			item_type.CONSUMABLE:
				GameState.player_inventory[inv_index].count = GameState.player_inventory[inv_index].count - 1
				if GameState.player_inventory[inv_index].count == 0:
					GameState.player_inventory.remove_at(inv_index)
			item_type.RESOURCE:
				GameState.player_inventory[inv_index].count = GameState.player_inventory[inv_index].count - 1
				if GameState.player_inventory[inv_index].count == 0:
					GameState.player_inventory.remove_at(inv_index)
			item_type.WEAPON:
				GameState.player_inventory.remove_at(inv_index)
			item_type.ARMOR:
				GameState.player_inventory.remove_at(inv_index)
