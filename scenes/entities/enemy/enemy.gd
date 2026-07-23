class_name Enemy
extends CharacterBody2D


@onready var movement: Movement = $Movement
var player: Node2D


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player") as Node2D

func _physics_process(delta: float) -> void:
	var direction: Vector2 = (player.global_position - global_position).normalized()
	movement.process_movement(direction, delta)
	move_and_slide()
	look_at(player.global_position)
