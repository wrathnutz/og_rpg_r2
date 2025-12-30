extends Sprite2D

var dlg_closed = preload("res://assets/dialogue/doors/closed.dialogue")
var dlg_locked = preload("res://assets/dialogue/doors/locked.dialogue")
var dlg_magic = preload("res://assets/dialogue/doors/magic_locked.dialogue")
var dlg_sealed = preload("res://assets/dialogue/doors/sealed.dialogue")

@onready var interactable: Area2D = $Interactable
@onready var sfx_door_open: AudioStreamPlayer = $AncientGameWoodenDoorLatch1

@export var current_state : GameUtilities.door_state = GameUtilities.door_state.CLOSED

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact


func _on_interact():
	interactable.is_interactable = false
	SignalBus.player_move_toggle(false)
	match current_state:
		GameUtilities.door_state.CLOSED:
			DialogueManager.show_example_dialogue_balloon(dlg_closed)
			await DialogueManager.dialogue_ended
			open_door()
		GameUtilities.door_state.LOCKED:
			DialogueManager.show_example_dialogue_balloon(dlg_locked)
			await DialogueManager.dialogue_ended
			open_door()
			
		GameUtilities.door_state.MAGIC_LOCK:
			DialogueManager.show_example_dialogue_balloon(dlg_magic)
			await DialogueManager.dialogue_ended
			interactable.is_interactable = true
		GameUtilities.door_state.SEALED:
			DialogueManager.show_example_dialogue_balloon(dlg_sealed)
			await DialogueManager.dialogue_ended
			interactable.is_interactable = true
	
	
	SignalBus.player_move_toggle(true)

func open_door() -> void:
	sfx_door_open.play()
	await sfx_door_open.finished
	self.hide()
	self.set_process_mode(Node.PROCESS_MODE_DISABLED)
	
