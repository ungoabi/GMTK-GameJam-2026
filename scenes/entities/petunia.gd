extends CharacterBody2D

@onready var weapons: Node2D = $Weapons
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
	animation.play("idle")

func _process(delta: float) -> void:
	if health<1:
		die()

func _on_attack_timer_timeout() -> void:
	pass
	
func take_damage(damage):
	Audio.play_sfx(hit_sfx)
	health-=damage
	
func die():
	Audio.stop_music()
	Audio.play_sfx(death_sfx)
	queue_free()
	
