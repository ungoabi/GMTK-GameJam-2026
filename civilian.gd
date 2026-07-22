extends CharacterBody2D


@export var min_wander_seconds: float = 0.2
@export var max_wander_seconds: float = 0.8

@onready var movement: Movement = $Movement
@onready var wander_timer: Timer = $Wander

var direction: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	if wander_timer.is_stopped():
		_start_random_wander_timer()
		_set_random_direction()
		wander_timer.start()
	movement.process_movement(direction, delta)
	move_and_slide()


func _start_random_wander_timer() -> void:
	wander_timer.wait_time = randf_range(min_wander_seconds, max_wander_seconds)


func _set_random_direction() -> void:
	direction = Vector2.UP.rotated(randf() * TAU)
