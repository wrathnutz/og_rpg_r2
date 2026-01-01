class_name weapon extends InventoryData

@export var slot_type : GameUtilities.weapon_slot
@export var proficiency : GameUtilities.proficiency_stat
@export var number_of_dice : int = 1
@export var dice_sides : int = 4
@export var bonus_damage: int = 0
@export var base_chance_to_hit : int = 10
var average_damage_value : int
var chance_to_hit_bonus : int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.equip = Callable(self, "_on_equip")
	self.unequip = Callable(self, "_on_unequip")

func _on_equip() -> void:
	_update_hit_bonus()

func _update_hit_bonus() -> void:
	var proficiency_value : int = GameUtilities.get_proficiency_value(proficiency)
	var percentage_bonus : float = 0.0
	
	# -25% at 1 and +25% at 20
	if proficiency >= 1 and proficiency < 10:
		percentage_bonus = _scaled_percentage(-0.25, 0, 1.0, 10.0, float(proficiency_value))
	else:
		percentage_bonus = _scaled_percentage(0, 0.25, 10.0, 20.0, float(proficiency_value))
	
	chance_to_hit_bonus = int(base_chance_to_hit * percentage_bonus)


func _on_unequip() -> void: 
	pass

func _scaled_percentage(output_start : float, output_end : float, input_start: float, input_end: float, input : float) -> float:
	var slope : float = (output_end - output_start) / (input_end - input_start)
	return output_start + slope * (input - input_start)



func get_damage() -> int :
	var retval : int = 0
	
	for n in number_of_dice:
		retval += GameState.rng.randi_range(1, dice_sides)
	
	return retval

func get_attack_roll() -> int:
	var retval : int = 0
	retval = GameState.rng.randi_range(1, 20)
	if retval != 1:
		retval += chance_to_hit_bonus
	
	return retval

func update_average_damage()->void:
	@warning_ignore("integer_division")
	average_damage_value = ((dice_sides * number_of_dice) - number_of_dice) / 2
