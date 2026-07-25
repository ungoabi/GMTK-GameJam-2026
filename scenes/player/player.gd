extends CharacterBody2D

@onready var movement: Movement = $Movement
@onready var animation: Node = $Animation
@onready var weapons: Node = $Weapons
@onready var camera: Camera2D = $Camera2D

var input_direction: Vector2 = Vector2.ZERO
var input_shoot: bool = false
var input_debug_upgrade: bool = false


#move this to a shield scene
var shield_max: int
var shield_cd: int

func _ready() -> void:
	add_to_group("player")


func _physics_process(delta: float) -> void:
	_gather_input()
	movement.process_movement(input_direction, delta)
	if input_shoot:
		_shoot_weapons()
	move_and_slide()
	
	global_position.x = clamp(global_position.x, 0, camera.limit_right)
	global_position.y = clamp(global_position.y, 0, camera.limit_bottom)
	
	
	#debug remove later
	if input_debug_upgrade:
		for child in weapons.get_children():
			child.upgrade()
			print("weapons +1")

func _process(_delta: float) -> void:
	animation.animate()
	
	if GameStats.player_fuel<1:
		die()


func _gather_input() -> void:
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	input_shoot = Input.is_action_pressed("shoot")
	#debug remove later
	input_debug_upgrade = Input.is_action_just_pressed("debug_upgrade")

func _shoot_weapons() -> void:
	for weapon: Weapon in weapons.get_children():
		weapon.shoot()
		
func upgrade_laser():
	for weapon: Weapon in weapons.get_children():
		if weapon.is_in_group("laser"):
			weapon.upgrade()
			
func _on_fuel_timer_timeout() -> void:
	GameStats.player_fuel-=1
	
func die():
	queue_free()
