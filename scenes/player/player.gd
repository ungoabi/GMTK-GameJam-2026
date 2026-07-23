extends CharacterBody2D


@onready var movement: Movement = $Movement
@onready var animation: AnimationPlayer = $%AnimationPlayer
@onready var sprite: Sprite2D = $%Sprite2D
@onready var laser_spawn: Marker2D = $%LaserSpawn
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var cooldown_timer: Timer = $%ShootCooldown

var input_direction: Vector2 = Vector2.ZERO
var can_shoot: bool = true

func _physics_process(delta: float) -> void:
	_gather_input()
	movement.process_movement(input_direction, delta)
	move_and_slide()
	
	#Checking if there is an input direction to play/stop the boost animation
	if input_direction:
		animation.play("boost")
	else:
		animation.stop()
		sprite.frame = 7
	
	#Code to make the ship look at the mouse during gameplay
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	#Detecting the shoot input
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()

func _gather_input() -> void:
	input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

#function to shoot a laser and activate the cooldown timer
func shoot() -> void:
	can_shoot = false
	cooldown_timer.start()
	const LASER = preload("res://scenes/player/laser.tscn")
	var new_laser = LASER.instantiate()
	new_laser.global_position = laser_spawn.global_position
	new_laser.global_rotation = laser_spawn.global_rotation
	laser_spawn.add_child(new_laser)
	%AudioStreamPlayer2D.play()
	#print("laser created")
	
#allowing the player to shoot when the cooldown timer is expired
func _on_shoot_cooldown_timeout() -> void:
	can_shoot=true
