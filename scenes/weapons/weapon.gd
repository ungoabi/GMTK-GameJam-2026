class_name Weapon
extends Node2D


@export var projectile_scene: PackedScene
@export var fire_cooldown: float = 1
@export var weapon_sound: AudioStream

@onready var projectile_spawnpoints = $ProjectileSpawnpoints
@onready var fire_cooldown_timer: Timer = $FireCooldown
@onready var projectile_container: Node2D = get_tree().current_scene.get_node("World/Entity/Projectiles")


func _ready() -> void:
	fire_cooldown_timer.wait_time = fire_cooldown


func shoot() -> void:
	if not fire_cooldown_timer.is_stopped():
		return
	
	if projectile_scene:
		for marker: Marker2D in projectile_spawnpoints.get_children():
			_spawn_projectile(marker)
			Audio.play_sfx(weapon_sound)
		fire_cooldown_timer.start()


func _spawn_projectile(_marker: Marker2D) -> void:
	assert(false, "_spawn_projectile() must be implemented by child classes of Weapon")


func _random_offset(value: float) -> float:
	return randf_range(-value, value)
