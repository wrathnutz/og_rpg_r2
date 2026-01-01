class_name armor extends InventoryData

@export var slot_type : GameUtilities.armor_slot
@export var proficiency : GameUtilities.proficiency_stat
@export var defense_base_value : float = 1
var defense_value : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.equip = Callable(self, "_on_equip")
	self.unequip = Callable(self, "_on_unequip")

func _on_equip() -> void:
	_update_defense()

func _on_unequip() -> void: 
	pass

func _update_defense() -> void:
	var proficiency_value : int = GameUtilities.get_proficiency_value(proficiency)
	var percentage_bonus : float = 0.0
	
	# -25% at 1 and +25% at 20
	if proficiency >= 1 and proficiency < 10:
		percentage_bonus = _scaled_percentage(-0.25, 0, 1.0, 10.0, float(proficiency_value))
	else:
		percentage_bonus = _scaled_percentage(0, 0.25, 10.0, 20.0, float(proficiency_value))
	
	defense_value = defense_base_value + (defense_base_value * percentage_bonus)

func _scaled_percentage(output_start : float, output_end : float, input_start: float, input_end: float, input : float) -> float:
	var slope : float = (output_end - output_start) / (input_end - input_start)
	return output_start + slope * (input - input_start)
