extends CharacterBody2D

@onready var projectile_scene: PackedScene = preload("res://scenes/projectiles/laser_enemy/laser_enemy.tscn")
@onready var beam_scene: PackedScene = preload("res://scenes/projectiles/beam/laser_beam.tscn")
@onready var attack_timer: Timer = $Attack_Timer
@onready var gunl: Marker2D = $GunL
@onready var gunr: Marker2D = $GunR
@onready var canl: Marker2D = $CannonL
@onready var canr: Marker2D = $CannonR
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var hit_sfx: AudioStream = preload("res://assets/audio/sfx/player/hitHurt (2).wav")
@onready var death_sfx: AudioStream = preload("res://assets/audio/sfx/player/death_explosion.wav")

var health:int = 750
var laser_ammo: int = 50
var player: Node2D

func _ready() -> void:
	add_to_group("boss")
	player = get_tree().get_first_node_in_group("player") as Node2D
	animation.play("flyin")
	await animation.animation_finished
	attack_timer.start()
	animation.play("idle")

func _process(delta: float) -> void:
	if health<1:
		die()

func _on_attack_timer_timeout() -> void:
	shoot_circle()
	
func take_damage(damage):
	Audio.play_sfx(hit_sfx)
	health-=damage
	
func die():
	Audio.stop_music()
	Audio.play_sfx(death_sfx)
	queue_free()

func shoot_circle():
	var shot_count = randi_range(6,12)
	var random = randi_range(0,1)
	
	for i in shot_count:
		var new_shot = projectile_scene.instantiate()
		
		if random>0:
			new_shot.global_position = canl.global_position
		else:
			new_shot.global_position = canr.global_position
		var angle = TAU * i / shot_count
		new_shot.direction = Vector2.RIGHT.rotated(angle).normalized()
		new_shot.rotation = angle
		get_tree().current_scene.add_child(new_shot)
		
		
