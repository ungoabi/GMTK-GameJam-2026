extends CharacterBody2D


@onready var movement: Movement = $Movement

var direction: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	movement.process_movement(direction, delta)
	move_and_slide()
