class_name Enemy
extends CharacterBody2D

@export var health: int
@export var laser_range: int

@onready var animation_player: AnimationPlayer = $Animation/AnimationPlayer
@onready var movement: Movement = $Movement
@onready var laser: Weapon = $LaserGun
@onready var entity: Node2D = $".."
@onready var upgrade_pickup = preload("res://scenes/entities/pickups/pickup.tscn")
@onready var fuel_pickup = preload("res://scenes/entities/pickups/pickup_fuel.tscn")

var player: Node2D
var can_shoot: bool = false

func _ready() -> void:
	add_to_group("enemy")
	player = get_tree().get_first_node_in_group("player") as Node2D
	
	animation_player.play("boost")
	
	if randi_range(0,1) == 1:
		can_shoot = randi_range(0,1)
	if can_shoot == false:
		laser.queue_free()
	
	

func _physics_process(delta: float) -> void:
	var direction: Vector2 = (player.global_position - global_position).normalized()
	movement.process_movement(direction, delta)
	move_and_slide()
	look_at(player.global_position)
	
	if can_shoot == false:
		return
	elif global_position.distance_to(player.global_position) < laser_range and laser.fire_cooldown_timer.is_stopped():
		laser.shoot()
		laser.fire_cooldown_timer.wait_time += randf_range(-0.2, 0.2)
		


func take_damage(damage):
	health -= damage
	
	if health<1:
		die()

func die():
	
	if !can_shoot:
		var new_fuel_pickup = fuel_pickup.instantiate()
		new_fuel_pickup.global_position = global_position
		entity.add_child(new_fuel_pickup)
	
	if can_shoot and player.can_upgrade and player.level<6:
		var new_upgrade = upgrade_pickup.instantiate()
		new_upgrade.global_position = global_position
		entity.add_child(new_upgrade)
	
	can_shoot=false
	animation_player.play("explode")
	Audio.play_sfx(preload("res://assets/audio/sfx/explode/explosion (6).wav"))
	await animation_player.animation_finished
	
	queue_free()
