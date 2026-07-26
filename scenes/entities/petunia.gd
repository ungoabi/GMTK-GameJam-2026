extends CharacterBody2D

@onready var weapons: Node2D = $Weapons
@onready var animation: AnimationPlayer = $AnimationPlayer

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
	health-=damage
	
func die():
	queue_free()
	
