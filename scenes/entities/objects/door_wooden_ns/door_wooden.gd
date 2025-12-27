extends Sprite2D

enum door_state {OPEN = 0, CLOSED = 1, LOCKED = 2, MAGIC_LOCK = 3, SEALED = 4}

@onready var interactable: Area2D = $Interactable
@onready var sfx_door_open: AudioStreamPlayer = $AncientGameWoodenDoorLatch1

@export var current_state : door_state = door_state.CLOSED

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact


func _on_interact():
	interactable.is_interactable = false
	print("Player tried to open the door")
	sfx_door_open.play()
	await sfx_door_open.finished
	self.hide()
	self.set_process_mode(Node.PROCESS_MODE_DISABLED)
