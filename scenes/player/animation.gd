extends Node


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var body: CharacterBody2D = get_parent()


func animate() -> void:
	set_animation()
	look_at_mouse()


func set_animation() -> void:
	if body.input_direction:
		animation_player.play("boost")
	else:
		animation_player.play("idle")


func look_at_mouse() -> void:
	body.look_at(body.get_global_mouse_position())
