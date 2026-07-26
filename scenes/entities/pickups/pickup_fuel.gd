class_name Pickup
extends Area2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var despawn_timer: Timer = $Despawn_Timer
@onready var life_timer: Timer = $Life_Timer
@onready var pickup_sfx: AudioStream = preload("res://assets/audio/sfx/powerup/powerUp (5).wav")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("fuel pickup collided")
	
	if body.is_in_group("player"):
		GameStats.player_fuel+=7
		Audio.play_sfx(pickup_sfx)
		queue_free()


func _on_despawn_timer_timeout() -> void:
	animation.play("despawn")
	life_timer.start()
	

func _on_life_timer_timeout() -> void:
	queue_free()
