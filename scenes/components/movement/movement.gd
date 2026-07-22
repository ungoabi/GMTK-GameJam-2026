extends Node
class_name Movement


@export var max_speed: float = 10000
@export var acceleration: float = 100
@export var deceleration: float = 100

@onready var body: CharacterBody2D = get_parent()

func process_movement(direction: Vector2, delta: float) -> void:
	body.velocity = body.velocity.move_toward(direction * max_speed, acceleration * delta)
