@tool
extends ColorRect

@onready var StaticBody : StaticBody2D = $StaticBody2D
@onready var CollisionShape : CollisionShape2D = $StaticBody2D/CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var old_pos : Vector2 = self.position
	var new_pos : Vector2 = Vector2(0,0)
	new_pos.x = old_pos.x + (self.size.x / 2)
	new_pos.y = old_pos.y + (self.size.y / 2)
	CollisionShape.shape.set_size(self.size)
	StaticBody.global_position = new_pos
