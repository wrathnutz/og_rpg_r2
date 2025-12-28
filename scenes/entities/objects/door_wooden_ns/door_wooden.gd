extends Sprite2D

enum door_state {OPEN = 0, CLOSED = 1, LOCKED = 2, MAGIC_LOCK = 3, SEALED = 4}

var dlg_closed = preload("res://assets/dialogue/doors/closed.dialogue")
var dlg_locked = preload("res://assets/dialogue/doors/locked.dialogue")
var dlg_magic = preload("res://assets/dialogue/doors/magic_locked.dialogue")
var dlg_sealed = preload("res://assets/dialogue/doors/sealed.dialogue")

@onready var interactable: Area2D = $Interactable
@onready var sfx_door_open: AudioStreamPlayer = $AncientGameWoodenDoorLatch1

@export var current_state : door_state = door_state.CLOSED

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact


func _on_interact():
	interactable.is_interactable = false
	SignalBus.player_move_toggle(false)
	match current_state:
		door_state.CLOSED:
			var balloon = DialogueManager.show_example_dialogue_balloon(dlg_closed)
			await balloon.tree_exited
			open_door()
		door_state.LOCKED:
			var balloon = DialogueManager.show_example_dialogue_balloon(dlg_locked)
			await balloon.tree_exited
			open_door()
		door_state.MAGIC_LOCK:
			var balloon = DialogueManager.show_example_dialogue_balloon(dlg_magic)
			await balloon.tree_exited
			interactable.is_interactable = true
		door_state.SEALED:
			var balloon = DialogueManager.show_example_dialogue_balloon(dlg_sealed)
			await balloon.tree_exited
			interactable.is_interactable = true
	
	
	SignalBus.player_move_toggle(true)

func open_door() -> void:
	sfx_door_open.play()
	await sfx_door_open.finished
	self.hide()
	self.set_process_mode(Node.PROCESS_MODE_DISABLED)
	
