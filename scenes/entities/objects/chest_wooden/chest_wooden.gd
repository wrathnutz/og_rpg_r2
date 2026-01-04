extends Node2D



var current_state : GameUtilities.chest_state = GameUtilities.chest_state.CLOSED
@export var is_locked : bool = false
@onready var interactable: Area2D = $Interactable
@onready var chest_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_opening: AudioStreamPlayer = $AncientGameWoodenDoorOpen2


@export var loot : InventoryData
@export var gold_amount: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = try_open

func try_open() -> void:
	if is_locked:
		#need to handle locked chests (Pick, force, magic, or key)
		var dlg_resource = DialogueManager.create_resource_from_text("This chest is locked.")
		DialogueManager.show_example_dialogue_balloon(dlg_resource)
	else:
		#Need to handle inventory being full
		open()
	pass

func open() -> void:
	interactable.is_interactable = false
	chest_sprite.play("opening")
	sfx_opening.play()
	await chest_sprite.animation_finished
	chest_sprite.play("opened")
	var msg_loot : String = ""
	if gold_amount > 0:
		msg_loot = "you found " + str(gold_amount) + "gold"
	else:
		msg_loot = "you found a " + loot.name
		
	var dlg_resource = DialogueManager.create_resource_from_text(msg_loot)
	DialogueManager.show_example_dialogue_balloon(dlg_resource)
	GameUtilities.AddtoInventory(loot)
	
