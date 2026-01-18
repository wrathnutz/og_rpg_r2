extends Node

enum proficiency_stat {STRENGTH, DEXTERITY, CONSTITUTION, INTELLIGENCE, WISDOM, CHARISMA}
enum alignment {good, neutral, evil}

enum door_state {OPEN = 0, CLOSED = 1, LOCKED = 2, MAGIC_LOCK = 3, SEALED = 4}

enum chest_state{OPENED=0, CLOSED=1, OPENING=3}

enum item_type {RESOURCE=0, CONSUMABLE=1, WEAPON=2, ARMOR=3, QUEST_ITEM=4}
enum item_quality {POOR=0, NORMAL=1, GOOD=2, EXQUISITE=3}

enum armor_slot {HEAD, NECK, CHEST, LEGS, FEET, RING, TRINKET}
enum weapon_slot {MAINHAND, OFFHAND}

var rng = RandomNumberGenerator.new()

func scaled_percentage(output_start : float, output_end : float, input_start: float, input_end: float, input : float) -> float:
	var slope : float = (output_end - output_start) / (input_end - input_start)
	return output_start + slope * (input - input_start)

func get_proficiency_value(proficiency: proficiency_stat) -> int:
	match proficiency:
		proficiency_stat.STRENGTH:
			return GameState.strength + GameState.strength_modifier + GameState.strength_gear_modifier
		proficiency_stat.DEXTERITY:
			return GameState.dexterity + GameState.dexterity_modifier + GameState.dexterity_gear_modifier
		proficiency_stat.CONSTITUTION:
			return GameState.constitution + GameState.constitution + GameState.constitution_modifier
		proficiency_stat.INTELLIGENCE:
			return GameState.intelligence + GameState.intelligence_modifier + GameState.intelligence_gear_modifier
		proficiency_stat.WISDOM:
			return GameState.wisdom + GameState.wisdom_modifier + GameState.wisdom_gear_modifier
		proficiency_stat.CHARISMA:
			return GameState.charisma + GameState.charisma_modifier + GameState.charisma_gear_modifier
		_:
			return GameState.player_data.strength + GameState.strength_modifier + GameState.strength_gear_modifier

func proficiency_check(proficiency: proficiency_stat, threshold: int) -> bool:
	var retval = false
	#var total_proficiency = get_proficiency_value(proficiency)
	var percentage_bonus : float = 0.0
	var proficiency_value = get_proficiency_value(proficiency)
	
	# -25% at 1 and +25% at 20
	if proficiency_value >= 1 and proficiency_value < 10:
		percentage_bonus = scaled_percentage(-0.25, 0, 1.0, 10.0, float(proficiency_value))
	else:
		percentage_bonus = scaled_percentage(0, 0.25, 10.0, 20.0, float(proficiency_value))
	
	var dice_roll = rng.randi_range(1, 20) + int(percentage_bonus)
	
	if dice_roll >= threshold:
		retval = true
	
	return retval



func update_defense()->void:
	GameState.player_defense = 0.0
	for key in GameState.player_equipment:
		if GameState.player_equipment[key] != null and GameState.player_equipment[key].type == GameUtilities.item_type.ARMOR:
			GameState.player_equipment[key]._update_defense()
			GameState.player_defense += GameState.player_equipment[key].defense_value


func update_attack()->void:
	print("do something")
	pass

func drop_equipment(slot_type : String):
	if slot_type != "":
		GameState.player_equipment.set(slot_type, null)
		update_defense()

func unequip(slot_type : String) -> bool:
	var retval : bool = false
	if AddtoInventory(GameState.player_equipment.get(slot_type)):
		#If we successfully added the gear to the inventory, set the slot equal to null
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
