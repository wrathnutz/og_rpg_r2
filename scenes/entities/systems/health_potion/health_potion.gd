@tool
class_name HealthPotion extends InventoryData

@export var heal_amount : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	self.equip = Callable(self, "_on_equip")

func _on_equip()->void:
	#see if the player's health is low and we can use it
	if GameState.player_hp < GameState.player_max_hp:
		var total_amount : int = 0
		match self.quality:
			GameUtilities.item_quality.POOR:
				total_amount += -2
			GameUtilities.item_quality.NORMAL:
				pass
			GameUtilities.item_quality.GOOD:
				total_amount += 2
			GameUtilities.item_quality.EXQUISITE:
				total_amount += 5
		total_amount += heal_amount
		var new_hp = clamp(GameState.player_hp + total_amount, 0, GameState.player_max_hp)
		GameState.player_hp = new_hp
		#decrement the number of potions in the stack
		self.count = self.count - 1
		print("heal me for: " + str(total_amount))
	else:
		print("Cannot heal. Player at full health")
