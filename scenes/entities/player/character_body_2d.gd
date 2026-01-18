extends CharacterBody2D

const SPEED = 100.0
var _allow_movement : bool = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var fire_light: Node2D = $FireLight


func _ready() -> void:
	SignalBus.toggle_player_move.connect(allow_movement_inputs)
	SignalBus.player_activate_light.connect(_activate_light)

func _process(_delta: float) -> void:
	if _allow_movement:
		if Input.is_action_just_pressed("toggle_light"):
			match GameState.player_lights[GameState.current_light]:
				"none":
					pass
				"torch":
					fire_light.visible =  not(fire_light.visible)
				_:
					pass

func _activate_light()-> void:
	match GameState.player_lights[GameState.current_light]:
		"none":
			pass
		"torch":
			fire_light.visible = true
		_:
			pass

func allow_movement_inputs(allow : bool) -> void:
	_allow_movement = allow
	animated_sprite.play("idle")

func _physics_process(_delta: float) -> void:
	if _allow_movement:
		var direction_h := Input.get_axis("move_left", "move_right")
		if direction_h:
			velocity.x = direction_h * SPEED
			if direction_h > 0:
				animated_sprite.play("walk_right")
			else:
				animated_sprite.play("walk_left")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		var direction_v := Input.get_axis("move_up", "move_down")
		if direction_v:
			velocity.y = direction_v * SPEED
			if direction_v > 0:
				animated_sprite.play("walk_down")
			else:
				animated_sprite.play("walk_up")
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		
		if direction_h == 0 and direction_v == 0:
			animated_sprite.play("idle")

		move_and_slide()
