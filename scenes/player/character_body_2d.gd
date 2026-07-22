extends CharacterBody2D


@onready var movement: Movement = $Movement


var input_direction: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	_gather_input()
	movement.process_movement(input_direction, delta)
	move_and_slide()


func _gather_input() -> void:
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
