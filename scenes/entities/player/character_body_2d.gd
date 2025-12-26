extends CharacterBody2D

const SPEED = 100.0
var allow_movement : bool = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func allow_movement_inputs(allow : bool) -> void:
	movement_toggle(allow)

func movement_toggle(toggle: bool) -> void:
	allow_movement = toggle
	animated_sprite.play("idle")


func _physics_process(_delta: float) -> void:
	if allow_movement:
		var direction_h := Input.get_axis("ui_left", "ui_right")
		if direction_h:
			velocity.x = direction_h * SPEED
			if direction_h > 0:
				animated_sprite.play("walk_right")
			else:
				animated_sprite.play("walk_left")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		var direction_v := Input.get_axis("ui_up", "ui_down")
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
