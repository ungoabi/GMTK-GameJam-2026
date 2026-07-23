extends CharacterBody2D


@onready var movement: Movement = $Movement
@onready var animation: Node = $Animation
@onready var weapons: Node = $Weapons

var input_direction: Vector2 = Vector2.ZERO
var input_shoot: bool = false


func _ready() -> void:
	add_to_group("player")


func _physics_process(delta: float) -> void:
	_gather_input()
	movement.process_movement(input_direction, delta)
	if input_shoot:
		_shoot_weapons()
	move_and_slide()


func _process(_delta: float) -> void:
	animation.animate()


func _gather_input() -> void:
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	input_shoot = Input.is_action_pressed("shoot")


func _shoot_weapons() -> void:
	for weapon: Weapon in weapons.get_children():
		weapon.shoot()
